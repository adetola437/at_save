import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/view/widgets/button.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../boiler_plate/stateless_view.dart';
import '../../controller/error_controller.dart';

class ErrorView extends StatelessView<ErrorScreen, ErrorController> {
  const ErrorView(ErrorController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Height(200.h),
              SizedBox(
                height: 200.h,
                width: 200.h,
                child: Image.asset(
                  'assets/error.png',
                ),
              ),
              Text(
                'Oops Something Went Wrong!!!',
                style: MyText.bodyLg(color: AppColor.primaryColor),
              ),
              Height(10.h),
              Text(
                controller.widget.text == null ? '' : controller.widget.text!,
                style: MyText.body(),
              ),
              Height(200.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: InkWell(
                    onTap: () {
                      controller.goToHomePage();
                    },
                    child: Button(text: 'Go To HomePage')),
              )
            ],
          ),
        ),
      )),
    );
  }
}
