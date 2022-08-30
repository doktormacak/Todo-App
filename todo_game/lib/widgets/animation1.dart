import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SimpleAnimation1 extends StatelessWidget {
  const SimpleAnimation1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/BackGroundSpace.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          child: RiveAnimation.asset(
            'assets/animation_final.riv',
          ),
        ),
      ]),
    );
  }
}
