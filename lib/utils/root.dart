import 'package:firetodowithauth/controllers/authController.dart';
import 'package:firetodowithauth/controllers/userController.dart';
import 'package:firetodowithauth/screens/home.dart';
import 'package:firetodowithauth/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends GetWidget<AuthController> {
  //Just For Switching to Home to Login
  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        if (Get.find<AuthController>().user != null) {
          //Need to Find Controller for user instance
          return Home();
        } else {
          return Login();
        }
      },
    );
  }
}
