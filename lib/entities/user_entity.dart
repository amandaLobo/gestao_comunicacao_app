import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;
  final String password;
  final String profession;
  final String company;
  final String dateOfBirth;

  User({
    @required this.name,
    @required this.email,
    this.password,
    @required this.profession,
    @required this.company,
    @required this.dateOfBirth
});

}