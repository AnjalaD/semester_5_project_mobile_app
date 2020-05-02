import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';

class User {
  final String nic;
  final String firstName;
  final String lastName;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String dob;
  final String email;
  final String telephoneNumber;
  final String password;
  final LatLng location;

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
    this.location,
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
        location = null,
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
