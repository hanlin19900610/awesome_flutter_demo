
import 'package:flutter/material.dart';
import 'package:mmkv_flutter/mmkv_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../base_framework.dart';

/// 基于
abstract class RefreshListViewStateModel<T> extends ListViewStateModel<T> {


  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  /// 当前页码
  int _currentPageNum = 1;
  get currentPageNum => pageNumFirst;
  ///每页加载数量
  get pageDataSize => pageSize;

  /// 下拉刷新
  Future<List<T>> refresh({bool init = false}) async {
    try {
      _currentPageNum = pageNumFirst;
      list.clear();
      var data = await loadData(pageNum: pageNumFirst);
      if (data == null || data.isEmpty) {
        setEmpty();
      } else {
        onCompleted(data);
        list.addAll(data);
        refreshController.refreshCompleted();
        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          //防止上次上拉加载更多失败,需要重置状态
          refreshController.loadComplete();
        }
        if (init) {
          firstInit = false;
          //改变页面状态为非加载中
          setBusy(false);
        } else {
          notifyListeners();
        }
        onRefreshCompleted();
        ///第一次加载且已注册缓存功能的，才进行缓存
        if(init && cacheDataFactory != null){
          cacheRefreshData();
        }
      }
      return data;
    } catch (e, s) {
      ExceptionHandler.getInstance().handleException(this, e, s);
      return null;
    }
  }

  cacheRefreshData()async{
    final mmkv = await MmkvFlutter.getInstance();
    int i=0;
    for(String str in cacheDataFactory.cacheListData()){
      await mmkv.setString('${this.runtimeType.toString()}$i',str);
      i +=1;
    }

  }

  /// 上拉加载更多
  Future<List<T>> loadMore() async {
    try {
      var data = await loadData(pageNum: ++_currentPageNum);
      if (data.isEmpty) {
        _currentPageNum--;
        refreshController.loadNoData();
      } else {
        onCompleted(data);
        list.addAll(data);
        if (data.length < pageSize) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        notifyListeners();
      }
      return data;
    } catch (e, s) {
      _currentPageNum--;
      refreshController.loadFailed();
      debugPrint('error--->\n' + e.toString());
      debugPrint('statck--->\n' + s.toString());
      return null;
    }
  }

  // 加载数据
  Future<List<T>> loadData({int pageNum});

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
