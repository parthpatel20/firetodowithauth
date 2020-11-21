import 'package:firetodowithauth/controllers/authController.dart';
import 'package:firetodowithauth/controllers/themeController.dart';
import 'package:firetodowithauth/controllers/todoController.dart';
import 'package:firetodowithauth/controllers/userController.dart';
import 'package:firetodowithauth/services/fireDb.dart';
import 'package:firetodowithauth/widgets/todoCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firetodowithauth/widgets/todoAlert.dart';

class Home extends StatelessWidget {
  final AuthController _authController = Get.find();
//  final UserController _userController = Get.put(UserController());
  final ThemeController _themeController = Get.put(ThemeController());

  getLightIcon() {
    if (_themeController.themeChange) {
      return Icon(Icons.lightbulb);
    } else {
      return Icon(Icons.lightbulb_outline);
    }
  }

  getUserName() {
    return GetX<UserController>(
      init: Get.put(UserController()),
      initState: (_) async {
        Get.find<UserController>().user =
            await FireDb().getUser(Get.find<AuthController>().user.uid);
      },
      builder: (_userController) {
        return Text((_userController.user == null)
            ? ""
            : _userController.user.name.toString());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getUserName(),
        centerTitle: true,
        actions: [
          Obx(
            () => IconButton(
              icon: getLightIcon(),
              onPressed: () {
                if (Get.isDarkMode) {
                  Get.changeTheme(ThemeData.light());
                  _themeController.themeChange = false;
                } else {
                  Get.changeTheme(ThemeData.dark());
                  _themeController.themeChange = true;
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _authController.logOut();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          TodoAlert().addTodoDailog();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Todos",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          GetX<TodoController>(
            init: Get.put<TodoController>(TodoController()),
            builder: (TodoController todoController) {
              if (todoController != null && todoController.todos != null) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: todoController.todos.length,
                    itemBuilder: (_, index) {
                      return TodoCard(
                          uid: _authController.user.uid,
                          todo: todoController.todos[index]);
                    },
                  ),
                );
              } else {
                return Container(
                    child: Center(
                        child: CircularProgressIndicator(
                  value: 10,
                )));
              }
            },
          )
        ],
      ),
    );
  }
}
