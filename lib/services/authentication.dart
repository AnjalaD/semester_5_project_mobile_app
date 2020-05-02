import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:semester_5_project_mobile_app/constants/api.dart';
import 'package:semester_5_project_mobile_app/models/proxy_user_model.dart';
import 'package:semester_5_project_mobile_app/models/user_model.dart';
import 'package:semester_5_project_mobile_app/util/app_storage.dart';

class Authentication extends ChangeNotifier {
  final Dio _dio = new Dio();
  final AppStorage storage = AppStorage();

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
    _isLoading = true;
    notifyListeners();
    _proxyUser = await storage.getSignInData();
    if (_proxyUser != null) {
      print('user from storage' + _proxyUser.toJson().toString());
      try {
        await _getUser();
      } catch (err) {
        print(err.toString());
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  ///signIn to system
  Future<void> signIn(
      {@required String nic,
      @required String password,
      bool keepSignedIn}) async {
    _isLoading = true;
    notifyListeners();

    try {
      Response response = await _dio.post(
        Api.kSignInApi,
        data: {
          "nic": nic,
          "password": password,
        },
        options: Options(
          validateStatus: (status) {
            return true;
          },
        ),
      );
      Map<String, dynamic> data = _responseHandler(response);
      _proxyUser = ProxyUser.fromJson(data);
      // print(_proxyUser.toJson());
      if (keepSignedIn) {
        print('storing user data : ' + _proxyUser.toJson().toString());
        storage.storeSignInData(_proxyUser);
      }
      await _getUser();
    } catch (err) {
      print(err.toString());
    }

    _isLoading = false;
    notifyListeners();
  }

  /// register a new user
  Future<void> register({@required User user}) async {
    _isLoading = true;
    notifyListeners();

    try {
      Response response = await _dio.post(
        Api.kSignUpApi,
        data: user.toJson(),
        options: Options(
          validateStatus: (status) {
            print(status);
            return true;
          },
        ),
      );
      print(response.toString());
      Map<String, dynamic> data = _responseHandler(response);
      _proxyUser = ProxyUser.fromJson(data);
      print(_proxyUser.toJson());
      await _getUser();
    } catch (err) {
      print(err.toString());
    }

    _isLoading = false;
    print(_isLoading);
    notifyListeners();
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();
    try {
      await storage.clearStorage();
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
    try {
      Response response = await _dio.get(
        "${Api.kGetUserApi}/${_proxyUser.id}",
        options: Options(
          headers: {
            "Auth": _proxyUser.token,
          },
          validateStatus: (status) {
            return true;
          },
        ),
      );
      // print(response.data["userdata"]);
      Map<String, dynamic> data = _responseHandler(response);
      _user = new User.fromJson(data["userdata"]);
      return true;
    } catch (err) {
      print(err.toString());
    }

    _proxyUser = null;
    return false;
  }

  dynamic _responseHandler(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 401:
        throw response.data["message"];
      case 406:
        throw response.data["message"];
      default:
        throw "Unexpected error occured :${response.statusCode}";
    }
  }
}
