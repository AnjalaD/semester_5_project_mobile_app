import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/foundation.dart';
import 'package:semester_5_project_mobile_app/models/proxy_user_model.dart';
import 'package:semester_5_project_mobile_app/models/update_user_model.dart';
import 'package:semester_5_project_mobile_app/services/background_task.dart';
import 'package:semester_5_project_mobile_app/util/classes/response.dart';
import 'package:semester_5_project_mobile_app/models/user_model.dart';
import 'package:semester_5_project_mobile_app/services/notification.dart';
import 'package:semester_5_project_mobile_app/util/app_storage.dart';
import 'package:semester_5_project_mobile_app/util/request_handler.dart';

class Authentication extends ChangeNotifier {
  final AppStorage _storage = AppStorage();

  bool _isLoading = false;
  ProxyUser _proxyUser;
  User _user;

  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  ProxyUser get proxyUser => _proxyUser;
  User get user => _user;

  void updateUser(UpdateUser updateUser) {
    _user.addressLine1 = updateUser.addressLine1;
    _user.addressLine2 = updateUser.addressLine2;
    _user.city = updateUser.city;
    _user.email = updateUser.email;
    _user.telephoneNumber = updateUser.telephoneNumber;
    notifyListeners();
  }

  Authentication() {
    _signInFromLocalData();
  }

  Future<void> _signInFromLocalData() async {
    _isLoading = true;
    notifyListeners();
    _proxyUser = await _storage.getSignInData();
    if (_proxyUser != null) {
      print('user from storage' + _proxyUser.toJson().toString());
      if (await _getUser()) {
        // new NotificationService();
      }
    }
    _isLoading = false;
    notifyListeners();

    // _proxyUser = new ProxyUser(id: '1234', token: '1242');
    // _user = new User(
    //     firstName: 'Anjala',
    //     lastName: 'Dilhara',
    //     addressLine1: '123/a',
    //     addressLine2: '',
    //     city: 'Ranala',
    //     dob: '2013-12-12',
    //     email: 'anja@i.com',
    //     nic: '918123123',
    //     telephoneNumber: '1212414124');
    // new NotificationService();
  }

  ///signIn to system
  Future<String> signIn(
      {@required String nic,
      @required String password,
      bool keepSignedIn}) async {
    _isLoading = true;
    notifyListeners();

    ProcessedResponse response = await ApiRequestHandler.login(
      nic: nic,
      password: password,
    );
    if (response.error == null) {
      print('responsedata: ' + response.data.toString());
      _proxyUser = ProxyUser.fromJson(response.data);
      // print(_proxyUser.toJson());
      if (keepSignedIn) {
        print('storing user data : ' + _proxyUser.toJson().toString());
        _storage.storeSignInData(_proxyUser);
      }
      await _getUser();
    }

    _isLoading = false;
    notifyListeners();
    return response.error;
  }

  /// register a new user
  Future<String> register({@required User user}) async {
    _isLoading = true;
    notifyListeners();

    ProcessedResponse response = await ApiRequestHandler.register(user);
    if (response.error == null) {
      _proxyUser = ProxyUser.fromJson(response.data);
      print('proxyUser :_${proxyUser.toJson()}');
      await _getUser();
    }

    _isLoading = false;
    notifyListeners();
    return response.error;
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _storage.clearStorage();
    } catch (err) {
      print('signOut cleanStorage error: ${err.toString()}');
    }
    BackgroundFetch.stop();
    _proxyUser = null;
    _user = null;
    _isLoading = false;
    notifyListeners();
  }

  /// get user data
  /// [_proxyUser] should not be null
  /// if successfull create [_user]
  /// else [_user] set to null
  Future<bool> _getUser() async {
    ProcessedResponse response = await ApiRequestHandler.getUserInfo(
      userId: _proxyUser.id,
      token: _proxyUser.token,
    );

    if (response.error == null) {
      try {
        _user = new User.fromJson(response.data["userdata"]);
        initBackgroundTask();
        return true;
      } catch (err) {
        print("error _getUser: ${err.toString()}");
      }
    }
    _storage.clearStorage();
    _proxyUser = null;
    return false;
  }
}
