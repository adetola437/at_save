import 'package:flutter/material.dart';

import '../view/screens/statistics_view.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  StatisticsController createState() => StatisticsController();
}

class StatisticsController extends State<StatisticsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StatisticsView(this);
}