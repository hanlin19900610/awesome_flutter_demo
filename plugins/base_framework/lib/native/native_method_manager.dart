import 'dart:io';

import 'package:flutter/services.dart';

class NativeMethodManager {
  static const MethodChannel _channel =
      const MethodChannel('com.mufeng.base_framework');

  static final String methodInstall = 'install_apk';

  static NativeMethodManager _singleton;

  static NativeMethodManager getInstance() {
    if (_singleton == null) {
      _singleton = NativeMethodManager._();
    }
    return _singleton;
  }

  NativeMethodManager._();

  void installApk(String path) async {
    ///ios建议直接取应用市场
    if (Platform.isAndroid) {
      await _channel.invokeMethod(methodInstall, {"path": path});
    }
  }
}
