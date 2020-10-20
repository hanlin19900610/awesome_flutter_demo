import '../base_framework.dart';

abstract class SingleViewStateModel<T> extends ViewStateModel {
  T data;

  initData() async {
    setBusy(true);
    await fetchData(fetch: true);
  }

  fetchData({bool fetch = false}) async {
    try {
      T temp = await loadData();
      if (temp == null) {
        setEmpty();
      } else {
        onCompleted(temp);
        data = temp;
        if (fetch) {
          setBusy(false);
        } else {
          notifyListeners();
        }
      }
    } catch (e, s) {
      ExceptionHandler.getInstance().handleException(this, e, s);
    }
  }

  Future<T> loadData();

  onCompleted(T data);
}
