import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:semester_5_project_mobile_app/models/proxy_user_model.dart';

class AppStorage {
  final FlutterSecureStorage storage = new FlutterSecureStorage();

  Future<ProxyUser> getSignInData() async {
    try {
      final String id = await storage.read(key: 'id');
      final String token = await storage.read(key: 'token');
      if (id != null && token != null) {
        print('user from storage : ' + id);
        return ProxyUser(id: id, token: token);
      }
    } catch (err) {
      print(err.toString());
    }
    return null;
  }

  Future<void> storeSignInData(ProxyUser proxyUser) async {
    try {
      await storage.write(key: 'id', value: proxyUser.id);
      await storage.write(key: 'token', value: proxyUser.token);
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> clearStorage() async {
    try {
      await storage.deleteAll();
    } catch (err) {
      print(err.toString());
    }
  }
}
