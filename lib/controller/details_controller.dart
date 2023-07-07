import 'package:at_save/bloc/goals/goals_bloc.dart';
import 'package:at_save/bloc/user/user_bloc.dart';
import 'package:at_save/controller/add_money_controller.dart';
import 'package:at_save/view/screens/details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatefulWidget {
  String goalId;
  DetailsScreen({required this.goalId, super.key});

  @override
  DetailsController createState() => DetailsController();
}

class DetailsController extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DetailsView(this);

  bool isLoading = false;

  void loading() {
    setState(() {
      isLoading = true;
    });
  }

  void notLoading() {
    setState(() {
      isLoading = false;
    });
  }

  void addMoney() {
    context
        .read<GoalsBloc>()
        .add(AddMoneyToSavingsEvent(amount: 30, id: '7pZAqT2yca4iQSAlGVRS'));
    context.read<UserBloc>().add(FetchUserEvent());
  }

  void pushToAddPage() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return AddMoneyScreen(id: widget.goalId,);
    }));
  }
}
