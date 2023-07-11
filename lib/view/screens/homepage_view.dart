import 'package:at_save/controller/hompeage_controller.dart';
import 'package:at_save/price_format.dart';
import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Database/remote_database.dart';
import '../../bloc/user/user_bloc.dart';
import '../../boiler_plate/stateless_view.dart';

class HomePageView extends StatelessView<HomeScreen, HomeController> {
  const HomePageView(HomeController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backBackground,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Height(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is UserSuccess) {
                            String fullname = state.user.name;
                            String name = PriceFormatter.getFirstName(fullname);
                            return SizedBox(
                              width: 200.w,
                              child: Text(
                                'Hello $name',
                                style: MyText.header(),
                              ),
                            );
                          }
                          return Container();
                        },
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
                height: 140.h,
                width: double.maxFinite,
                child: CarouselSlider.builder(
                    itemCount: 2,
                    controller: controller.carouselController,
                    autoSliderTransitionTime: const Duration(milliseconds: 500),
                    // unlimitedMode: true,
                    viewportFraction: 0.9,
                    initialPage: 0,
                    onSlideChanged: (value) => controller.togglePage(value),
                    slideTransform: const ForegroundToBackgroundTransform(),
                    slideBuilder: (index) {
                      return controller.carousel[index];
                    }),
              ),
              Height(20.h),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      List.generate(2, (index) => dotContainer(index, context)),
                ),
              ),
              Height(20.h),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      print('ppp');
                      RemoteDatabase remoteDatabase = RemoteDatabase();
                      remoteDatabase.sendPushNotification(
                          'eaiLQvQyTAOS1YlxfWGeUV:APA91bEsE_aXRheVjLI0Oa6X8i5gNsQL25FzRkO38ZtXFuevCgZK1ZzljrRya_0SLorC20Wy2Pbr-zIufYGFC1s-rlvBUrIdMx0QG6X8xvn2Nq8L7P4F3fR89WgBmtKQAdv3i5SxJ3hP',
                          'Credit',
                          'You have Successfully Received  from ');
                    },
                    child: const Transaction(
                      color: AppColor.shade4,
                      image: 'assets/add.png',
                      text: 'Add money',
                    ),
                  ),
                  Width(20.w),
                  const Transaction(
                    color: AppColor.shade5,
                    image: 'assets/withdraw.png',
                    text: 'Withdraw',
                  ),
                ],
              ),
              Height(20.h),
              Text(
                'Get your money working for you',
                style: MyText.mobile(),
              ),
              Height(15.h),
              const SavingsCard(
                color: AppColor.primaryColor,
                icon: Icons.wallet,
                text: 'Save for an Emergency',
              ),
              Height(10.h),
              const SavingsCard(
                color: AppColor.primaryColor,
                icon: Icons.pie_chart,
                text: 'Manage your Expenses',
              ),
              Height(20.h),
              Text(
                'Ways to earn more money',
                style: MyText.mobile(),
              ),
              Height(15.h),
              const SavingsCard(
                  icon: Icons.people,
                  text: 'Invite your friends and get more money',
                  color: AppColor.complementaryColor1)
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
            ? AppColor.primaryColor
            : AppColor.primaryText,
      ),
    );
  }
}

class SavingsCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const SavingsCard({
    required this.icon,
    required this.text,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Container(
        height: 60.h,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: color.withOpacity(0.1),
                    ),
                    child: Icon(
                      icon,
                      color: color.withOpacity(0.8),
                    ),
                  ),
                  Width(30.w),
                  SizedBox(
                    width: 160.w,
                    child: Text(
                      text,
                      style: MyText.mobileMd(),
                    ),
                  )
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 15.sp,
                color: AppColor.secondaryColor,
              )
            ],
          ),
        ),
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
      width: 150.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r), color: color),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
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
