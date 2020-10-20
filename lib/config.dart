class Config {
  // 是否为Debug模式
  static bool isTest = true;
  // 网络访问地址
  static var baseUrl = isTest ? 'http://taoke.lnkj6.com/index.php?s=/api/' : 'http://taoke.lnkj6.com/index.php?s=/api/';

}