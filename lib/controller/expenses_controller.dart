import 'package:at_save/view/screens/expenses_view.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  ExpensesController createState() => ExpensesController();
}

class ExpensesController extends State<ExpensesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ExpensesView(this);
}