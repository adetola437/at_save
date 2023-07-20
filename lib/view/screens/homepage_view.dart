import 'package:at_save/controller/hompeage_controller.dart';
import 'package:at_save/controller/landing_controller.dart';
import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/utils/price_format.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:shimmer/shimmer.dart';

import '../../bloc/budget/budget_bloc.dart';
import '../../bloc/user/user_bloc.dart';
import '../../boiler_plate/stateless_view.dart';
import '../widgets/carousel_widget.dart';

class HomePageView extends StatelessView<HomeScreen, HomeController> {
  const HomePageView(HomeController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return OverlayLoaderWithAppIcon(
      isLoading: controller.isLoading,
      appIcon: SvgPicture.asset(
        'assets/green.svg',
        color: AppColor.primaryColor,
      ),
      child: Scaffold(
        backgroundColor: AppColor.backBackground,
        body: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserLoading) {
              controller.loading();
            }
            if (state is UserSuccess) {
              controller.notLoading();
            }
            // TODO: implement listener
          },
          child: SafeArea(
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
                              if (state is UserLoading) {
                                return Column(
                                  children: [
                                    Shimmer(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.grey[300]!,
                                          Colors.grey[100]!,
                                          Colors.grey[300]!,
                                        ],
                                        begin: const Alignment(-1.0, 0.0),
                                        end: const Alignment(2.0, 0.0),
                                        stops: const [0.0, 0.5, 1.0],
                                      ),
                                      // duration: Duration(seconds: 1),
                                      child: Container(
                                        width: 200.w,
                                        height: 30.h,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Shimmer(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.grey[300]!,
                                          Colors.grey[100]!,
                                          Colors.grey[300]!,
                                        ],
                                        begin: const Alignment(-1.0, 0.0),
                                        end: const Alignment(2.0, 0.0),
                                        stops: const [0.0, 0.5, 1.0],
                                      ),
                                      // duration: Duration(seconds: 1),
                                      child: Container(
                                        width: 200.w,
                                        height: 20.h,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                );
                              } else if (state is UserSuccess) {
                                String fullname = state.user.name;
                                String name =
                                    PriceFormatter.getFirstName(fullname);
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
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is UserSuccess) {
                            String initials =
                                controller.getInitials(state.user.name);
                            return Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 3, color: AppColor.secondaryColor),
                                  shape: BoxShape.circle),
                              height: 50.h,
                              width: 50.h,
                              child: Center(
                                child: Text(
                                  initials,
                                  style: MyText.bodyLg(),
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                  Height(20.h),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return Column(
                          children: [
                            Shimmer(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.grey[300]!,
                                  Colors.grey[100]!,
                                  Colors.grey[300]!,
                                ],
                                begin: const Alignment(-1.0, 0.0),
                                end: const Alignment(2.0, 0.0),
                                stops: const [0.0, 0.5, 1.0],
                              ),
                              // duration: Duration(seconds: 1),
                              child: Container(
                                width: double.maxFinite,
                                height: 140.h,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        );
                      }
                      if (state is UserSuccess) {
                        List<CarouselWidget> carousel = [
                          CarouselWidget(
                            amount: state.user.savingsBalance! +
                                state.user.walletBalance!,
                            title: 'Total Balance',
                            color: AppColor.primaryColor,
                          ),
                          CarouselWidget(
                            amount: state.user.savingsBalance!,
                            title: 'Total Savings',
                            color: AppColor.complementaryColor1,
                          )
                        ];
                        return SizedBox(
                          height: 140.h,
                          width: double.maxFinite,
                          child: CarouselSlider.builder(
                              itemCount: 2,
                              controller: controller.carouselController,
                              autoSliderTransitionTime:
                                  const Duration(milliseconds: 500),
                              // unlimitedMode: true,
                              viewportFraction: 0.9,
                              initialPage: 0,
                              onSlideChanged: (value) =>
                                  controller.togglePage(value),
                              slideTransform:
                                  const ForegroundToBackgroundTransform(),
                              slideBuilder: (index) {
                                return carousel[index];
                              }),
                        );
                      }
                      return Container();
                    },
                  ),
                  Height(20.h),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          2, (index) => dotContainer(index, context)),
                    ),
                  ),
                  Height(20.h),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          context.push('/deposit');
                        },
                        child: const Transaction(
                          color: AppColor.shade4,
                          image: 'assets/add.png',
                          text: 'Add money',
                        ),
                      ),
                      Width(20.w),
                      BlocBuilder<BudgetBloc, BudgetState>(
                        builder: (context, state) {
                          if (state is BudgetLoaded) {
                            return InkWell(
                              onTap: () {
                                if (state.budget.isNotEmpty) {
                                  controller.goToWithdraw();
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          'You need to create a budget to be able to withdraw.');
                                }
                              },
                              child: const Transaction(
                                color: AppColor.shade5,
                                image: 'assets/withdraw.png',
                                text: 'Withdraw',
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                  Height(20.h),
                  Text(
                    'Get your money working for you',
                    style: MyText.mobile(),
                  ),
                  Height(15.h),
                  InkWell(
                    onTap: () {
                      currentIndex.value = 1;
                    },
                    child: const SavingsCard(
                      color: AppColor.primaryColor,
                      icon: Icons.wallet,
                      text: 'Save for an Emergency',
                    ),
                  ),
                  Height(10.h),
                  InkWell(
                    onTap: () {
                      currentIndex.value = 2;
                    },
                    child: const SavingsCard(
                      color: AppColor.primaryColor,
                      icon: Icons.pie_chart,
                      text: 'Manage your Expenses',
                    ),
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
