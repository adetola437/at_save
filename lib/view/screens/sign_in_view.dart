import 'package:at_save/controller/landing_controller.dart';
import 'package:at_save/controller/sign_in_controller.dart';
import 'package:at_save/view/screens/sign_up_view.dart';
import 'package:at_save/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_validator/form_validator.dart';

import '../../boiler_plate/stateless_view.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../widgets/height.dart';

class SignInView extends StatelessView<SignInScreen, SignInController> {
  const SignInView(SignInController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.h),
                child: SizedBox(
                  height: 30.h,
                  width: 30.w,
                  child: SvgPicture.asset('assets/cancel.svg'),
                ),
              ),
              Height(60.h),
              Text(
                'Sign into your\nAccount',
                style: MyText.heading(color: AppColor.primaryColor),
              ),
              Height(10.h),
              Text(
                'log into your account',
                style: MyText.bodySm(),
              ),
              Height(80.h),
              const Head(text: 'Email'),
              Height(10.h),
              TextFormField(
                controller: controller.emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: ValidationBuilder()
                    .email()
                    .maxLength(50)
                    .required()
                    .build(),
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
              Height(20.h),
              const Head(text: 'Password'),
              Height(10.h),
              TextFormField(
                obscureText: controller.obscureText,
                controller: controller.passwordController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: ValidationBuilder().required().minLength(6).build(),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromARGB(255, 244, 241, 241),
                    enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.primaryText, width: 0)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.primaryText, width: 0)),
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.changeVisibility();
                        },
                        icon: controller.obscureText
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility))
                    //prefixIcon: Image.asset('assets/email.png')
                    ),
              ),
              Text(
                'Have you forgotten your password?',
                style: MyText.bodySm(color: AppColor.secondaryColor),
              ),
              Text(
                'Click here to recover it',
                style: MyText.bodySm(color: AppColor.primaryColor),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LandingScreen(),
                  ));
                },
                child: Padding(
                    padding: EdgeInsets.only(top: 120.h),
                    child: Button(text: 'LOG IN')),
              ),
              Height(10.h),
              Row(
                children: [
                  Text(
                    "You don't have an account?",
                    style: MyText.bodySm(color: AppColor.secondaryColor),
                  ),
                  Text(
                    'Sign up here',
                    style: MyText.bodySm(color: AppColor.primaryColor),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
