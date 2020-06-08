import 'package:semester_5_project_mobile_app/models/proxy_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static Future<ProxyUser> getSignInData() async {
    final storage = await SharedPreferences.getInstance();
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

  static Future<void> storeSignInData(ProxyUser proxyUser) async {
    final storage = await SharedPreferences.getInstance();
    try {
      await storage.setString('id', proxyUser.id);
      await storage.setString('token', proxyUser.token);
    } catch (err) {
      print('save signIn data error :$err');
    }
    String id = storage.getString('id');
    String token = storage.getString('token');
    print('check saved: $id, $token');
  }

  static Future<void> clearStorage() async {
    final storage = await SharedPreferences.getInstance();
    try {
      await storage.remove('id');
      await storage.remove('token');
    } catch (err) {
      print('clearStorage error : $err');
    }
  }
}
