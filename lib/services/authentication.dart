import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:semester_5_project_mobile_app/models/proxy_user_model.dart';
import 'package:semester_5_project_mobile_app/models/user_model.dart';
import 'package:semester_5_project_mobile_app/services/notification.dart';
import 'package:semester_5_project_mobile_app/util/app_storage.dart';
import 'package:semester_5_project_mobile_app/util/request_handler.dart';

class Authentication extends ChangeNotifier {
  final Dio _dio = new Dio();
  final AppStorage _storage = AppStorage();

  bool _isLoading = false;
  ProxyUser _proxyUser;
  User _user;

  bool get isLoading => _isLoading;
  ProxyUser get proxyUser => _proxyUser;
  User get user => _user;

  Authentication() {
    _signInFromLocalData();
  }

  Future<void> _signInFromLocalData() async {
    // _isLoading = true;
    // notifyListeners();
    // _proxyUser = await _storage.getSignInData();
    // if (_proxyUser != null) {
    //   print('user from storage' + _proxyUser.toJson().toString());
    //   try {
    //     if (await _getUser()) {
    //       new Fcm();
    //     }
    //   } catch (err) {
    //     print(err.toString());
    //   }
    // }
    // _isLoading = false;
    // notifyListeners();

    _proxyUser = new ProxyUser(id: '1234', token: '1242');
    _user = new User(
        firstName: 'Anjala',
        lastName: 'Dilhara',
        addressLine1: '123/a',
        addressLine2: '',
        city: 'Ranala',
        dob: '2013-12-12',
        email: 'anja@i.com',
        nic: '918123123',
        telephoneNumber: '1212414124');
    new NotificationService();
  }

  ///signIn to system
  Future<void> signIn(
      {@required String nic,
      @required String password,
      bool keepSignedIn}) async {
    _isLoading = true;
    notifyListeners();

    Map<String, dynamic> data =
        ApiRequestHandler.login(nic: nic, password: password);
    if (data != null) {
      _proxyUser = ProxyUser.fromJson(data);
      // print(_proxyUser.toJson());
      if (keepSignedIn) {
        print('storing user data : ' + _proxyUser.toJson().toString());
        _storage.storeSignInData(_proxyUser);
      }
      await _getUser();
    }

    _isLoading = false;
    notifyListeners();
  }

  /// register a new user
  Future<void> register({@required User user}) async {
    _isLoading = true;
    notifyListeners();

    Map<String, dynamic> data = ApiRequestHandler.register(user);
    if (data != null) {
      _proxyUser = ProxyUser.fromJson(data);
      print(_proxyUser.toJson());
      await _getUser();
    }

    _isLoading = false;
    print(_isLoading);
    notifyListeners();
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _storage.clearStorage();
    } catch (err) {
      print(err.toString());
    }
    _proxyUser = null;
    _user = null;
    _isLoading = false;
    notifyListeners();
  }

  /// get user data
  /// [_proxyUser] should not be null
  /// if successfull create [_user]
  /// else [_user] set to null
  _getUser() async {
    // print(response.data["userdata"]);
    Map<String, dynamic> data = ApiRequestHandler.getUserInfo(
      userId: _proxyUser.id,
      token: _proxyUser.token,
    );
    if (data != null) {
      _user = new User.fromJson(data["userdata"]);
      return true;
    }
    _proxyUser = null;
    return false;
  }
}
