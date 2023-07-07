import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/goals/goals_bloc.dart';
import '../view/screens/add_money_view.dart';

class AddMoneyScreen extends StatefulWidget {
  final String id;
  const AddMoneyScreen({required this.id, super.key});

  @override
  AddMoneyController createState() => AddMoneyController();
}

class AddMoneyController extends State<AddMoneyScreen> {
  String pin = '';

  void addDigit(String digit) {
    setState(() {
      if (pin.length < 10) {
        pin += digit;
      }
    });
  }

  void removeDigit() {
    setState(() {
      if (pin.isNotEmpty) {
        pin = pin.substring(0, pin.length - 1);
      }
    });
  }

  @override
  void initState() {
   
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AddMoneyView(this);

  Future addMoney() async {
    context
        .read<GoalsBloc>()
        .add(AddMoneyToSavingsEvent(amount: double.parse(pin), id: widget.id));
    // context.read<UserBloc>().add(FetchUserEvent());
  }
}
