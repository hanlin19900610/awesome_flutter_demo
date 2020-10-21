
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base_framework/base_framework.dart';

class CircleProgressWidget extends BaseStatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75.w,
      height: 75.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.5.h),
        color: Colors.white,
      ),
      child: Container(
        width: 30.w,
        height: 30.w,
        child: CircularProgressIndicator(),
      ),
    );
  }

}

///显示progress 方式 1
///这种方式，需要在布局中添加FullPageCircleProgressWidget
class FullPageCircleProgressWidget extends BaseStatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width,
//      height: getWidthPx(1334),
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      color: Color.fromRGBO(34, 34, 34, 0.3),
      child: CircleProgressWidget(),
    );
  }

}

///显示progress 方式 2
///这种方式，不需要在布局中添加

class LoadingProgressState extends WidgetState {

  final Widget progress;
  final Color bgColor;
  //final LoadingCreate loadingCreate;
  final DialogLoadingController controller;

  LoadingProgressState({this.progress, this.bgColor, this.controller});


  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if(controller.isShow){
        //todo
      }else{
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.of(context).pop();
        });
      }
    });
  }

  @override
  void dispose() {
    controller.isShow = false;
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      color: bgColor??Color.fromRGBO(34, 34, 34, 0.3),
      width: size.width,height: size.height,
      alignment: Alignment.center,
      child:progress?? CircularProgressIndicator(),
    );
  }
}

class DialogLoadingController extends ChangeNotifier{
  bool isShow = true;
  dismissDialog(){
    isShow = false;
    notifyListeners();
  }
}










