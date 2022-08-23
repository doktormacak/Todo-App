import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_game/pages/cubit/login_cubit.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
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
                offset: Offset(-8, -6),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
            color: const Color(0xFF661f4f),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              cursorColor: Colors.white,
              key: const Key('loginForm_emailInput_textField'),
              onChanged: (email) =>
                  context.read<LoginCubit>().emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10.0, right: 31.0),
                border: InputBorder.none,
                hintText: 'Email',
                hintStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
                suffix: const Icon(Icons.mail_outline,
                    color: Colors.white, size: 20.0),
                errorText: state.email.invalid ? 'invalid email' : null,
              ),
            ),
          ),
        );
      },
    );
  }
}
