// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sdlc_flutter/models/profile.dart';


class User {
  String first_name;
  String last_name;
  String email;
  int phoneNumber;
  Profile profile;

  User({
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.phoneNumber,
    required this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profile: Profile.fromJson(json['profile']),
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'first_name': first_name,
      'email': email,
    };
  }

}

