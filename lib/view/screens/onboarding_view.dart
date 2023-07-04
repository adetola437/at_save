import 'package:at_save/controller/onboarding_controller.dart';
import 'package:at_save/controller/welcome_controller.dart';
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
              height: 570.h,
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
              height: 50.h,
            ),
            controller.lastPage == false
                ? GestureDetector(
                    onTap: () {
                      controller.onNextClick();
                    },
                    child: Button(
                      text: 'Next',
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ));
                    },
                    child: Button(text: 'Get Started'),
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
        color: controller.currentIndex == index ? Colors.red : Colors.grey,
      ),
    );
  }
}
