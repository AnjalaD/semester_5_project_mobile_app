import 'package:dio/dio.dart';
import 'package:semester_5_project_mobile_app/constants/api.dart';
import 'package:semester_5_project_mobile_app/models/incident_report.dart';
import 'package:semester_5_project_mobile_app/models/update_user_model.dart';
import 'package:semester_5_project_mobile_app/models/user_model.dart';
import 'package:semester_5_project_mobile_app/util/classes/response.dart';

class ApiRequestHandler {
  static final Dio _dio = Dio(BaseOptions(
    connectTimeout: 10000,
    receiveTimeout: 10000,
    validateStatus: (status) {
      return true;
    },
  ));

  static Future<ProcessedResponse> login({String nic, String password}) async {
    print('calling login api...');

    try {
      Response response = await _dio.post(
        Api.kSignInApi,
        data: {
          "nic": nic,
          "password": password,
        },
      );
      Map<String, dynamic> data = _responseHandler(response);
      print('end...........');

      return ProcessedResponse(data: data);
    } on DioError catch (_) {
      print('dio error............');
      return ProcessedResponse(error: 'Network error!');
    } catch (err) {
      print('error............');

      return ProcessedResponse(error: err.toString());
    }
  }

  static Future<ProcessedResponse> register(User user) async {
    print('calling register api...');

    try {
      Response response = await _dio.post(
        Api.kSignUpApi,
        data: user.toJson(),
      );
      Map<String, dynamic> data = _responseHandler(response);
      print('end...........');
      return ProcessedResponse(data: data);
    } on DioError catch (_) {
      print('dio error............');
      return ProcessedResponse(error: 'Network error!');
    } catch (err) {
      print('error............');
      return ProcessedResponse(error: err.toString());
    }
  }

  static Future<ProcessedResponse> getUserInfo(
      {String userId, String token}) async {
    print('calling getuserinfo api...');

    try {
      Response response = await _dio.get(
        "${Api.kGetUserApi}/$userId",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      Map<String, dynamic> data = _responseHandler(response);
      print('end...........');
      return ProcessedResponse(data: data);
    } on DioError catch (_) {
      print('dio error............');
      return ProcessedResponse(error: 'Network error!');
    } catch (err) {
      print('error............');
      return ProcessedResponse(error: err.toString());
    }
  }

  static Future<bool> sendReport({
    IncidentReport incidentReport,
    String token,
  }) async {
    print('report :${incidentReport.toJson()}');
    try {
      print('calling sendreport api...');

      Response response = await _dio.post(
        Api.kSendReportApi,
        data: FormData.fromMap(incidentReport.toJson()),
        // onSendProgress: (count, total) =>
        //     print('send :${(count / total) * 100}'),
        // onReceiveProgress: (count, total) =>
        //     print('receive :${(count / total) * 100}'),
        options: Options(
          contentType: 'multipart/form-data',
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      print("Response: $response");
      Map<String, dynamic> data = _responseHandler(response);
      print("Response: $data");
      return true;
    } catch (err) {
      print("error sendError: $err");
      return false;
    }
  }

  static Future<bool> updateUser({UpdateUser user, String token}) async {
    print('calling update-userinfo api...');

    try {
      Response response = await _dio.put(
        Api.kUpdateUserApi,
        data: user.toJson(),
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      _responseHandler(response);
      print('end...........');
      return true;
    } catch (err) {
      print('error............');
      return false;
    }
  }

  static Future<bool> deleteUser(
      {String token, String nic, String password}) async {
    print('calling delete-user api...');
    try {
      Response response = await _dio.delete(
        Api.kDeleteUserApi,
        data: {"password": password, "nic": nic},
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      _responseHandler(response);
      print('end...........');
      return true;
    } catch (err) {
      print('error............');
      return false;
    }
  }

  static Future<bool> changePassword(
      {String nic,
      String oldPassword,
      String newPassword,
      String token}) async {
    print('calling change password api...');

    try {
      Response response = await _dio.post(
        Api.kChangePasswordApi,
        data: {
          "nic": nic,
          "oldPassword": oldPassword,
          "newPassword": newPassword,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      _responseHandler(response);
      print('end...........');
      return true;
    } catch (err) {
      print('error............');
      return false;
    }
  }

  static Future<bool> updateLocation(
      {Map<String, dynamic> data, String token}) async {
    print('calling update location api...');

    try {
      Response response = await _dio.post(
        Api.kUpdateLocationApi,
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      _responseHandler(response);
      print('end...........');
      return true;
    } catch (err) {
      print('error............');
      return false;
    }
  }

  static dynamic _responseHandler(Response response) {
    print('res :$response');

    switch (response.statusCode) {
      case 200:
        return response.data;
      case 201:
        return response.data;
      case 401:
        throw response.data["message"];
      case 406:
        throw response.data["message"];
      case 500:
        throw response.data ? response.data["message"] : 'Server error';
      default:
        throw "Unexpected error occured :${response.statusCode}";
    }
  }
}
