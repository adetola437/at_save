import 'package:at_save/bloc/expense_transaction/expense_transaction_bloc.dart';
import 'package:at_save/view/screens/withdraw_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  WithdrawController createState() => WithdrawController();
}

class WithdrawController extends State<WithdrawScreen> {
  String? selectedOption;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WithdrawView(this);

  onChanged(value) {
    setState(() {
      selectedOption = value;
    });
  }

  ///Method to wihdraw from user wallet balance
  withdraw(double walletBalance) {
    if (formKey.currentState!.validate()) {
      if (double.parse(amountController.text) <= walletBalance) {
        context.read<ExpenseTransactionBloc>().add(CreateExpenseTransaction(
            description: descriptionController.text,
            amount: double.parse(amountController.text),
            category: selectedOption!,
            date: DateTime.now(),
            id: '',
            transactionType: 'withdraw'));
      } else {
        Fluttertoast.showToast(msg: 'You do not have sufficient balance');
      }
    }
  }

  loading() {
    setState(() {
      isLoading = true;
    });
  }

  ///go to success state when withdrawal is successful
  pushSuccess() {
    context.go('/success', extra: 'You have successfully withdrawn your funds');
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //   builder: (context) => const SuccessScreen(
    //     text: 'You have Successfully Withdrawn your funds',
    //   ),
    // ));
  }

  pushError() {
    context.go('/error', extra: 'Error withdrawing your funds');
  }
}
