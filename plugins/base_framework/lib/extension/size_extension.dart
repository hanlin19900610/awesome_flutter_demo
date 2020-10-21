
import '../base_framework.dart';
/// 屏幕适配封装
extension SizeExtension on num {
  ///[ScreenUtil.getWidth]
  num get w => ScreenUtil().getWidth(this);

  ///[ScreenUtil.getHeight]
  num get h => ScreenUtil().getHeight(this);

  ///[ScreenUtil.getSp]
  num get sp => ScreenUtil().getSp(this);
}
