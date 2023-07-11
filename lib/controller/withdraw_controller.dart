import 'package:at_save/bloc/expense_transaction/expense_transaction_bloc.dart';
import 'package:at_save/controller/success_controller.dart';
import 'package:at_save/view/screens/withdraw_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WithdrawView(this);

  onChanged(value) {
    setState(() {
      selectedOption = value;
    });
  }

  withdraw() {
    if (formKey.currentState!.validate()) {
      context.read<ExpenseTransactionBloc>().add(CreateExpenseTransaction(
        description: descriptionController.text,
          amount: double.parse(amountController.text),
          category: selectedOption!,
          date: DateTime.now(),
          id: '',
          transactionType: 'withdraw'));
    }
  }

  loading() {
    setState(() {
      isLoading = true;
    });
  }

  pushSuccess() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const SuccessScreen(
        text: 'You have Successfully Withdrawn your funds',
      ),
    ));
  }
}
