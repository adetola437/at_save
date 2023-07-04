import 'package:at_save/controller/onboarding_controller.dart';
import 'package:flutter/material.dart';

import '../view/screens/splash_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashController createState() => SplashController();
}

class SplashController extends State<Splash> {
  @override
  void initState() {
    wait();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  wait() async {
    await Future.delayed(const Duration(seconds: 2), () async {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const OnboardingScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) => SplashScreen(this);
}
