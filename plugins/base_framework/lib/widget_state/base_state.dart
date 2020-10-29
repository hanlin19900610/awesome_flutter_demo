import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../base_framework.dart';

/// * 请勿直接继承此类
/// * 如果是页面，继承 [PageState]
/// * 如果是view，继承 [WidgetState]
/// * 如果是stateless widget， 继承 [BaseStatelessWidget]
///
/// 此处扩展功能应该是 page和view通用功能

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  ///去掉 scroll view的 水印  e.g : listView scrollView
  ///当滑动到顶部或者底部时，继续拖动出现的蓝色水印
  Widget getNoInkWellListView({@required Widget scrollView}) {
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: scrollView,
    );
  }

  ///占位widget
  Widget getSizeBox({double width = 1, double height = 1}) {
    return SizedBox(
      width: width,
      height: height,
    );
  }

  YYDialog _loadingDialog;

  showProgressDialog() {
    if(_loadingDialog == null) {
      _loadingDialog = YYDialog().build(context)
        ..width = 150.h
        ..height = 150.h
        ..backgroundColor = Colors.white
        ..borderRadius = 10.h
        ..barrierDismissible = false
        ..widget(
            Container(
              width: 150.h,
              height: 150.h,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CupertinoActivityIndicator(
                    radius: 15.h,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    '加载中...',
                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                  ),
                ],
              ),
            )
        )
        ..animatedFunc = (child, animation) {
          return ScaleTransition(
            child: child,
            scale: Tween(begin: 0.0, end: 1.0).animate(animation),
          );
        };
    }
    _loadingDialog.show();
  }

  dismissProgressDialog() {
    if(_loadingDialog != null && _loadingDialog.isShowing){
      _loadingDialog.dismiss();
      _loadingDialog = null;
    }
  }

  /*
  * size adapter with tool ScreenUtil
  *
  * */


  ///屏幕宽度
  double screenWidth() => ScreenUtil.getInstance().screenWidth;

  ///屏幕高度
  double screenHeight() => ScreenUtil.getInstance().screenHeight;
}

///widget生成器
///并且装配原flutter Widget的功能

mixin WidgetGenerator on BaseState implements _RouteGenerator, _NavigateActor {
  ///为state生成widget
  Widget generateWidget({Key key}) {
    return _CommonWidget(
      state: this,
      key: key,
    );
  }

  /// [routeName]  => 你的页面类名
  @override
  PageRoute<T> buildRoute<T>(Widget page, String routeName,
      {PageAnimation animation = PageAnimation.Non, Object args}) {
    assert(routeName != null && routeName.isNotEmpty,
        'route name must be not empty !');
    var r = RouteSettings(name: routeName, arguments: args);

    switch (animation) {
      case PageAnimation.Fade:
        return pageBuilder.wrapWithFadeAnim(page, r);
      case PageAnimation.Scale:
        return pageBuilder.wrapWithScaleAnim(page, r);
      case PageAnimation.Slide:
        return pageBuilder.wrapWithSlideAnim(page, r);
      default:
        return pageBuilder.wrapWithNoAnim(page, r);
    }
  }

  ///@param animation : page transition's animation
  ///see details in [PageAnimationBuilder]
  @override
  Future push<T extends PageState>(T targetPage, {PageAnimation animation}) {
    assert(targetPage != null, 'the target page must not null !');
    FocusScope.of(context)?.unfocus();
    return Navigator.of(context).push(buildRoute(
        targetPage.generateWidget(), targetPage.runtimeType.toString(),
        animation: animation));
  }

  @override
  Future pushReplacement<T extends Object, TO extends PageState>(TO targetPage,
      {PageAnimation animation, T result}) {
    assert(targetPage != null, 'the target page must not null !');
    FocusScope.of(context)?.unfocus();
    return Navigator.of(context).pushReplacement(
        buildRoute(
            targetPage.generateWidget(), targetPage.runtimeType.toString(),
            animation: animation),
        result: result);
  }

  @override
  Future pushAndRemoveUntil<T extends PageState>(T targetPage,
      {PageAnimation animation, RoutePredicate predicate}) {
    assert(targetPage != null, 'the target page must not null !');
    FocusScope.of(context)?.unfocus();
    return Navigator.of(context).pushAndRemoveUntil(
        buildRoute(
            targetPage.generateWidget(), targetPage.runtimeType.toString(),
            animation: animation),
        predicate ?? (route) => false);
  }

  @override
  void pop<T extends Object>({T result}) {
    Navigator.of(context).pop(result);
  }

  @override
  void popUntil({RoutePredicate predicate}) {
    Navigator.of(context).popUntil(predicate ?? (route) => false);
  }

  @override
  bool canPop() {
    return Navigator.of(context).canPop();
  }
}

///构建 route

abstract class _RouteGenerator {
  PageRoute<T> buildRoute<T>(Widget page, String routeName,
      {PageAnimation animation, Object args});
}

///路由操作
abstract class _NavigateActor {
  Future push<T extends PageState>(T targetPage, {PageAnimation animation});

  Future pushAndRemoveUntil<T extends PageState>(T targetPage,
      {PageAnimation animation, RoutePredicate predicate});

  Future pushReplacement<T extends Object, TO extends PageState>(TO targetPage,
      {PageAnimation animation, T result});

  void pop<T extends Object>({
    T result,
  });

  void popUntil({RoutePredicate predicate});

  bool canPop();
}

class _CommonWidget extends StatefulWidget {
  final State state;

  const _CommonWidget({Key key, this.state}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return state;
  }
}
