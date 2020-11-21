import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;

  UserModel({this.id, this.name, this.email});

  UserModel.fromSnapShot(DocumentSnapshot userSnapShot) {
    this.id = userSnapShot.id;
    this.name = userSnapShot['name'];
    this.email = userSnapShot['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}
