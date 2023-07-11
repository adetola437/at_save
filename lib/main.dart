import 'package:at_save/Database/local_database.dart';
import 'package:at_save/bloc/budget/budget_bloc.dart';
import 'package:at_save/bloc/expense_transaction/expense_transaction_bloc.dart';
import 'package:at_save/bloc/goals/goals_bloc.dart';
import 'package:at_save/bloc/savings_transaction/savings_transactions_bloc.dart';
import 'package:at_save/bloc/target/target_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'bloc/autthentication/authentication_bloc.dart';
import 'bloc/user/user_bloc.dart';
import 'controller/splash_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize the Flutter binding

  //Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   await FirebaseMessaging.instance.getInitialMessage();
  await LocalDatabase.openIsar();
  GoogleFonts.ibmPlexSans(); // Initialize the desired font
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => AuthenticationBloc(),
          ),
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(),
          ),
          BlocProvider<TargetBloc>(
            create: (context) => TargetBloc(),
          ),
          BlocProvider<GoalsBloc>(
            create: (context) => GoalsBloc(),
          ),
          BlocProvider<SavingsTransactionsBloc>(
            create: (context) => SavingsTransactionsBloc(),
          ),
          BlocProvider<BudgetBloc>(
            create: (context) => BudgetBloc(),
          ),
          BlocProvider<ExpenseTransactionBloc>(
            create: (context) => ExpenseTransactionBloc(),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(
            home: Splash(),
          ),
        ));
  }
}
