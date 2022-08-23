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
                    controller: _passwordResetController,
                  ),
                  TextButton(
                      child: const Text('Reset Password'),
                      onPressed: () async {
                        await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: _passwordResetController.text);
                        _passwordResetController.clear();
                      }),
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
