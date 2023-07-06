import 'package:at_save/view/screens/create_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  CreateController createState() => CreateController();
}

class CreateController extends State<CreateScreen> {
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
    targetController.dispose();
    descriptionController.dispose();
    nameController.dispose();
    dateController.dispose();
    savedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CreateView(this);
  static String _formatDateString(String dateString) {
    DateTime dateTime =
        DateTime.parse(dateString); // Parse input string into DateTime object
    DateFormat dayFormat = DateFormat('dd'); // Format for day (e.g. 05)
    DateFormat monthFormat = DateFormat.MMMM(); // Format for month (e.g. april)
    DateFormat weekdayFormat =
        DateFormat.EEEE(); // Format for weekday (e.g. tuesday)

    String formattedDay = dayFormat.format(dateTime);
    String formattedMonth = monthFormat.format(dateTime);
    String formattedWeekday = weekdayFormat.format(dateTime);

    return '$formattedDay $formattedMonth, $formattedWeekday';
  }

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
}
