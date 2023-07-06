import 'package:at_save/controller/sign_up_controller.dart';
import 'package:at_save/theme/colors.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_validator/form_validator.dart';

import '../../bloc/autthentication/authentication_bloc.dart';
import '../../boiler_plate/stateless_view.dart';
import '../../theme/text.dart';

class SignUpView extends StatelessView<SignUpScreen, SignUpController> {
  const SignUpView(SignUpController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                  'Create Account',
                  style: MyText.heading(color: AppColor.primaryColor),
                ),
                Height(10.h),
                Text(
                  'Open an account with a few details',
                  style: MyText.bodySm(),
                ),
                Height(50.h),
                const Head(text: 'Full Name'),
                Height(10.h),
                TextFormField(
                  controller: controller.nameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator:
                      ValidationBuilder().minLength(3).required().build(),
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
                const Head(text: 'Phone Number'),
                Height(10.h),
                TextFormField(
                  controller: controller.phoneNumberController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: ValidationBuilder()
                      .maxLength(11)
                      .phone()
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
                  validator:
                      ValidationBuilder().required().minLength(6).build(),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(255, 244, 241, 241),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.primaryText, width: 0)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColor.primaryText, width: 0)),
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
                Height(30.h),
                Center(
                    child: InkWell(onTap: () {
                  controller.onSignUp();
                }, child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return Container(
                      width: double.maxFinite,
                      height: 56.h,
                      decoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          borderRadius: BorderRadius.circular(16.r)),
                      child: Center(
                        child: state is AuthenticationLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600),
                              ),
                      ),
                    );
                  },
                ))),
                Height(10.h),
                Row(
                  children: [
                    Text(
                      'Do you already have an account?',
                      style: MyText.bodySm(color: AppColor.secondaryColor),
                    ),
                    Text(
                      'Sign in here',
                      style: MyText.bodySm(color: AppColor.primaryColor),
                    )
                  ],
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}

class Head extends StatelessWidget {
  final String text;
  const Head({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: MyText.mobile(),
    );
  }
}
