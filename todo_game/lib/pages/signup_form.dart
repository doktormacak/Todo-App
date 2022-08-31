import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:formz/formz.dart';
import 'package:todo_game/pages/cubit/signup_cubit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  var value = false;
  var terms;
  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.grey.withOpacity(0.2),
            child: const Icon(
              Icons.arrow_back,
              size: 50.0,
              color: Colors.white,
            ),
            onPressed: () => {Navigator.pop(context)}),
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
            const SizedBox(height: 50),
            _EmailInput(),
            const SizedBox(height: 50),
            _PasswordInput(),
            const SizedBox(height: 50),
            _ConfirmPasswordInput(),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(5),
                        )),
                    child: Theme(
                      data:
                          ThemeData(unselectedWidgetColor: Colors.transparent),
                      child: Checkbox(
                          fillColor:
                              MaterialStateProperty.all(Colors.transparent),
                          activeColor: Colors.transparent,
                          checkColor: Colors.white,
                          value: value,
                          onChanged: (newValue) {
                            setState(() {
                              value = newValue!;
                              terms = true;
                            });
                          }),
                    ),
                  ),
                  GestureDetector(
                    child: const Text(
                        '    I have read and agree to the terms of service.',
                        style: TextStyle(fontSize: 10)),
                  ),
                ],
              ),
            ),
            _SignUpButton(
              terms: terms,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
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
                key: const Key('signUpForm_emailInput_textField'),
                onChanged: (email) =>
                    context.read<SignUpCubit>().emailChanged(email),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.only(left: 10.0, right: 31.0),
                  border: InputBorder.none,
                  hintText: 'Email',
                  hintStyle:
                      const TextStyle(fontSize: 20.0, color: Colors.white),
                  suffix: const Icon(Icons.mail_outline,
                      color: Colors.white, size: 20.0),
                  errorText: state.email.invalid ? 'invalid email' : null,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
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
                key: const Key('signUpForm_passwordInput_textField'),
                onChanged: (password) =>
                    context.read<SignUpCubit>().passwordChanged(password),
                obscureText: true,
                decoration: InputDecoration(
                  errorText: state.password.invalid ? 'invalid password' : null,
                  border: InputBorder.none,
                  hintText: 'Password',
                  contentPadding:
                      const EdgeInsets.only(left: 10.0, right: 31.0),
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

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
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
                key: const Key('signUpForm_confirmedPasswordInput_textField'),
                onChanged: (confirmPassword) => context
                    .read<SignUpCubit>()
                    .confirmedPasswordChanged(confirmPassword),
                obscureText: true,
                decoration: InputDecoration(
                  errorText: state.confirmedPassword.invalid
                      ? 'passwords do not match'
                      : null,
                  contentPadding:
                      const EdgeInsets.only(left: 10.0, right: 31.0),
                  border: InputBorder.none,
                  hintText: 'Confirm Password',
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

class _SignUpButton extends StatefulWidget {
  var terms;

  _SignUpButton({required this.terms});

  @override
  State<_SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<_SignUpButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : GestureDetector(
                key: const Key('signUpForm_continue_raisedButton'),
                onTap: state.status.isValidated && widget.terms == true
                    ? () {
                        context.read<SignUpCubit>().signUpFormSubmitted();
                      }
                    : null,
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 3)),
                  child: const Center(
                    child: Center(
                      child: Text('Register',
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                    ),
                  ),
                ));
      },
    );
  }
}
