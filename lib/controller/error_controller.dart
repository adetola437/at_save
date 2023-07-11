import 'package:at_save/controller/landing_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/budget/budget_bloc.dart';
import '../bloc/expense_transaction/expense_transaction_bloc.dart';
import '../bloc/goals/goals_bloc.dart';
import '../bloc/savings_transaction/savings_transactions_bloc.dart';
import '../bloc/user/user_bloc.dart';
import '../view/screens/error_view.dart';

class ErrorScreen extends StatefulWidget {
  final String? text;
  const ErrorScreen({this.text, super.key});

  @override
  ErrorController createState() => ErrorController();
}

class ErrorController extends State<ErrorScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ErrorView(this);

  goToHomePage() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return const LandingScreen();
    }));
    context.read<UserBloc>().add(FetchUserEvent());
    context.read<GoalsBloc>().add(GetGoalsEvent());

    context.read<SavingsTransactionsBloc>().add(FetchSavingsTransactions());
    context.read<BudgetBloc>().add(FetchBudgetEvent());
    context.read<ExpenseTransactionBloc>().add(FetchExpenseTransaction());
  }
}
