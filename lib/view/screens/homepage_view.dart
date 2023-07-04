import 'package:at_save/controller/hompeage_controller.dart';
import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../boiler_plate/stateless_view.dart';

class HomePageView extends StatelessView<HomeScreen, HomeController> {
  const HomePageView(HomeController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Height(30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello Adetola',
                        style: MyText.header(),
                      ),
                      Row(
                        children: [
                          Text(
                            'Good day, Remember to save today',
                            style: MyText.mobileMd(),
                          ),
                          Image.asset('assets/money.png')
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 3, color: AppColor.secondaryColor),
                        shape: BoxShape.circle),
                    height: 50.h,
                    width: 50.h,
                    child: Center(
                      child: Text(
                        'OA',
                        style: MyText.bodyLg(),
                      ),
                    ),
                  )
                ],
              ),
              Height(20.h),
              SizedBox(
                height: 170.h,
                width: double.maxFinite,
                child: CarouselSlider.builder(
                    itemCount: 2,
                    controller: controller.carouselController,
                    autoSliderTransitionTime: const Duration(milliseconds: 500),
                    // unlimitedMode: true,
                    viewportFraction: 1,
                    initialPage: 0,
                    onSlideChanged: (value) => controller.togglePage(value),
                    slideTransform: const ForegroundToBackgroundTransform(),
                    slideBuilder: (index) {
                      return Stack(
                        children: [
                          controller.carousel[index],
                          Positioned(
                            top: 130.h,
                            left: 150.w,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    2, (index) => dotContainer(index, context)),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              Height(20.h),
              const Transaction(
                color: AppColor.shade4,
                image: 'assets/add.png',
                text: 'Add money',
              )
            ],
          ),
        ),
      )),
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
            ? AppColor.backBackground
            : AppColor.primaryText,
      ),
    );
  }
}

class Transaction extends StatelessWidget {
  final Color color;
  final String image;
  final String text;
  const Transaction({
    required this.color,
    required this.image,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 180.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r), color: color),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(image),
            Text(
              text,
              style: MyText.mobile(),
            )
          ],
        ),
      ),
    );
  }
}
