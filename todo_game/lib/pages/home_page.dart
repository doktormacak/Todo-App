import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_game/bloc/app_bloc.dart';
import 'package:todo_game/models/todo.dart';
import 'package:todo_game/widgets/todo_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
    required this.tasksList,
  }) : super(key: key);
  static Page<void> page() => MaterialPage<void>(
          child: HomePage(
        tasksList: [
          Todo('dasad', 'ds', false),
          Todo('dasad', 'ds', false),
          Todo('dasad', 'ds', false),
        ],
      ));
  final TextEditingController _todoController = TextEditingController();
  final List<Todo> tasksList;

  Future<void> addTodo(String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("todos")
          .add({
        'content': _todoController.text,
        'done': false,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editTodo() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc("djovanidjovani123")
          .collection("todos")
          .doc("3sNCR3fmgEvjMwjYmiyG")
          .update({"content": "VESKO VESKO"});
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTodo() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc("djovanidjovani123")
          .collection("todos")
          .doc("3sNCR3fmgEvjMwjYmiyG")
          .delete();
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Todo>> todoStream(String uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection("todos")
        .snapshots()
        .map((QuerySnapshot query) {
      List<Todo> retVal = [];
      for (var element in query.docs) {
        retVal.add(Todo.fromDocumentSnapshot(element));
      }
      print(retVal);
      return retVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    final uid = context.select((AppBloc bloc) => bloc.state.user.id);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            TextButton(
                child: const Text('Log Out'),
                onPressed: () =>
                    context.read<AppBloc>().add(AppLogoutRequested())),
            Text(context.select((AppBloc bloc) => bloc.state.user.id)),
            TextButton(
                child: const Text('TASK'), onPressed: () => addTodo(uid)),
            TextButton(child: const Text('EDIT'), onPressed: () => editTodo()),
            TextButton(
                child: const Text('DELETE'), onPressed: () => deleteTodo()),
            SizedBox(
              height: 60,
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  fillColor: const Color(0x33EBC4C4),
                  hintText: 'Task',
                  hintStyle:
                      const TextStyle(fontSize: 24.0, color: Colors.white),
                ),
                controller: _todoController,
              ),
            ),
            SingleChildScrollView(
              child: Column(children: [
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(uid)
                        .collection("todos")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        final snap = snapshot.data!.docs;
                        return ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: snap.length,
                          itemBuilder: (context, index) {
                            return TodoTile();
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    })
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
