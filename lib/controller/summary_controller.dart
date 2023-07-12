import 'package:at_save/bloc/goals/goals_bloc.dart';
import 'package:at_save/controller/error_controller.dart';
import 'package:at_save/model/savings_goal.dart';
import 'package:at_save/view/screens/summary_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../bloc/target/target_bloc.dart';

class SummaryScreen extends StatefulWidget {
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
  bool isLoading = false;

  loading() {
    setState(() {
      isLoading = true;
    });
  }

  void createGoal() {
    context.read<TargetBloc>().add(CreateTargetEvent(
        currentAmount: widget.goal.currentAmount,
        description: widget.goal.description,
        targetAmount: widget.goal.targetAmount,
        targetDate: widget.goal.targetDate,
        title: widget.goal.title,
        id: widget.goal.id));

    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //   builder: (context) => const LandingScreen(),
    // ));
  }

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
