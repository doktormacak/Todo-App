import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_game/pages/cubit/login_cubit.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 0, 0, 0),
                  offset: Offset(6, 12),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: Color.fromARGB(255, 215, 68, 166),
                  // color: Color(0xFF83B692),
                  offset: Offset(-8, -6),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ],
              color: const Color(0xFF661f4f),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: TextField(
                cursorColor: Colors.white,
                key: const Key('loginForm_passwordInput_textField'),
                onChanged: (password) =>
                    context.read<LoginCubit>().passwordChanged(password),
                obscureText: true,
                decoration: InputDecoration(
                  errorText: state.password.invalid ? 'invalid password' : null,
                  contentPadding:
                      const EdgeInsets.only(left: 10.0, right: 31.0),
                  border: InputBorder.none,
                  hintText: 'Password',
                  hintStyle:
                      const TextStyle(fontSize: 20.0, color: Colors.white),
                  suffix: const Icon(Icons.lock_outline,
                      color: Colors.white, size: 20.0),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
