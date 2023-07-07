import 'package:at_save/bloc/goals/goals_bloc.dart';
import 'package:at_save/bloc/user/user_bloc.dart';
import 'package:at_save/controller/sign_in_controller.dart';
import 'package:at_save/view/screens/sign_up_view.dart';
import 'package:at_save/view/widgets/description_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../bloc/autthentication/authentication_bloc.dart';
import '../../boiler_plate/stateless_view.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../widgets/heading.dart';
import '../widgets/height.dart';

class SignInView extends StatelessView<SignInScreen, SignInController> {
  const SignInView(SignInController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverlayLoaderWithAppIcon(
        isLoading: controller.isLoading,
        appIcon: SvgPicture.asset(
          'assets/green.svg',
          color: AppColor.primaryColor,
        ),
        child: SafeArea(
            child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is AuthenticationSuccess) {
                    controller.getUserDetails();
                    controller.loading();
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (BuildContext context) {
                    //   return LoadingScreen();
                    // }));
                  }
                },
                child: BlocListener<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state is UserSuccess) {
                      controller.pushLandingPage();
                      controller.notLoading();
                    }
                    if (state is UserError) {
                      controller.notLoading();
                    }
                  },
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
                      const Heading(
                        text: 'Sign into your\nAccount',
                      ),
                      Height(10.h),
                      const DescriptionText(text: 'log into your account'),
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
                              borderSide: BorderSide(
                                  color: AppColor.primaryText, width: 0)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColor.primaryText, width: 0)),
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
                          controller.onLogin();
                        },
                        child: Padding(
                            padding: EdgeInsets.only(top: 120.h),
                            child: BlocBuilder<AuthenticationBloc,
                                AuthenticationState>(
                              builder: (context, state) {
                                return Container(
                                  width: double.maxFinite,
                                  height: 56.h,
                                  decoration: BoxDecoration(
                                      color: AppColor.primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(16.r)),
                                  child: Center(
                                    child: state is AuthenticationLoading
                                        ? const CircularProgressIndicator()
                                        : Text(
                                            'LOG IN',
                                            style: MyText.bodyBold(
                                                color: AppColor.white),
                                          ),
                                  ),
                                );
                              },
                            )),
                      ),
                      Height(10.h),
                      Row(
                        children: [
                          Text(
                            "You don't have an account?",
                            style:
                                MyText.bodySm(color: AppColor.secondaryColor),
                          ),
                          InkWell(
                            onTap: () {
                              controller.pushSignIn();
                            },
                            child: Text(
                              'Sign up here',
                              style:
                                  MyText.bodySm(color: AppColor.primaryColor),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
