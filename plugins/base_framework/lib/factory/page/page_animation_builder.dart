import 'package:flutter/material.dart';
import '../../ui/index.dart';

///后期对此扩建

final PageAnimationBuilder pageBuilder = PageAnimationBuilder.getInstance();

enum PageAnimation { Fade, Scale, Slide, Non }

class PageAnimationBuilder {
  static PageAnimationBuilder singleton;

  static PageAnimationBuilder getInstance() {
    if (singleton == null) {
      singleton = PageAnimationBuilder._();
    }
    return singleton;
  }

  PageAnimationBuilder._();

  ///

  Route<dynamic> wrapWithNoAnim(Widget page, RouteSettings routeSettings) {
    return NoAnimRouteBuilder(page, routeSettings);
  }

  ///fade
  Route<dynamic> wrapWithFadeAnim(Widget page, RouteSettings routeSettings) {
    return FadeRouteBuilder(page, routeSettings);
  }

  ///slide
  Route<dynamic> wrapWithSlideAnim(Widget page, RouteSettings routeSettings) {
    return SlideRightRouteBuilder(page, routeSettings);
  }

  Route<dynamic> wrapWithSlideTopAnim(
      Widget page, RouteSettings routeSettings) {
    return SlideTopRouteBuilder(page, routeSettings);
  }

  ///scale
  Route<dynamic> wrapWithScaleAnim(Widget page, RouteSettings routeSettings) {
    return ScaleRouteBuilder(page, routeSettings);
  }
}
