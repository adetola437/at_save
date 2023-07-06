import 'package:at_save/theme/text.dart';
import 'package:at_save/view/screens/summary_view.dart';
import 'package:at_save/view/widgets/button.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view/widgets/outline_button.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  SummaryController createState() => SummaryController();
}

class SummaryController extends State<SummaryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SummaryView(this);

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Target Savings',
            style: MyText.bodyBold(),
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              height: 170.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 60.h,
                      width: 60.h,
                      decoration: BoxDecoration(
                          color: Colors.yellow[100],
                          borderRadius: BorderRadius.circular(50.r)),
                      child: const Icon(
                        Icons.question_mark,
                        color: Color.fromARGB(255, 244, 220, 4),
                      ),
                    ),
                  ),
                  Height(30.h),
                  SizedBox(
                    child: Text(
                      'Are you sure you want to create this target savings?',
                      style: MyText.bodySm(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pop(true); // Return true when create is pressed
                },
                child: SizedBox(
                    width: 140.w, child: const OutlineButton(text: 'Cancel'))),
            InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pop(true); // Return true when create is pressed
                },
                child: SizedBox(width: 140.w, child: Button(text: 'Create')))
          ],
        );
      },
    );
  }
}
