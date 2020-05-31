import 'package:flutter/material.dart';

class UpdateUser {
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String email;
  final String telephoneNumber;

  UpdateUser({
    @required this.addressLine1,
    @required this.addressLine2,
    @required this.city,
    @required this.email,
    @required this.telephoneNumber,
  });

  UpdateUser.fromJson(Map<String, dynamic> json)
      : addressLine1 = json['addr_line_1'],
        addressLine2 = json['addr_line_2'],
        city = json['city'],
        email = json['email'],
        telephoneNumber = json['telephone_number'];

  Map<String, dynamic> toJson() => {
        'addressLine1': addressLine1,
        'addressLine2': addressLine2,
        'city': city,
        'email': email,
        'telephoneNumber': telephoneNumber,
      };
}
