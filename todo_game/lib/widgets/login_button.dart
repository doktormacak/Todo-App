import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:todo_game/pages/cubit/login_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator(color: Colors.white)
            : GestureDetector(
                onTap: state.status.isValidated
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
                key: const Key('loginForm_continue_raisedButton'),
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 0, 0, 0),
                        offset: Offset(6, 6),
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
                    color: Color(0xFF661f4f),
                    //#   48A9A6
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  width: MediaQuery.of(context).size.width * 0.65,
                  height: 60,
                  child: const Center(
                      child: Text(
                    'Log In',
                    style: TextStyle(fontSize: 24.0),
                  )),
                ),
              );
      },
    );
  }
}
