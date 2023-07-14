import 'package:at_save/bloc/budget/budget_bloc.dart';
import 'package:at_save/bloc/expense_transaction/expense_transaction_bloc.dart';
import 'package:at_save/bloc/goals/goals_bloc.dart';
import 'package:at_save/bloc/savings_transaction/savings_transactions_bloc.dart';
import 'package:at_save/bloc/user/user_bloc.dart';
import 'package:at_save/model/savings_goal.dart';
import 'package:at_save/view/screens/savings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SavingsScreen extends StatefulWidget {
  const SavingsScreen({super.key});

  @override
  SavingsController createState() => SavingsController();
}

class SavingsController extends State<SavingsScreen>
    with TickerProviderStateMixin {
  bool isLoading = false;
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SavingsView(this);

  ///method called when the page is refreshed
  Future onRefresh() async {
    context.read<UserBloc>().add(FetchUserEvent());
    context.read<GoalsBloc>().add(GetGoalsEvent());

    context.read<SavingsTransactionsBloc>().add(FetchSavingsTransactions());
    context.read<BudgetBloc>().add(FetchBudgetEvent());
    context.read<ExpenseTransactionBloc>().add(FetchExpenseTransaction());
  }

  loading() {
    setState(() {
      isLoading = true;
    });
  }

  notLoading() {
    setState(() {
      isLoading = false;
    });
  }

  /// go to the create page
  create() async {
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected == true) {
      context.push('/create_goal');
    } else {
      Fluttertoast.showToast(msg: 'Check your internet connection');
    }
  }

  double getTotalGoalsAmount(List<SavingsGoal> goals) {
    double total = 0;
    for (var goal in goals) {
      total += goal.currentAmount;
    }
    return total;
  }
}
