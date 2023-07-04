import 'package:at_save/view/screens/savings_view.dart';
import 'package:flutter/material.dart';

class SavingsScreen extends StatefulWidget {
  const SavingsScreen({super.key});

  @override
  SavingsController createState() => SavingsController();
}

class SavingsController extends State<SavingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SavingsView(this);
}