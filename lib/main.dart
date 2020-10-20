import 'dart:io';

import 'package:base_framework/base_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async{
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  /// 强制竖屏, 因为设置竖屏为 `Future` 方法，防止设置无效可等返回值后再启动 App
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
      .then((value) {
    runApp(MyApp());
    if (Platform.isAndroid) {
      // Android状态栏透明 splash为白色, 所以调整状态栏文字为黑色
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light));
    }
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: RefreshConfiguration(
        // 列表数据不满一页, 不触发加载更多
        hideFooterWhenNotFull: false,
        headerBuilder: ()=>ClassicHeader(),
        footerBuilder: ()=>ClassicFooter(),
        autoLoad: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light, primaryColor: Colors.white,),
          darkTheme: ThemeData(brightness: Brightness.dark),
          locale: Locale('zh', 'CN'),
          localizationsDelegates: const [
            RefreshLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const <Locale>[
            Locale.fromSubtags(languageCode: 'zh'),
          ],
          navigatorKey: navigatorKey,
        ),
      ),
    );
  }
}
