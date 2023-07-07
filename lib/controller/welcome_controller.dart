import 'package:at_save/controller/sign_in_controller.dart';
import 'package:at_save/controller/sign_up_controller.dart';
import 'package:at_save/view/screens/welcome_view.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  WelcomeController createState() => WelcomeController();
}

class WelcomeController extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WelcomeView(this);

   void pushSignIn() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const SignInScreen(),
    ));
  }
   void pushSignUp() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const SignUpScreen(),
    ));
  }
}
