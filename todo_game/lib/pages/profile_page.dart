import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  final Uri _url =
      Uri.parse("https://opensea.io/collection/artvistafirstexposition");

  final email;
  ProfilePage({
    Key? key,
    required this.email,
  }) : super(key: key);

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
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
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 60,
            ),
            child: Center(
                child: Text("NFT STORE",
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold))),
          ),
          const SizedBox(height: 5),
          IconButton(
              icon: const Icon(Icons.token, color: Colors.white, size: 50.0),
              onPressed: () {
                _launchUrl();
              }),
          // InkWell(
          //   child: const Text("Open NFT"),
          //   onTap:() => _launchUrl()
          // ),

          const SizedBox(height: 30.0),
          Container(
              height: 50,
              //TODO Treba nekako da se siri ovo uz tekst ali se ne mogu setit sanse nema jer mi expanded poludi
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.black.withOpacity(0.2)),
              child: Center(child: Text(email))),
          const SizedBox(height: 20),
          Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.black.withOpacity(0.2)),
              child: const Center(child: Text("Username"))),
          const SizedBox(height: 20),
          Center(
            child: InkWell(
              onTap: (() {
                signOut();
                Navigator.pop(context);
              }),
              child: const Text("Log out"),
            ),
          ),

          //InkWell(
          //   child: const Text("Open NFT"),
          //   onTap:() => _launchUrl()
          // ),
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
