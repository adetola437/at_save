import 'package:at_save/controller/summary_controller.dart';
import 'package:at_save/view/screens/create_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../model/savings_goal.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  CreateController createState() => CreateController();
}

class CreateController extends State<CreateScreen> {

  //Initializing
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController targetController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController savedController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    //Disposing controllers
    
    targetController.dispose();
    descriptionController.dispose();
    nameController.dispose();
    dateController.dispose();
    savedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CreateView(this);

  ///This method is used to format the dateTime selected when using the showdate picker.
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
///This is the method that displays the callender widget for the user to select
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        dateController.text = _formatDateString(picked.toString());
      });
    }
  }
///This actions is called when a user has inputed all of his savings details for preview.
  void goToSummary() {
    late SavingsGoal goal;
    if (formKey.currentState!.validate()) {
      if (double.parse(savedController.text) >
          double.parse(targetController.text)) {
        Fluttertoast.showToast(
          msg: 'You cannot save more than your target',
        );
      } else {
        goal = SavingsGoal(
            createdDate: DateTime.now(),
            id: '',
            currentAmount: double.parse(savedController.text),
            title: nameController.text,
            targetAmount: double.parse(targetController.text),
            targetDate: parseDateString(dateController.text),
            description: descriptionController.text);
      }
//pushes the summary screen
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return SummaryScreen(goal: goal);
      }));
    }
  }
///Format method used to edit datetime
  DateTime parseDateString(String dateString) {
    DateFormat dateFormat = DateFormat("dd MMMM, yyyy");
    return dateFormat.parse(dateString);
  }
}
