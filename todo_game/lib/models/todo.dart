import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  late String? content;
  late String? category;
  late bool? done;

  Todo(this.content, this.category, this.done);

  Todo.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    content = documentSnapshot["content"];
    category = documentSnapshot["category"];
    done = documentSnapshot["done"];
  }
}
