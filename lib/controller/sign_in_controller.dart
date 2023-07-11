import 'package:at_save/bloc/expense_transaction/expense_transaction_bloc.dart';
import 'package:at_save/bloc/savings_transaction/savings_transactions_bloc.dart';
import 'package:at_save/controller/landing_controller.dart';
import 'package:at_save/controller/sign_up_controller.dart';
import 'package:at_save/view/screens/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/autthentication/authentication_bloc.dart';
import '../bloc/budget/budget_bloc.dart';
import '../bloc/goals/goals_bloc.dart';
import '../bloc/user/user_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  SignInController createState() => SignInController();
}

class SignInController extends State<SignInScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool obscureText = true;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SignInView(this);

  void changeVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  void pushSignIn() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const SignUpScreen(),
    ));
  }

  void onLogin() {
    if (formKey.currentState!.validate()) {
      context.read<AuthenticationBloc>().add(EmailSignInEvent(
          email: emailController.text, password: passwordController.text));
    }
  }

  void pushLandingPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LandingScreen(),
    ));
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

  void getUserDetails() {
    context.read<UserBloc>().add(FetchUserEvent());
    context.read<GoalsBloc>().add(GetGoalsEvent());
    context.read<SavingsTransactionsBloc>().add(FetchSavingsTransactions());
    context.read<BudgetBloc>().add(FetchBudgetEvent());
    context.read<ExpenseTransactionBloc>().add(FetchExpenseTransaction());
  }
}
