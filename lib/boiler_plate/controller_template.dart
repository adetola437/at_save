import 'package:at_save/boiler_plate/template_view.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  ControllerTemplate createState() => ControllerTemplate();
}

class ControllerTemplate extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => TemplateView(this);
}
