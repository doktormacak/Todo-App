import 'package:flutter/material.dart';
import 'package:todo_game/pages/signup_page.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: const Key('loginForm_createAccount_flatButton'),
        onTap: () => Navigator.of(context).push<void>(SignUpPage.route()),
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 3)),
          child: const Center(
            child: Text('Register',
                style: TextStyle(fontSize: 24, color: Colors.white)),
          ),
        ));
  }
}
