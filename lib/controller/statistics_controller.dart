import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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

  /// triggers the withdraw feature
  pushWithdraw() async {
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    if (isConnected == true) {
      context.push('/withdraw');
    } else {
      Fluttertoast.showToast(msg: 'Check your internet connection');
    }

    //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    //     return const WithdrawScreen();
    //   }));
  }

//push the depoist screen
  pushDeposit() async {
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    //   return const DepositScreen();
    // }));\
    if (isConnected == true) {
      context.push('/deposit');
    } else {
      Fluttertoast.showToast(msg: 'Check your internet connection');
    }
  }
}
