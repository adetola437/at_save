import 'package:at_save/bloc/savings_transaction/savings_transactions_bloc.dart';
import 'package:at_save/controller/success_controller.dart';
import 'package:at_save/model/savings_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../bloc/goals/goals_bloc.dart';
import '../view/screens/add_money_view.dart';

class AddMoneyScreen extends StatefulWidget {
  final String id;

  const AddMoneyScreen({required this.id, super.key});

  @override
  AddMoneyController createState() => AddMoneyController();
}
/// This is the class used to control the view when a user wants to add money to his savings
class AddMoneyController extends State<AddMoneyScreen> {
  String pin = '';   //saves the current pin
  bool isLoading = false;  // used to control the loading state of the screen when an action is ongoing.
///Method used to update the pin string, adding a digit to it when a button is pressed.
  void addDigit(String digit) {
    setState(() {
      if (pin.length < 10) {
        pin += digit;
      }
    });
  }
///Method used to update the pin string, removing a digit to it when a button is pressed.
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
///The addmoney method is gets the wallet balance of the user and checks if  he is eligible to add to savings
  Future addMoney(double balance) async {
    if (double.parse(pin) > balance) {
      Fluttertoast.showToast(
          timeInSecForIosWeb: 3,
          msg:
              'You do not have sufficient balance in your wallet, Kindly Top Up');
      isLoading = false;
    } else {
      context.read<GoalsBloc>().add(
          AddMoneyToSavingsEvent(amount: double.parse(pin), id: widget.id));
      // context.read<UserBloc>().add(FetchUserEvent());
      createTransaction();
      isLoading = false;
    }
  }
//Triggers the loading state
  loading() {
    setState(() {
      isLoading = true;
    });
  }
///After adding money to the savings goal, the transaction for the respective money added is created using this method.
  Future createTransaction() async {
    SavingsTransaction transaction = SavingsTransaction(
        id: '',
        amount: double.parse(pin),
        date: DateTime.now(),
        note: 'Add to my Savings',
        savingsGoalId: widget.id);
    context
        .read<SavingsTransactionsBloc>()
        .add(CreateSavingsTransactionEvent(transaction: transaction));
  }
    void pushPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const SuccessScreen(
        text: 'You have added money tpo your savings',
      ),
    ));
  }
}
