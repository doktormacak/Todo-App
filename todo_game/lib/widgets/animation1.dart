import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:todo_game/models/reward.dart';

class SimpleAnimation1 extends StatelessWidget {
  String uid;

  SimpleAnimation1({Key? key, required this.uid}) : super(key: key);
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<String?>> todoStream(String uid) {
    return firestore
        .collection("users")
        .doc(uid)
        .collection("rewards")
        .snapshots()
        .map((QuerySnapshot query) {
      List<Reward?> retVal = [];
      for (var element in query.docs) {
        retVal.add(Reward.fromDocumentSnapshot(element));
      }
      var list = retVal.map((document) => document!.reward).toList();
      return list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/BackGroundSpace.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          child: RiveAnimation.asset(
            'assets/animation_final.riv',
          ),
        ),
        Center(
            child: StreamBuilder(
                stream: todoStream(uid),
                builder: (BuildContext context,
                    AsyncSnapshot<List<String?>> snapshot) {
                  if (snapshot.hasData) {
                    return AnimatedTextKit(
                      animatedTexts: [
                        FadeAnimatedText(
                          snapshot.data![0] == ''
                              ? 'Congratulations!\nYou deserve a beer!'
                              : 'Congratulations!\nYou deserve ${snapshot.data![0]}',
                          textAlign: TextAlign.center,
                          textStyle: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      ],
                      repeatForever: true,
                    );
                  } else {
                    return SizedBox();
                  }
                }))
      ]),
    );
  }
}
