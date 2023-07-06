import 'package:at_save/view/screens/savings_view.dart';
import 'package:flutter/material.dart';

class SavingsScreen extends StatefulWidget {
  const SavingsScreen({super.key});

  @override
  SavingsController createState() => SavingsController();
}

class SavingsController extends State<SavingsScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SavingsView(this);
}
