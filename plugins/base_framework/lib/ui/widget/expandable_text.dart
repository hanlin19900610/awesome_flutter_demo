import 'package:extended_text/extended_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    Key key,
    @required this.expandText,
    @required this.collapseText,
    @required this.expandColor,
    @required this.collapseColor,
    this.expandImage,
    this.collapseImage,
    this.imageHeight,
    this.imageWidth,
    this.expanded = false,
    this.style,
    this.textDirection,
    this.textAlign,
    this.textScaleFactor,
    this.maxLines = 2,
    this.semanticsLabel,
  })  : assert(text != null),
        assert(expandText != null),
        assert(collapseText != null),
        assert(expanded != null),
        assert(maxLines != null && maxLines > 0),
        assert(expandImage == null ||
            collapseImage == null ||
            (expandImage != null &&
                collapseImage != null &&
                imageHeight != null &&
                imageWidth != null)),
        super(key: key);

  final String text;
  final String expandText;
  final String collapseText;
  final bool expanded;
  final Color expandColor;
  final Color collapseColor;
  final String expandImage;
  final String collapseImage;
  final double imageHeight;
  final double imageWidth;
  final TextStyle style;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final double textScaleFactor;
  final int maxLines;
  final String semanticsLabel;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _expanded = false;
  bool hasImage = false;
  TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _expanded = widget.expanded;
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = _toggleExpanded;
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() => _expanded = !_expanded);
  }

  @override
  Widget build(BuildContext context) {
    // 是否显示图片
    hasImage = widget.collapseImage != null && widget.collapseImage != null;
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle effectiveTextStyle = widget.style;
    if (widget.style == null || widget.style.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    }

    final textAlign =
        widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start;
    final textDirection = widget.textDirection ?? Directionality.of(context);
    final textScaleFactor =
        widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context);
    final locale = Localizations.localeOf(context, nullOk: true);

    // 展开 隐藏的文本
    final linkText =
        _expanded ? ' ${widget.collapseText}' : '${widget.expandText}';

    // 展开 隐藏的文本颜色
    final linkColor = _expanded ? widget.collapseColor : widget.expandColor;

    final link = TextSpan(
      text: linkText,
      style: effectiveTextStyle.copyWith(
        color: linkColor,
      ),
      recognizer: _tapGestureRecognizer,
    );

    // 展开和隐藏的图标
    final images = hasImage
        ? ImageSpan(
            _expanded
                ? AssetImage(widget.collapseImage)
                : AssetImage(widget.expandImage),
            imageWidth: widget.imageWidth,
            imageHeight: widget.imageHeight)
        : TextSpan();
    final endSpan = TextSpan(
      style: effectiveTextStyle,
      children: [link, images],
    );

    final text = TextSpan(
      text: widget.text,
      style: effectiveTextStyle,
    );

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        TextPainter textPainter = TextPainter(
          text: link,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaleFactor: textScaleFactor,
          maxLines: widget.maxLines,
          locale: locale,
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        // textPainter.text = images;
        // textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        // final imagesSize = textPainter.size;

        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;

        final position = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width - widget.imageWidth??0,
          textSize.height,
        ));
        final endOffset = textPainter.getOffsetBefore(position.offset);

        TextSpan textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            style: effectiveTextStyle,
            text: _expanded
                ? widget.text
                : '${widget.text.substring(0, hasImage ? endOffset : endOffset)}...',
            children: [endSpan],
          );
        } else {
          textSpan = text;
        }

        return RichText(
          text: textSpan,
          softWrap: true,
          textDirection: textDirection,
          textAlign: textAlign,
          textScaleFactor: textScaleFactor,
          overflow: TextOverflow.clip,
        );
      },
    );
    if (widget.semanticsLabel != null) {
      result = Semantics(
        textDirection: widget.textDirection,
        label: widget.semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        ),
      );
    }

    return result;
  }
}
