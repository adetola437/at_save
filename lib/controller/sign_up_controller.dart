import 'package:at_save/controller/sign_in_controller.dart';
import 'package:at_save/view/screens/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/autthentication/authentication_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpController createState() => SignUpController();
}

class SignUpController extends State<SignUpScreen> {
  //declaration
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
// handles password visibilty
  void changeVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }
/// validates the form fields and triggers the sign up event
  void onSignUp() {
    if (formKey.currentState!.validate()) {
      context.read<AuthenticationBloc>().add(EmailSignUpEvent(
          email: emailController.text,
          name: nameController.text,
          phoneNumber: phoneNumberController.text,
          password: passwordController.text));
     
    }
  }
/// push the sign in screen
  void pushLogin() {
    context.push(SignInScreen.route);
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //   builder: (context) => const SignInScreen(),
    // ));
  }

  void clearFields(){
     emailController.clear();
      nameController.clear();
      phoneNumberController.clear();
      passwordController.clear();
  }
}
