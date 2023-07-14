import 'package:at_save/controller/create_controller.dart';
import 'package:at_save/controller/deposit_controller.dart';
import 'package:at_save/controller/details_controller.dart';
import 'package:at_save/controller/edit_details_controller.dart';
import 'package:at_save/controller/error_controller.dart';
import 'package:at_save/controller/landing_controller.dart';
import 'package:at_save/controller/onboarding_controller.dart';
import 'package:at_save/controller/sign_in_controller.dart';
import 'package:at_save/controller/splash_controller.dart';
import 'package:at_save/controller/success_controller.dart';
import 'package:at_save/controller/summary_controller.dart';
import 'package:at_save/controller/view_history_controller.dart';
import 'package:at_save/controller/welcome_controller.dart';
import 'package:at_save/controller/withdraw_controller.dart';
import 'package:at_save/model/savings_goal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controller/sign_up_controller.dart';

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Splash();
      },
    ),
    GoRoute(
      path: '/onBoarding',
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingScreen();
      },
    ),
    GoRoute(
      path: '/welcome',
      builder: (BuildContext context, GoRouterState state) {
        return const WelcomeScreen();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const LandingScreen();
      },
    ),
    GoRoute(
      path: '/sign_up',
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpScreen();
      },
    ),
    GoRoute(
      path: SignInScreen.route,
      builder: (BuildContext context, GoRouterState state) {
        return const SignInScreen();
      },
    ),
    GoRoute(
      path: '/success',
      builder: (BuildContext context, GoRouterState state) {
        return SuccessScreen(text: state.extra as String);
      },
    ),
    GoRoute(
      path: '/create_goal',
      builder: (BuildContext context, GoRouterState state) {
        return const CreateScreen();
      },
    ),
     GoRoute(
      path: '/summary',
      builder: (BuildContext context, GoRouterState state) {
        return  SummaryScreen(goal: state.extra as SavingsGoal);
      },
    ),
     GoRoute(
      path: '/details',
      builder: (BuildContext context, GoRouterState state) {
        return  DetailsScreen(goalId: state.extra as String);
      },
    ),
     GoRoute(
      path: '/edit_screen',
      builder: (BuildContext context, GoRouterState state) {
        return  EditScreen(goal: state.extra as SavingsGoal);
      },
    ),
     GoRoute(
      path: '/history',
      builder: (BuildContext context, GoRouterState state) {
        return HistoryScreen(id: state.extra as String);
      },
    ),
     GoRoute(
      path: '/error',
      builder: (BuildContext context, GoRouterState state) {
        return ErrorScreen(text: state.extra as String,);
      },
    ),
     GoRoute(
      path: '/withdraw',
      builder: (BuildContext context, GoRouterState state) {
        return WithdrawScreen();
      },
    ),
     GoRoute(
      path: '/deposit',
      builder: (BuildContext context, GoRouterState state) {
        return DepositScreen();
      },
    ),
  ],
);
