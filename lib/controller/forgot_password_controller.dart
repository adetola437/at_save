import 'package:at_save/view/screens/forgot_password_view.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ForgotPasswordController createState() => ForgotPasswordController();
}

class ForgotPasswordController extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ForgotPasswordView(this);

  Future passwordReset()async{
    try {
      
    } catch (e) {
      
    }
  }
}
