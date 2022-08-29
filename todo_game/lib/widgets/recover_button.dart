import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RecoverPasswordButton extends StatelessWidget {
  final TextEditingController _passwordResetController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => showModalBottomSheet(
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      filled: true,
                      fillColor: const Color(0x33EBC4C4),
                      hintText: 'Email',
                      hintStyle:
                          const TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                    controller: _passwordResetController,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF661f4f),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // <-- Radius
                      ),
                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.sendPasswordResetEmail(
                          email: _passwordResetController.text);
                      _passwordResetController.clear();
                    },
                    child: const Text('Reset Email',
                        style: TextStyle(fontSize: 20.0)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      child: const Text(
        'Reset Password',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
