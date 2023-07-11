import 'package:at_save/Database/remote_database.dart';
import 'package:at_save/view/screens/landing_view.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  LandingController createState() => LandingController();
}

class LandingController extends State<LandingScreen> {
  var selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LandingView(this);

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

}
