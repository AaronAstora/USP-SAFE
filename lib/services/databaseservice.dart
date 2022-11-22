import 'package:cloud_firestore/cloud_firestore.dart';

class UserList {
  final String Name;
  final String Email;
  final String Role;
  final String Campus;

  UserList(
      {required this.Name,
      required this.Email,
      required this.Role,
      required this.Campus});

  Map<String, dynamic> toJson() => {
        'Name': Name,
        'Email': Email,
        'Role': Role,
        'Campus': Campus,
      };

  static UserList fromJson(Map<String, dynamic> json) => UserList(
      Name: json['Name'],
      Email: json['Email'],
      Role: json['Role'],
      Campus: json['Campus']);
}
