import 'package:at_save/view/screens/expense_edit_view.dart';
import 'package:flutter/material.dart';

class ExpenseEditScreen extends StatefulWidget {
  const ExpenseEditScreen({super.key});

  @override
  ExpenseEditController createState() => ExpenseEditController();
}

class ExpenseEditController extends State<ExpenseEditScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ExpenseEditView(this);
}