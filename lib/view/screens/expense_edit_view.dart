import 'package:flutter/material.dart';

import '../../boiler_plate/stateless_view.dart';
import '../../controller/expense_edit_controller.dart';

class ExpenseEditView extends StatelessView<ExpenseEditScreen,ExpenseEditController> {
  const ExpenseEditView(ExpenseEditController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}