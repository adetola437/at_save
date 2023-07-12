import 'package:at_save/controller/success_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/expense_transaction/expense_transaction_bloc.dart';
import '../view/screens/deposit_view.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  DepositController createState() => DepositController();
}

class DepositController extends State<DepositScreen> {
  //Initialization
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? selectedOption;
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
  Widget build(BuildContext context) => DepositView(this);
///Callback function to update the current value of the selected option of the dropdown widget
  onChanged(value) {
    setState(() {
      selectedOption = value;
    });
  }
//handles loading
 void loading() {
    setState(() {
      isLoading = true;
    });
  }
///handles the user adding money to his wallet account
 void deposit() {
    if (formKey.currentState!.validate()) {  //Validating the textfields
      context.read<ExpenseTransactionBloc>().add(CreateExpenseTransaction(
          description: descriptionController.text,
          amount: double.parse(amountController.text),
          category: 'Savings',
          date: DateTime.now(),
          id: '',
          transactionType: 'deposit'));
    }
  }
///This is the action trigered when the action deposit is successful to go to the success page
  pushSuccess() {
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //   builder: (context) => const SuccessScreen(
    //     text: 'You have Successfully Deposited your funds',  //Text displayed in success screen.
    //   ),
    // ));
     context.go('/success', extra: 'You have successfully deposited your funds');
  }
}
