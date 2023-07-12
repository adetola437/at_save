import 'package:at_save/controller/deposit_controller.dart';
import 'package:at_save/controller/withdraw_controller.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  /// triggers the withdrae feature
  pushWithdraw() {
    context.push('/withdraw');
    //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    //     return const WithdrawScreen();
    //   }));
  }
//push the depoist screen
  pushDeposit() {
    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    //   return const DepositScreen();
    // }));\

    context.push('/deposit');
  }
}
