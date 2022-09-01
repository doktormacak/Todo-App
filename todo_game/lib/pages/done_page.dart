import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_game/bloc/app_bloc.dart';
import 'package:todo_game/models/todo.dart';

class DonePage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DonePage({
    Key? key,
  }) : super(key: key);

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

    return Scaffold(
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
                    .where('done', isEqualTo: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.grey.withOpacity(0.2),
                            ),
                            child: ListTile(
                              leading: IconButton(
                                  onPressed: () => deleteTodo(uid, document.id),
                                  icon: const Icon(
                                    Icons.delete_outline_sharp,
                                    color: Colors.white,
                                    size: 30,
                                  )),
                              title: Text(document['content']),
                              subtitle: Text(document['category']),
                              onTap: null,
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
                                        newValue ?? false, uid, document.id),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return const Center(child: Text("Unesi svoje taskove"));
                  }
                }),
          ]),
        ),
      ),
    ]));
  }
}
