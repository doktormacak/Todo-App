import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class Category {
  late String? documentId;
  late String? categoryId;
  late bool? done;

  Category({this.documentId, this.categoryId, this.done});

  Category.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    documentId = snapshot.id;
    categoryId = snapshot.data()['category'];
  }
}
