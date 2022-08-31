import 'package:cloud_firestore/cloud_firestore.dart';

class Reward {
  late String? reward;
  late String? id;

  Reward(this.reward, this.id);

  Reward.fromDocumentSnapshot(
    DocumentSnapshot documentSnapshot,
  ) {
    reward = documentSnapshot["reward"];
    id = documentSnapshot.id;
  }
}
