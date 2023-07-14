import 'package:at_save/bloc/goals/goals_bloc.dart';
import 'package:at_save/model/savings_goal.dart';
import 'package:at_save/view/screens/summary_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../bloc/target/target_bloc.dart';

class SummaryScreen extends StatefulWidget {
  // goal object passed to display details
  final SavingsGoal goal;
  const SummaryScreen({required this.goal, super.key});

  @override
  SummaryController createState() => SummaryController();
}

class SummaryController extends State<SummaryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SummaryView(this);
  bool isLoading = false; //keep track of loading

//triggers loading
  loading() {
    setState(() {
      isLoading = true;
    });
  }
/// creates a goal by checking wallet balance if there is sufficient amount and if there it, it executes.
  void createGoal(double walletBalance) {
    if (walletBalance >= widget.goal.currentAmount) {
      context.read<TargetBloc>().add(CreateTargetEvent(
          currentAmount: widget.goal.currentAmount,
          description: widget.goal.description,
          targetAmount: widget.goal.targetAmount,
          targetDate: widget.goal.targetDate,
          title: widget.goal.title,
          id: widget.goal.id));
    } else {
      Fluttertoast.showToast(msg: 'You do not have suffient wallet balance');
    }

    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //   builder: (context) => const LandingScreen(),
    // ));
  }
// When the goal creation is success, the success screen is pushed
  Future success() async {
    context.read<GoalsBloc>().add(GetGoalsEvent());
    isLoading = false;
    context.go('/success', extra: 'You have Successfully created your Goal');
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //   builder: (context) => const SuccessScreen(
    //     text: 'You have Successfully created your Goal',
    //   ),
    // ));
  }
// When there is an error, the error screen is pushed
  void error() {
    setState(() {
      isLoading = false;
    });
    Fluttertoast.showToast(msg: 'Error Creating your Target');
    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    //   return const ErrorScreen();
    // }));
  }

//formats datetime to string
  String formatDateToString(DateTime dateTime) {
    DateFormat dateFormat = DateFormat("dd MMMM yyyy");
    return dateFormat.format(dateTime);
  }

  //  Future error()async {
  //  context.read<GoalsBloc>().add(GetGoalsEvent());
  //   isLoading = false;
  //   Navigator.of(context).pushReplacement(MaterialPageRoute(
  //     builder: (context) => const SuccessScreen(
  //       text: 'You have Successfully created your Goal',
  //     ),
  //   ));

  // }
}
