import 'package:firetodowithauth/controllers/authController.dart';
import 'package:firetodowithauth/controllers/userController.dart';
import 'package:firetodowithauth/models/todo.dart';
import 'package:firetodowithauth/services/fireDb.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  Rx<List<TodoModel>> todoList = Rx<List<TodoModel>>();

  List<TodoModel> get todos => todoList.value;

  @override
  @mustCallSuper
  void onInit() async {
    //var fireUser = Get.find<AuthController>().user;
    clear();
    Get.find<UserController>().user =
        await FireDb().getUser(Get.find<AuthController>().user.uid);
    var user = Get.find<UserController>().user;

    todoList.bindStream(FireDb()
        .todoStream(user.id)); //stream coming from firebase For todo List
    super.onInit();
  }

  void clear() {
    this.todoList.value = List<TodoModel>();
  }
}
