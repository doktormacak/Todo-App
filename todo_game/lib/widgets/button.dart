import 'package:flutter/material.dart';

class CoolButton extends StatelessWidget {
  final onTap;
  bool isButtonPressed;

  CoolButton({Key? key, this.onTap, required this.isButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          boxShadow: isButtonPressed
              ? []
              : [
                  const BoxShadow(
                    color: Color.fromARGB(255, 0, 0, 0),
                    offset: Offset(6, 6),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                  const BoxShadow(
                    color: Color.fromARGB(255, 215, 68, 166),
                    // color: Color(0xFF83B692),
                    offset: Offset(-8, -6),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ],
          color: const Color(0xFF661f4f),
          //#   48A9A6
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        width: MediaQuery.of(context).size.width * 0.65,
        height: 60,
        duration: const Duration(milliseconds: 200),
        child: const Center(
            child: Text(
          'Log In',
          style: TextStyle(fontSize: 24.0),
        )),
      ),
    );
  }
}
