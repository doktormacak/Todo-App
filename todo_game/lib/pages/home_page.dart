import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:todo_game/bloc/app_bloc.dart';
import 'package:todo_game/models/todo.dart';
import 'package:todo_game/pages/category_page.dart';
import 'package:todo_game/pages/done_page.dart';
import 'package:todo_game/pages/profile_page.dart';
import 'package:todo_game/widgets/animation1.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);
  static Page<void> page() => MaterialPage<void>(child: HomePage());

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final TextEditingController _todoController = TextEditingController();

  final TextEditingController _categoryController = TextEditingController();

  final TextEditingController _todoEditController = TextEditingController();

  final TextEditingController _categoryEditController = TextEditingController();

  var activeLen;

  var completedLen;

  var animationPhase = false;

  Future<void> firebaseAdd(String uid) async {
    try {
      await firestore.collection("users").doc(uid).collection("todos").add({
        'content': _todoController.text,
        'category': _categoryController.text,
        'done': false
      });
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
        'category': _categoryEditController.text,
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
    final email = context.select((AppBloc bloc) => bloc.state.user.email);

    void addTodo(BuildContext context) {
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
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      filled: true,
                      fillColor: const Color(0x33EBC4C4),
                      hintText: 'Category',
                      hintStyle:
                          const TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    controller: _categoryController,
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF661f4f),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                    onPressed: () {
                      firebaseAdd(uid);

                      _todoController.clear();
                      _categoryController.clear();
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
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      filled: true,
                      fillColor: const Color(0x33EBC4C4),
                      hintText: 'Edit Category',
                      hintStyle:
                          const TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    controller: _categoryEditController,
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF661f4f),
                    ),
                    onPressed: () {
                      firebaseEdit(uid, todoId);
                      _todoEditController.clear();
                      _categoryEditController.clear();
                    },
                    child: const Text('Edit', style: TextStyle(fontSize: 20.0)),
                  ),
                ]),
              )),
        ),
      );
    }

    return Scaffold(
        key: _key,
        drawer: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)),
          ),
          backgroundColor: Colors.black.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 20.0, bottom: 20, left: 10.0, right: 10.0),
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: [
                      const Text('PROFILE'),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return ProfilePage(
                                  email: email,
                                  activeLen: activeLen,
                                  completedLen: completedLen);
                            }),
                          );
                          _key.currentState!.closeDrawer();
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: const Color(0xFF661f4f).withOpacity(0.7),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 20),
                              const SizedBox(
                                child: Icon(Icons.account_circle,
                                    color: Colors.white, size: 40.0),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: Text(email ?? '',
                                      overflow: TextOverflow.ellipsis)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return DonePage();
                        }),
                      );
                      _key.currentState!.closeDrawer();
                    },
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: const Color(0xFF661f4f).withOpacity(0.7),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 20),
                          const SizedBox(
                            child: Icon(Icons.library_add_check_outlined,
                                color: Colors.white, size: 40.0),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: const [
                              SizedBox(height: 25),
                              Text('COMPLETED TASKS'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Column(
                      children: const [
                        SizedBox(height: 50),
                        Text('CATEGORIES'),
                      ],
                    ),
                    StreamBuilder<List<String?>>(
                        stream: todoStream(uid),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<String?>> snapshot) {
                          if (snapshot.hasData) {
                            return MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: snapshot.data!.map((document) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        color: const Color(0xFF661f4f)
                                            .withOpacity(0.7),
                                      ),
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return CategoryPage(
                                                  prop:
                                                      document!.toLowerCase());
                                            }),
                                          );
                                          _key.currentState!.closeDrawer();
                                        },
                                        title: Center(
                                            child:
                                                Text(document!.toUpperCase())),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        }),
                  ],
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: firestore
                        .collection("users")
                        .doc(uid)
                        .collection("todos")
                        .where("done", isEqualTo: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        completedLen = snapshot.data!.docs.length;
                        return const SizedBox();
                      } else {
                        return const SizedBox(
                          height: 20,
                        );
                      }
                    }),
              ]),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addTodo(context);
            setState(() {
              animationPhase = false;
            });
          },
          backgroundColor: Colors.grey.withOpacity(0.2),
          child: const Icon(Icons.add_circle_outline,
              size: 50.0, color: Colors.white),
        ),
        body: Stack(children: [
          Container(
            child: (animationPhase)
                ? Container(child: SimpleAnimation1())
                : Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/BackGroundSpace.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
          Positioned(
            top: 75,
            left: 15,
            child: FloatingActionButton(
                backgroundColor: Colors.grey.withOpacity(0.2),
                child: const Icon(
                  Icons.menu,
                  size: 50.0,
                  color: Colors.white,
                ),
                onPressed: () => _key.currentState!.openDrawer()),
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
                        .where("done", isEqualTo: false)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        activeLen = snapshot.data!.docs.length;
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
                                      onPressed: () {
                                        deleteTodo(uid, document.id);
                                        setState(() {
                                          if (activeLen.toInt() <= 1) {
                                            animationPhase = true;
                                          } else {
                                            animationPhase = false;
                                          }
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.delete_outline_sharp,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                  title: Text(document['content']),
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
                                            fillColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent),
                                            activeColor: Colors.transparent,
                                            checkColor: Colors.white,
                                            value: document['done'],
                                            onChanged: (newValue) {
                                              updateTodo(newValue ?? false, uid,
                                                  document.id);
                                              setState(() {
                                                if (activeLen.toInt() <= 1) {
                                                  animationPhase = true;
                                                } else {
                                                  animationPhase = false;
                                                }
                                              });
                                            })),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else {
                        return const Center(
                            child: Text("Unesi svoje taskovee"));
                      }
                    }),
              ]),
            ),
          ),
        ]));
  }
}
