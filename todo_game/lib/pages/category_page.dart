import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_game/bloc/app_bloc.dart';
import 'package:todo_game/models/todo.dart';

class CategoryPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  CategoryPage({
    Key? key,
    required this.prop,
  }) : super(key: key);
  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  final TextEditingController _todoEditController = TextEditingController();

  final prop;

  Future<void> firebaseAdd(String uid) async {
    try {
      await firestore.collection("users").doc(uid).collection("todos").add(
          {'content': _todoController.text, 'category': prop, 'done': false});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> firebaseEdit(String uid, String todoid) async {
    try {
      await firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(todoid)
          .update({
        'content': _todoEditController.text,
        'category': prop,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTodo(String uid, String todoid) async {
    try {
      await firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(todoid)
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<String?>> todoStream(String uid) {
    return firestore
        .collection("users")
        .doc(uid)
        .collection("todos")
        .snapshots()
        .map((QuerySnapshot query) {
      List<Todo> retVal = [];
      for (var element in query.docs) {
        retVal.add(Todo.fromDocumentSnapshot(element));
      }
      var list = retVal.map((document) => document.category).toSet().toList();
      return list;
    });
  }

  Future<void> updateTodo(bool newValue, String uid, String todoId) async {
    try {
      firestore
          .collection("users")
          .doc(uid)
          .collection("todos")
          .doc(todoId)
          .update({"done": newValue});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final uid = context.select((AppBloc bloc) => bloc.state.user.id);

    void addTodo(BuildContext context) {
      showModalBottomSheet(
        backgroundColor: Colors.grey.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) => SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  const Text(
                    'Add Task',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      filled: true,
                      fillColor: const Color(0x33EBC4C4),
                      hintText: 'Task',
                      hintStyle:
                          const TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    controller: _todoController,
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF661f4f),
                    ),
                    onPressed: () {
                      firebaseAdd(uid);
                      _todoController.clear();
                      _categoryController.clear();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add', style: TextStyle(fontSize: 20.0)),
                  ),
                ]),
              )),
        ),
      );
    }

    void editTodo(BuildContext context, String uid, String todoId) {
      showModalBottomSheet(
        backgroundColor: Colors.grey.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (context) => SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  const Text(
                    'Edit Task',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      filled: true,
                      fillColor: const Color(0x33EBC4C4),
                      hintText: 'Edit Task',
                      hintStyle:
                          const TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    controller: _todoEditController,
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF661f4f),
                    ),
                    onPressed: () {
                      firebaseEdit(uid, todoId);
                      _todoEditController.clear();
                    },
                    child: const Text('Edit', style: TextStyle(fontSize: 20.0)),
                  ),
                ]),
              )),
        ),
      );
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => addTodo(context),
          label: const Text('Add Task',
              style: TextStyle(fontWeight: FontWeight.w900)),
          backgroundColor: Colors.grey.withOpacity(0.2),
          icon: const Icon(Icons.add_circle_outline,
              size: 50.0, color: Colors.white),
        ),
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/BackGroundSpace.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 75,
            left: 15,
            child: FloatingActionButton(
                backgroundColor: Colors.grey.withOpacity(0.2),
                child: const Icon(
                  Icons.arrow_back,
                  size: 50.0,
                  color: Colors.white,
                ),
                onPressed: () => {Navigator.pop(context)}),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 200),
            child: SingleChildScrollView(
              child: Column(children: [
                StreamBuilder<QuerySnapshot>(
                    stream: firestore
                        .collection("users")
                        .doc(uid)
                        .collection("todos")
                        .where('category', isEqualTo: prop)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.grey.withOpacity(0.2),
                                ),
                                child: ListTile(
                                  leading: IconButton(
                                      onPressed: () =>
                                          deleteTodo(uid, document.id),
                                      icon: const Icon(
                                        Icons.delete_outline_sharp,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                  title: Text(document['content']),
                                  subtitle: Text(document['category']),
                                  onTap: () =>
                                      editTodo(context, uid, document.id),
                                  trailing: Container(
                                    height: 30.0,
                                    width: 30.0,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5),
                                        )),
                                    child: Theme(
                                      data: ThemeData(
                                          unselectedWidgetColor:
                                              Colors.transparent),
                                      child: Checkbox(
                                        fillColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                        activeColor: Colors.transparent,
                                        checkColor: Colors.white,
                                        value: document['done'],
                                        onChanged: (newValue) => updateTodo(
                                            newValue ?? false,
                                            uid,
                                            document.id),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
              ]),
            ),
          ),
        ]));
  }
}
