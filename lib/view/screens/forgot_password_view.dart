import 'package:at_save/view/screens/sign_up_view.dart';
import 'package:at_save/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';

import '../../boiler_plate/stateless_view.dart';
import '../../controller/forgot_password_controller.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../widgets/height.dart';

class ForgotPasswordView
    extends StatelessView<ForgotPasswordScreen, ForgotPasswordController> {
  const ForgotPasswordView(ForgotPasswordController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                context.pop();
              },
              child: Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: SizedBox(
                  height: 30.h,
                  width: 30.w,
                  child: SvgPicture.asset('assets/cancel.svg'),
                ),
              ),
            ),
            Height(60.h),
            Text(
              'Forgot Password?',
              style: MyText.heading(color: AppColor.primaryColor),
            ),
            Height(10.h),
            Text(
              'Please enter your email to recover your password',
              style: MyText.bodySm(),
            ),
            Height(80.h),
            const Head(text: 'Email'),
            Height(10.h),
            TextFormField(
              controller: controller.emailController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator:
                  ValidationBuilder().email().maxLength(50).required().build(),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 244, 241, 241),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColor.primaryText, width: 0)),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColor.primaryText, width: 0)),
                //prefixIcon: Image.asset('assets/email.png')
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 300.h),
              child: Button(text: 'Recover Password'),
            )
          ],
        ),
      )),
    );
  }
}
