import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_game/bloc/app_bloc.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static Page<void> page() => const MaterialPage<void>(child: RegisterPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            TextButton(
                child: const Text('Log Out'),
                onPressed: () =>
                    context.read<AppBloc>().add(AppLogoutRequested())),
            Text(context.select((AppBloc bloc) => bloc.state.user.email ?? '')),
          ],
        ),
      ),
    );
  }
}
