import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base_framework/base_framework.dart';

class HomePage extends PageState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Awesome Flutter Demo',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FlatButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return LoadingDialog();
                  }),
              child: Text('加载中...')),
          ExpandableText(
            "文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo",
            expandText: '展开',
            collapseText: '隐藏',
            maxLines: 4,
            expandColor: Color(0xFFF22C2C),
            collapseColor: Color(0xff3970FB),
            expandImage: 'assets/down.png',
            collapseImage: 'assets/up.png',
            imageHeight: 15,
            imageWidth: 15,
          ),
        ],
      ),
    );
  }
}

class LoadingDialog extends Dialog {
  final String msg;

  LoadingDialog({this.msg: 'loading...'})
      : super(
          insetAnimationCurve: Curves.elasticOut,
    insetAnimationDuration: Duration(seconds: 3)
        );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: new Material(
        //创建透明层
        type: MaterialType.transparency, //透明类型
        child: new Center(
          //保证控件居中效果
          child: new SizedBox(
            width: 120.0,
            height: 120.0,
            child: new Container(
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new CupertinoActivityIndicator(
                    radius: 20,
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                    ),
                    child: new Text(
                      msg,
                      style: new TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
