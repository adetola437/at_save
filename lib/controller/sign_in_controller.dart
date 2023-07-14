import 'package:at_save/bloc/expense_transaction/expense_transaction_bloc.dart';
import 'package:at_save/bloc/savings_transaction/savings_transactions_bloc.dart';
import 'package:at_save/bloc/visibility/visibility_bloc.dart';
import 'package:at_save/view/screens/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../bloc/autthentication/authentication_bloc.dart';
import '../bloc/budget/budget_bloc.dart';
import '../bloc/goals/goals_bloc.dart';
import '../bloc/user/user_bloc.dart';

class SignInScreen extends StatefulWidget {
  static const route = '/signin';
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
//handles the password visibilty
  void changeVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  /// navigate to the signup page
  void pushSignIn() {
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //   builder: (context) => const SignUpScreen(),
    // ));
    context.push('/sign_up');
  }

  void onLogin() async {
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    if (formKey.currentState!.validate()) {
      if (isConnected == true) {
        context.read<AuthenticationBloc>().add(EmailSignInEvent(
            email: emailController.text, password: passwordController.text));
      } else {
        Fluttertoast.showToast(msg: 'Check your Internet Connection');
      }
    }
  }

  void pushLandingPage() {
    // Navigator.of(context).pushReplacement(MaterialPageRoute(
    //   builder: (context) => const LandingScreen(),
    // ));
    context.go('/home');
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

  ///Method to pull all of the logged in user date from the server on login
  void getUserDetails() {
    context.read<UserBloc>().add(FetchUserEvent());
    context.read<GoalsBloc>().add(GetGoalsEvent());
    context.read<SavingsTransactionsBloc>().add(FetchSavingsTransactions());
    context.read<BudgetBloc>().add(FetchBudgetEvent());
    context.read<ExpenseTransactionBloc>().add(FetchExpenseTransaction());
    context.read<VisibilityBloc>().add(FetchVisibility());
  }
}
