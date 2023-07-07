import 'package:at_save/bloc/goals/goals_bloc.dart';
import 'package:at_save/bloc/user/user_bloc.dart';
import 'package:at_save/controller/landing_controller.dart';
import 'package:at_save/controller/success_controller.dart';
import 'package:at_save/model/savings_goal.dart';
import 'package:at_save/view/screens/summary_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void createGoal() {
    context.read<TargetBloc>().add(CreateTargetEvent(
        currentAmount: widget.goal.currentAmount,
        description: widget.goal.description,
        targetAmount: widget.goal.targetAmount,
        targetDate: widget.goal.targetDate,
        title: widget.goal.title,
        id: widget.goal.id));
    setState(() {
      isLoading = true;
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LandingScreen(),
    ));
    isLoading = false;
  }

  void success() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const SuccessScreen(
        text: 'You have Successfully created your Goal',
      ),
    ));
    context.read<GoalsBloc>().add(GetGoalsEvent());
    
  }
}
