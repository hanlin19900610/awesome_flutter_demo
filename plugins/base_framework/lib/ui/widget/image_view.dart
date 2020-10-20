import 'dart:io';

import 'package:cached_network_image_builder/cached_network_image_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base_framework/base_framework.dart';

/// 支持本地和网络路径
class ImageView extends StatelessWidget {
  final String url;
  final String errorImg;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius borderRadius;

  const ImageView({
    Key key,
    this.url,
    this.errorImg,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0.0),
      child: CachedNetworkImageBuilder(
        url: url,
        builder: (File image) {
          return Image.file(
            image,
            width: width,
            height: height,
            fit: fit,
          );
        },
        placeHolder: ImageHelper.placeHolder(width: width, height: height),
        errorWidget: errorImg == null
            ? ImageHelper.error(width: width, height: height)
            : SizedBox(
                width: width,
                height: height,
                child: Image.asset(
                  errorImg,
                  width: width,
                  height: height,
                ),
              ),
      ),
    );
  }
}

class HeadImageView extends StatelessWidget {
  final String url;
  final String errorImg;
  final double width;
  final double height;
  final BoxFit fit;

  const HeadImageView({
    Key key,
    this.url,
    this.width,
    this.height,
    this.fit,
    this.errorImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImageBuilder(
        url: url,
        builder: (File image) {
          return Image.file(
            image,
            width: width,
            height: height,
            fit: fit,
          );
        },
        placeHolder: ImageHelper.placeHolder(width: width, height: height),
        errorWidget: errorImg == null
            ? ImageHelper.error(width: width, height: height)
            : SizedBox(
                width: width,
                height: height,
                child: Image.asset(
                  errorImg,
                  width: width,
                  height: height,
                ),
              ),
      ),
    );
  }
}
