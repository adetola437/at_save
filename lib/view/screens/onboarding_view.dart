import 'package:at_save/controller/onboarding_controller.dart';
import 'package:at_save/controller/welcome_controller.dart';
import 'package:at_save/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../boiler_plate/stateless_view.dart';
import '../widgets/button.dart';

class OnboardingView
    extends StatelessView<OnboardingScreen, OnboardingController> {
  const OnboardingView(OnboardingController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 590.h,
              child: Padding(
                padding: const EdgeInsets.only(top: 56),
                child: PageView.builder(
                    controller: controller.controller,
                    itemCount: controller.sliderNote.length,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (value) => controller.togglePage(value),
                    itemBuilder: (context, index) {
                      return controller.sliderNote[index];
                    }),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    List.generate(3, (index) => dotContainer(index, context)),
              ),
            ),
            SizedBox(
              height: 36.h,
            ),
            SizedBox(
              height: 20.h,
            ),
            controller.lastPage == false
                ? InkWell(
                    onTap: () {
                      controller.onNextClick();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Button(
                        text: 'Next',
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () {
                      controller.pushWelcomeScreen();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Button(text: 'Get Started'),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget dotContainer(index, context) {
    return Container(
      height: 10,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: controller.currentIndex == index ? 25 : 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: controller.currentIndex == index
            ? AppColor.primaryColor
            : AppColor.dart,
      ),
    );
  }
}
