
import 'package:flutter/material.dart';

import '../../boiler_plate/stateless_view.dart';
import '../../controller/expenses_controller.dart';

class ExpensesView extends StatelessView<ExpensesScreen, ExpensesController> {
  const ExpensesView(ExpensesController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}