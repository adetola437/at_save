import 'package:at_save/bloc/autthentication/authentication_bloc.dart';
import 'package:at_save/controller/sign_in_controller.dart';
import 'package:at_save/shared_preferences/session_manager.dart';
import 'package:at_save/view/screens/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'landing_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileController createState() => ProfileController();
}

class ProfileController extends State<ProfileScreen> {
  SessionManager manager = SessionManager();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ProfileView(this);

  Future _confirmLogout(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  logout() async {
    final confirmed = await _confirmLogout(context);
    if (confirmed) {
      context.read<AuthenticationBloc>().add(LogOutEvent());
      context.go(SignInScreen.route);
      currentIndex.value = 0;

      //   Add your logout code here
    }
  }

  String getInitials(String fullName) {
    final nameParts = fullName.split(' ');
    final firstName = nameParts[0].trim();

    if (nameParts.length > 1) {
      final lastName = nameParts[nameParts.length - 1].trim();
      return '${firstName[0]}${lastName[0]}';
    } else {
      return firstName[0];
    }
  }
}
