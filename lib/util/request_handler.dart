import 'package:dio/dio.dart';
import 'package:semester_5_project_mobile_app/constants/api.dart';
import 'package:semester_5_project_mobile_app/models/incident_report.dart';
import 'package:semester_5_project_mobile_app/models/user_model.dart';

class ApiRequestHandler {
  static final Dio _dio = Dio();

  static dynamic login({String nic, String password}) async {
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
      return data;
    } catch (err) {
      return null;
    }
  }

  static dynamic register(User user) async {
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
      return data;
    } catch (err) {
      return null;
    }
  }

  static dynamic getUserInfo({String userId, String token}) async {
    try {
      Response response = await _dio.get(
        "${Api.kGetUserApi}/$userId",
        options: Options(
          headers: {
            "Auth": token,
          },
          validateStatus: (status) {
            return true;
          },
        ),
      );
      Map<String, dynamic> data = _responseHandler(response);
      return data;
    } catch (err) {
      return null;
    }
  }

  static dynamic sendReport({IncidentReport incidentReport}) async {
    Map<String, dynamic> postData = incidentReport.toJson();
    if (incidentReport.image != null) {
      postData['file'] =
          await MultipartFile.fromFile(incidentReport.image.path);
    }
    print(postData);
    try {
      Response response = await _dio.post(
        Api.kSignUpApi,
        data: FormData.fromMap(postData),
        options: Options(
          validateStatus: (status) {
            return true;
          },
        ),
      );
      Map<String, dynamic> data = _responseHandler(response);
      print(data);
      return data;
    } catch (err) {
      return null;
    }
  }

  static dynamic _responseHandler(Response response) {
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
