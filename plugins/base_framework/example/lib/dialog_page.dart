import 'package:base_framework/base_framework.dart';
import 'package:flutter/material.dart';

class DialogPage extends PageState {
  @override
  Widget build(BuildContext context) {
    return switchStatusBar2Dark(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('文本折叠Demo'),
        ),
        body: Column(
          children: [
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
            ExpandableText(
              "文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo文本折叠Demo",
              expandText: '展开',
              collapseText: '隐藏',
              maxLines: 4,
              expandColor: Color(0xFFF22C2C),
              collapseColor: Color(0xff3970FB),
              expandView: Container(
                width: double.infinity,
                height: 50.h,
                color: Colors.white,
                alignment: Alignment.center,
                child: Text(
                  '展开',
                  style: TextStyle(color: Color(0xFFF22C2C)),
                ),
              ),
              collapseView: Container(
                width: double.infinity,
                height: 50.h,
                color: Colors.white,
                alignment: Alignment.center,
                child: Text(
                  '收起',
                  style: TextStyle(color: Color(0xff3970FB)),
                ),
              ),
            ),
            RaisedButton(onPressed: (){
              showProgressDialog();
              Future.delayed(Duration(seconds: 3), (){
                dismissProgressDialog();
              });
            }, child: Text('对话框'),),
            // RaisedButton(
            //   onPressed: () {
            //     _launchURL(
            //         'mqqapi://card/show_pslcard?src_type=internal&version=1&card_type=group&uin=113874750');
            //   },
            //   child: Text('QQ群聊'),
            // ),
            // RaisedButton(
            //   onPressed: () {
            //     _launchURL(
            //         'mqqapi://card/show_pslcard?src_type=internal&version=1&uin=532832788');
            //   },
            //   child: Text('查看QQ联系人详情'),
            // ),
            // RaisedButton(
            //   onPressed: () {
            //     _launchURL(
            //         'mqqapi://card/show_pslcard?src_type=internal&version=1&uin=113874750&card_type=group&source=qrcode');
            //   },
            //   child: Text('添加&打开QQ群'),
            // ),
            // RaisedButton(onPressed: (){
            //   _launchURL('mqqwpa://im/chat?chat_type=wpa&uin=113874750');
            // }, child: Text('打开聊天界面'),),
          ],
        ),
      ),
    );
  }
}
