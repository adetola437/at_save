import 'package:at_save/controller/onboarding_controller.dart';
import 'package:at_save/controller/sign_in_controller.dart';
import 'package:at_save/controller/splash_controller.dart';
import 'package:at_save/controller/welcome_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'controller/sign_up_controller.dart';

final GoRouter router = GoRouter(debugLogDiagnostics: true, routes: <GoRoute>[
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
    },routes: [
       GoRoute(
    path: '/signin',
    builder: (BuildContext context, GoRouterState state) {
      return const SignInScreen();
    },
  ),
    GoRoute(
    path: '/signup',
    builder: (BuildContext context, GoRouterState state) {
      return const SignUpScreen();
    },
  ),
    ]
  ),

]);
