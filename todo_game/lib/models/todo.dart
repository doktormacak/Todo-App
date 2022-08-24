import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  late String? content;
  late String? todoId;
  late bool? done;

  Todo(this.content, this.todoId, this.done);

  Todo.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    content = documentSnapshot["content"];
    todoId = documentSnapshot.id;
    done = documentSnapshot["done"];
  }
}
