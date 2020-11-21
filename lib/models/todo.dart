import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  String content;
  String todoId;
  Timestamp dateCreated;
  bool done;

  TodoModel(
    this.content,
    this.todoId,
    this.dateCreated,
    this.done,
  );

  TodoModel.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    todoId = documentSnapshot.id;
    content = documentSnapshot["content"];
    dateCreated = documentSnapshot["dateCreated"];
    done = documentSnapshot["done"];
  }

  Map<String, dynamic> toJson() {
    //For Json Change
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['dateCreated'] = this.dateCreated;
    data['done'] = this.done;
    return data;
  }
}
