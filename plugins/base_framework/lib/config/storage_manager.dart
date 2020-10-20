import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';

class StorageManager {
  /// 临时目录  （华为手机可能会随机删除这个目录下的文件）
  static Directory temporaryDirectory;

  ///应用目录
  static Directory appDirectory;

  ///外部存储 (仅限安卓)
  static Directory externalDirectory;

  /// 初始化必备操作 eg:user数据
  static LocalStorage localStorage;

  static init() async {
    await SpUtil.getInstance();
    temporaryDirectory = await getTemporaryDirectory();
    appDirectory = await getApplicationDocumentsDirectory();
    externalDirectory = await getExternalStorageDirectory();

    ///本地缓存基本都可以使用此工具
    ///后续页面可以同步使用
    ///
    localStorage = LocalStorage('LocalStorage');
    await localStorage.ready;
  }
}
