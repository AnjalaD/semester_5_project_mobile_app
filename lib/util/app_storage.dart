import 'package:semester_5_project_mobile_app/models/proxy_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  SharedPreferences storage;
  AppStorage() {
    _getInstance();
  }

  Future<void> _getInstance() async {
    storage = await SharedPreferences.getInstance();
  }

  Future<ProxyUser> getSignInData() async {
    try {
      final String id = storage.getString('id');
      final String token = storage.getString('token');
      if (id != null && token != null) {
        print('user from storage : ' + id);
        return ProxyUser(id: id, token: token);
      }
    } catch (err) {
      print('getSignIn data storage error: $err');
    }
    clearStorage();
    return null;
  }

  Future<void> storeSignInData(ProxyUser proxyUser) async {
    try {
      await storage.setString('id', proxyUser.id);
      await storage.setString('token', proxyUser.token);
    } catch (err) {
      print('store signin data error :$err');
    }
  }

  Future<void> clearStorage() async {
    try {
      await storage.remove('id');
      await storage.remove('token');
    } catch (err) {
      print('clearStorage error : $err');
    }
  }
}
