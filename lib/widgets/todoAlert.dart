import 'package:firetodowithauth/controllers/userController.dart';
import 'package:firetodowithauth/models/todo.dart';
import 'package:firetodowithauth/services/fireDb.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoAlert {
  TextEditingController _textEditingController = TextEditingController();
  UserController _userController = Get.find();

  addTodoDailog() {
    Get.defaultDialog(
        title: "Add",
        content: Container(
          padding: EdgeInsets.all(5),
          child: TextFormField(
            controller: _textEditingController,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                child: Text(
                  "Ok",
                ),
                onPressed: () {
                  if (_textEditingController.text != "") {
                    FireDb().addTodo(
                        _textEditingController.text, _userController.user.id);
                    _textEditingController.clear();
                    Get.back();
                  }
                },
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  _textEditingController.clear();
                  Get.back();
                },
              ),
            ],
          ),
        ]);
  }

  editTodoDailog(TodoModel todoModel) {
    _textEditingController.text = todoModel.content;
    Get.defaultDialog(
        title: "Edit",
        content: Container(
          padding: EdgeInsets.all(5),
          child: TextFormField(
            controller: _textEditingController,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlatButton(
                child: Text(
                  "Edit",
                ),
                onPressed: () {
                  if (_textEditingController.text != "") {
                    todoModel.content = _textEditingController.text;
                    FireDb().updateTodo(todoModel, _userController.user.id);
                    _textEditingController.clear();
                    Get.back();
                  }
                },
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  _textEditingController.clear();
                  Get.back();
                },
              ),
            ],
          ),
        ]);
  }
}
