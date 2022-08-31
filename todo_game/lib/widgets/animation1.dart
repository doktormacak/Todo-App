import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SimpleAnimation1 extends StatelessWidget {
  String reward;
  SimpleAnimation1({Key? key, required this.reward}) : super(key: key);

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
        Center(
          child: AnimatedTextKit(
            animatedTexts: [
              FadeAnimatedText(
                reward == ''
                    ? 'Congratulations!\nYou deserve a beer!'
                    : 'Congratulations!\nYou deserve $reward',
                textAlign: TextAlign.center,
                textStyle: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              )
            ],
            repeatForever: true,
          ),
        ),
      ]),
    );
  }
}
