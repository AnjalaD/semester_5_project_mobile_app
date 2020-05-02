import 'package:flutter/widgets.dart';

class ProxyUser {
  final String id;
  final String token;

  ProxyUser({@required this.id, @required this.token});

  ProxyUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        token = json['token'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'token': token,
      };
}
