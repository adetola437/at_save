import 'package:at_save/view/screens/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/autthentication/authentication_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpController createState() => SignUpController();
}

class SignUpController extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SignUpView(this);

  void changeVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void onSignUp() {
    if (formKey.currentState!.validate()) {
      context.read<AuthenticationBloc>().add(EmailSignUpEvent(
          email: emailController.text,
          name: nameController.text,
          phoneNumber: phoneNumberController.text,
          password: passwordController.text));
    }
  }
}
