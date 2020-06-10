class Api {
  static final int kWebPort = 8080;
  static final int kSocketPort = 3003;
  static final String kBaseUrl = 'http://3.84.11.154';
  static final String kWebApi = '$kBaseUrl:$kWebPort/api';
  static final String kSocketApi = '$kBaseUrl:$kSocketPort/api';

  /// NO AUTH
  /// /user/signup POST JSON
  static final String kSignUpApi = "$kWebApi/user/signup";

  /// NO AUTH
  /// /user/signin POST JSON
  /// {
  ///  "nic":"9731451831v",
  ///  "password":"password"
  /// }
  static final String kSignInApi = "$kWebApi/user/signin";
  // test
  // static final String kSignInApi = "https://api.jsonbin.io/b/5ea6f5ae2940c704e1df850c";

  /// AUTH
  //// /user/{userId} GET
  static final String kGetUserApi = "$kWebApi/user";
  // test
  // static final String kGetUserApi = "https://api.jsonbin.io/b/5ea6faea98b3d537523574ca";

  ///AUTH
  /// /socket/send-message POST FORM-DATA
  /// {
  ///   title: 'title',
  ///   description: 'decription',
  ///   data:{"location":{"lng":80.062324,"lat":6.714721},"categories":  [3]}
  /// }
  /// http://54.211.194.83:3003/api/socket/send-message
  static final String kSendReportApi = "$kSocketApi/socket/send-message";

  /// AUTH
  ///  /api/user/update PUT JSON
  /// {
  ///  "addressLine1":"abcd",
  ///  "addressLine2":"cdef",
  ///  "city":"ysjd",
  ///  "email":"lahiru@gmail.om",
  ///  "telephoneNumber":"123456"
  ///}
  static final String kUpdateUserApi = "$kWebApi/user/update";

  /// AUTH
  /// DELETE
  static final String kDeleteUserApi = "$kWebApi/user/delete";

  /// AUTH
  /// /api/user/change-password POST JSON
  /// {
  ///  "newPassword":"newpassword",
  ///  "oldPassword":"password",
  ///  "nic":"973181831v"
  /// }
  static final String kChangePasswordApi = "$kWebApi/user/change-password";

  /// AUTH
  /// /api/user/change-password POST JSON
  // {
  //   "prev_location": [6.933276, 79.857203],
  //   "curr_location": [7.290320, 80.632706],
  //   "FCM_token": "dKhyZUCXMmk:APA91bHU98HLxXiuc3LNaTnTsQczlWn6tuOBkyxBEJZ"
  // }
  static final String kUpdateLocationApi = "$kWebApi/push/save-location";
}
