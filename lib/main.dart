import 'package:at_save/Database/local_database.dart';
import 'package:at_save/bloc/goals/goals_bloc.dart';
import 'package:at_save/bloc/target/target_bloc.dart';
import 'package:at_save/view/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bloc/autthentication/authentication_bloc.dart';
import 'bloc/user/user_bloc.dart';
import 'firebase_options.dart';

import 'controller/splash_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize the Flutter binding

  //Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (context, child) => const MaterialApp(
            home: Splash(),
          ),
        ));
  }
}
