import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:base_framework/base_framework.dart';

import '../config.dart';
import '../main.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = Config.baseUrl;
    interceptors..add(ApiInterceptor());
  }
}


class ApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    ///这里将空值参数去除掉，可根据自己的需求更改
    options.queryParameters.removeWhere((key, value) => value == null);

    String params="";
    String mark = "&";

    var token = StorageManager.localStorage.getItem('kToken');
    if(token != null && token.isNotEmpty) {
      if( options.data is FormData){
        (options.data as FormData).fields.add(MapEntry('token', token));
      }else{
        options.data = FormData.fromMap({'token': token});
      }
      options.queryParameters['token'] = token;
    }
    if(!kReleaseMode){
      debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
          ' queryParameters: ${options.queryParameters}'
              ' formdata  : ${options.data.toString()}' );
      options.queryParameters.forEach((k,v){
        if(v == null) return;
        params = "$params${params.isEmpty?"":mark}$k=$v";
      });
      debugPrint("---api-request--->url--> ${options.baseUrl}${options.path}?$params");
      debugPrint("request header  :  ${options.headers.toString()}");
    }
    return options;
  }

  @override
  onResponse(Response response) {
    ResponseData respData = ResponseData.fromJson(response.data);
    if (respData.success) {
      response.data = respData.data;
      response.statusMessage = respData.message;
      return http.resolve(response);
    } else {
      // TODO 全局处理异常
//       if (respData.code == -1) {
//         BuildContext context = navigatorKey.currentState.overlay.context;
// //        context.read<UserModel>().clearUser();
// //        Routers.navigateTo(context, Routers.loginPage, replace: true);
//         throw const UnAuthorizedException(); // 需要登录
//       } else {
//         throw NotSuccessException.fromRespData(respData);
//       }
    }
  }
}

class ResponseData extends BaseResponseData {
  bool get success => 1 == code;

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['status'];
    message = json['info'];
    data = json['data'];
  }
}