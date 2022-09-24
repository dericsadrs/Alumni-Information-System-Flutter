import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:alumni_sandbox/screens/login.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  _navigate() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(248, 255, 255, 255),
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Lottie.asset(
              "assets/json/37296-success.json",
            ),
            AnimatedTextKit(
                pause: const Duration(milliseconds: 2000),
                isRepeatingAnimation: false,
                repeatForever: false,
                animatedTexts: [
                  FadeAnimatedText("ALUMNI INFORMATION SYSTEM",
                      textStyle: const TextStyle(
                          fontSize: 21, fontWeight: FontWeight.bold)),
                ])
          ],
        ));
  }
}
