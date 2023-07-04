import 'package:at_save/boiler_plate/stateless_view.dart';
import 'package:flutter/material.dart';

import 'controller_template.dart';



class TemplateView extends StatelessView<HomeScreen,ControllerTemplate> {
  const TemplateView(ControllerTemplate controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}