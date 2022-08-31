import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_game/widgets/chart.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  final Uri _url =
      Uri.parse("https://opensea.io/collection/artvistafirstexposition");
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var completedLen;
  var activeLen;
  final TextEditingController _rewardController = TextEditingController();

  String uid;

  ProfilePage({
    Key? key,
    required this.activeLen,
    required this.completedLen,
    required this.uid,
  }) : super(key: key);

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  // Stream<List<String>> rewardStream(String uid) {
  //   return firestore
  //       .collection("users")
  //       .doc(uid)
  //       .collection("rewards")
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     for (var element in query.docs) {
  //       return element['reward'];
  //     }
  //   });
  // }

  Future<void> firebaseEdit(String uid, String rewardID) async {
    try {
      await firestore
          .collection("users")
          .doc(uid)
          .collection("rewards")
          .doc(rewardID)
          .update({
        'content': _rewardController.text,
      });
    } catch (e) {
      rethrow;
    }
  }

  void addReward(BuildContext context) {
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
                    hintText: 'Reward',
                    hintStyle:
                        const TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  controller: _rewardController,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFF661f4f),
                  ),
                  onPressed: () {},
                  child: const Text('Add', style: TextStyle(fontSize: 20.0)),
                ),
              ]),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: FloatingActionButton(
            backgroundColor: Colors.grey.withOpacity(0.2),
            child: const Icon(
              Icons.arrow_back,
              size: 50.0,
              color: Colors.white,
            ),
            onPressed: () => {Navigator.pop(context)}),
      ),
      backgroundColor: const Color(0xFF661f4f),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 75,
            width: 250,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.black.withOpacity(0.2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: const Icon(Icons.token,
                        color: Colors.white, size: 40.0),
                    onPressed: () {
                      _launchUrl();
                    }),
                const SizedBox(width: 10),
                Column(
                  children: const [
                    SizedBox(height: 30),
                    Text("NFT STORE",
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30.0),
          Container(
              height: 70,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.black.withOpacity(0.2)),
              child: Center(
                  child: InkWell(
                onTap: () {
                  addReward(context);
                },
                child: const Text('Set Reward'),
              ))),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            width: 320,
            child: PieChartSample2(
              activeLen: activeLen,
              completedLen: completedLen,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: InkWell(
              onTap: (() {
                signOut();
                Navigator.pop(context);
              }),
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 3)),
                child: const Center(
                  child: Text('Log Out',
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }
}
