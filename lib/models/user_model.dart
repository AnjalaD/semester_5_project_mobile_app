import 'package:flutter/material.dart';

class User {
  final String nic;
  final String firstName;
  final String lastName;
  String addressLine1;
  String addressLine2;
  String city;
  final String dob;
  String email;
  String telephoneNumber;
  final String password;

  User({
    @required this.nic,
    @required this.firstName,
    @required this.lastName,
    @required this.addressLine1,
    @required this.addressLine2,
    @required this.city,
    @required this.dob,
    @required this.email,
    @required this.telephoneNumber,
    this.password,
  });

  User.fromJson(Map<String, dynamic> json)
      : nic = json['nic'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        addressLine1 = json['addr_line_1'],
        addressLine2 = json['addr_line_2'],
        city = json['city'],
        dob = json['dob'],
        email = json['email'],
        telephoneNumber = json['telephone_number'],
        password = null;

  Map<String, dynamic> toJson() => {
        'nic': nic,
        'firstName': firstName,
        'lastName': lastName,
        'addressLine1': addressLine1,
        'addressLine2': addressLine2,
        'city': city,
        'dob': dob,
        'email': email,
        'telephoneNumber': telephoneNumber,
        'password': password,
      };
}
