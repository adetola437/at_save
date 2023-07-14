import 'package:flutter/material.dart';

import '../view/screens/history_view.dart';

class HistoryScreen extends StatefulWidget {
  /// unique id of a goal
  final String id;
  const HistoryScreen({required this.id, super.key});

  @override
  HistoryController createState() => HistoryController();
}

class HistoryController extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => HistoryView(this);

  DateTime? previousDate;
}
