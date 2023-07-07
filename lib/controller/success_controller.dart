import 'package:at_save/controller/landing_controller.dart';
import 'package:at_save/view/screens/success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user/user_bloc.dart';

class SuccessScreen extends StatefulWidget {
  final String text;
  const SuccessScreen({required this.text, super.key});

  @override
  SuccessController createState() => SuccessController();
}

class SuccessController extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SuccessView(this);

  void goHome() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LandingScreen(),
    ));
     context.read<UserBloc>().add(FetchUserEvent());
  }
}
