import 'dart:ui';
import 'package:firetodowithauth/models/todo.dart';
import 'package:firetodowithauth/services/fireDb.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firetodowithauth/widgets/todoAlert.dart';

class TodoCard extends StatelessWidget {
  final String uid;
  final TodoModel todo;

  const TodoCard({Key key, this.uid, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.todoId),
      background: Container(
          color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.edit),
              ),
            ],
          )),
      secondaryBackground: Container(
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Icon(Icons.delete),
              ),
            ],
          )),
      direction: DismissDirection.horizontal,
      dragStartBehavior: DragStartBehavior.start,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          TodoAlert().editTodoDailog(todo);
          return false;
        } else {
          return true;
        }
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          FireDb().deleteTodo(todo, uid);
        }
      },
      child: Card(
        margin: EdgeInsets.fromLTRB(10, 2.5, 10, 2.5),
        child: Container(
          margin: EdgeInsets.all(5),
          child: ListTile(
            leading: Checkbox(
              value: todo.done,
              onChanged: (newValue) {
                todo.done = newValue;
                FireDb().updateTodo(
                  todo,
                  uid,
                );
              },
            ),
            title: GestureDetector(
              onTap: () {
                TodoAlert().editTodoDailog(todo);
              },
              child: Text(
                todo.content,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: (todo.done) ? Colors.green : Colors.red),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
