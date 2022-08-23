import 'package:flutter/material.dart';
import 'package:todo_game/pages/signup_page.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('loginForm_createAccount_flatButton'),
      onPressed: () => Navigator.of(context).push<void>(SignUpPage.route()),
      child: const Text(
        'CREATE ACCOUNT',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
