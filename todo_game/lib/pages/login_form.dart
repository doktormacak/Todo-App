import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:todo_game/pages/cubit/login_cubit.dart';
import 'package:todo_game/widgets/email_input.dart';
import 'package:todo_game/widgets/login_button.dart';
import 'package:todo_game/widgets/password_input.dart';
import 'package:todo_game/widgets/recover_button.dart';
import 'package:todo_game/widgets/signup_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF661f4f),
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Column(
                children: const [
                  Icon(
                    Icons.rocket_launch_outlined,
                    color: Colors.white,
                    size: 100,
                  ),
                  Text('NFTODO',
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              ),
            ),
            const SizedBox(height: 40),
            const EmailInput(),
            const SizedBox(height: 40),
            const PasswordInput(),
            const SizedBox(height: 40),
            const LoginButton(),
            const SizedBox(height: 40),
            const SignUpButton(),
            const SizedBox(height: 5),
            RecoverPasswordButton(),
          ],
        ),
      ),
    );
  }
}
