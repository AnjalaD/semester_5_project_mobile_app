class Api {
  static final String kApi = 'http://54.211.89.189:8080/api';

  /// NO AUTH
  /// /api/user/signup POST
  /// {
  static final String kSignUpApi = "$kApi/user/signup";

  ///NO AUTH
  /// /api/user/signin POST
  ///{
  ///"nic":"9731451831v",
  ///"password":"password"
  ///}
  static final String kSignInApi = "$kApi/user/signin";
  // test
  // static final String kSignInApi = "https://api.jsonbin.io/b/5ea6f5ae2940c704e1df850c";

  ///AUTH
  ////api/user/{userId} GET
  static final String kGetUserApi = "$kApi/user";
  // test
  // static final String kGetUserApi = "https://api.jsonbin.io/b/5ea6faea98b3d537523574ca";
}
