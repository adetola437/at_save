import 'package:at_save/bloc/goals/goals_bloc.dart';
import 'package:at_save/controller/success_controller.dart';
import 'package:at_save/model/savings_goal.dart';
import 'package:at_save/price_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../view/screens/edit_view.dart';

class EditScreen extends StatefulWidget {
  SavingsGoal goal;
  EditScreen({super.key, required this.goal});

  @override
  EditController createState() => EditController();
}

class EditController extends State<EditScreen> {
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController targetController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController savedController = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    // String? nameHint;
    // String?
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        dateController.text = PriceFormatter.formatDateToString(picked);
      });
    }
  }

  String _formatDateString(String dateString) {
    DateTime dateTime =
        DateTime.parse(dateString); // Parse input string into DateTime object
    DateFormat dayFormat = DateFormat('dd'); // Format for day (e.g. 05)
    DateFormat monthFormat = DateFormat.MMMM(); // Format for month (e.g. April)
    DateFormat yearFormat = DateFormat.y(); // Format for year (e.g. 2023)

    String formattedDay = dayFormat.format(dateTime);
    String formattedMonth = monthFormat.format(dateTime);
    String formattedYear = yearFormat.format(dateTime);

    return '$formattedDay $formattedMonth, $formattedYear';
  }

  String formatDateToString(DateTime dateTime) {
    DateFormat dateFormat = DateFormat("dd MMMM yyyy");
    return dateFormat.format(dateTime);
  }

  @override
  void initState() {
    setState(() {
      targetController.text = widget.goal.targetAmount.toString();
      descriptionController.text = widget.goal.description;
      nameController.text = widget.goal.title;
      dateController.text = formatDateToString(widget.goal.targetDate);
    });
    super.initState();
  }

  @override
  void dispose() {
    targetController.dispose();
    descriptionController.dispose();
    nameController.dispose();
    dateController.dispose();
    savedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => EditView(this);

  Future updateGoal() async {
    context.read<GoalsBloc>().add(UpdateGoalEvent(
        targetAmount: double.parse(targetController.text),
        goalName: nameController.text,
        golaId: widget.goal.id,
        date: PriceFormatter.parseDateString(dateController.text),
        description: descriptionController.text));
  }

  loading() {
    setState(() {
      isLoading = true;
    });
  }

  success() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const SuccessScreen(
        text: 'You have successfully updated your goal',
      ),
    ));
  }
}
