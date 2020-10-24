import 'package:flutter/material.dart';
import 'package:base_framework/base_framework.dart';

class HomePage extends PageState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Awesome Flutter Demo',),
        centerTitle: true,
      ),
      body: Center(
        child: ExpandableText(
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
      ),
    );
  }
}
