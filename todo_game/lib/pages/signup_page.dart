import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_game/auth_repository.dart';
import 'package:todo_game/pages/cubit/signup_cubit.dart';
import 'package:todo_game/pages/signup_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (_) => SignUpCubit(context.read<AuthenticationRepository>()),
      child: const SignUpForm(),
    );
  }
}
