import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_game/bloc/app_bloc.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  static Page<void> page() => MaterialPage<void>(child: RegisterPage());
  final TextEditingController _todoController = TextEditingController();

  Future<void> addTodo() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc("djovanidjovani123")
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

  @override
  Widget build(BuildContext context) {
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
            Text(context.select((AppBloc bloc) => bloc.state.user.email ?? '')),
            TextButton(child: const Text('TASK'), onPressed: () => addTodo()),
            TextButton(child: const Text('EDIT'), onPressed: () => editTodo()),
            TextButton(
                child: const Text('DELETE'), onPressed: () => deleteTodo()),
            Container(
              height: 60,
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  fillColor: Color(0x33EBC4C4),
                  hintText: 'Task',
                  hintStyle: TextStyle(fontSize: 24.0, color: Colors.white),
                ),
                controller: _todoController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
