import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/view/widgets/button.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../bloc/goals/goals_bloc.dart';
import '../../bloc/user/user_bloc.dart';
import '../../boiler_plate/stateless_view.dart';
import '../../controller/add_money_controller.dart';
import '../widgets/outline_button.dart';

class AddMoneyView extends StatelessView<AddMoneyScreen, AddMoneyController> {
  const AddMoneyView(AddMoneyController controller, {Key? key})
      : super(controller, key: key);

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Target Savings',
            style: MyText.bodyBold(),
          ),
          content: SingleChildScrollView(
            child: SizedBox(
              height: 170.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 60.h,
                      width: 60.h,
                      decoration: BoxDecoration(
                          color: Colors.yellow[100],
                          borderRadius: BorderRadius.circular(50.r)),
                      child: const Icon(
                        Icons.question_mark,
                        color: Color.fromARGB(255, 244, 220, 4),
                      ),
                    ),
                  ),
                  Height(30.h),
                  SizedBox(
                    child: Text(
                      'Are you sure you want to create this target savings?',
                      style: MyText.bodySm(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pop(false); // Return true when create is pressed
                },
                child: SizedBox(
                    width: 140.w, child: const OutlineButton(text: 'No'))),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserSuccess) {
                  return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pop(true); // Return true when create is pressed

                        controller.addMoney(state.user.walletBalance!);
                        // controller.createTransaction();

                        // Navigator.pop(context);
                      },
                      child:
                          SizedBox(width: 140.w, child: Button(text: 'Yes')));
                }
                return Container();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoalsBloc, GoalsState>(
      listener: (context, state) {
        if (state is GoalTopUp) {
          controller.pushSucess();
        }
        if (state is GoalsLoading) {
          controller.loading();
        }
      },
      child: OverlayLoaderWithAppIcon(
        isLoading: controller.isLoading,
        appIcon: SvgPicture.asset(
          'assets/green.svg',
          color: AppColor.primaryColor,
        ),
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Height(10.h),
                    SvgPicture.asset('assets/cancel.svg'),
                    Height(50.h),
                    Column(
                      children: [
                        Text(
                          "Let's help you save",
                          style: MyText.bodyLg(color: AppColor.primaryText),
                        ),
                        Height(15.h),
                        Text(
                          'Enter the amount you want to save',
                          style: MyText.mobileMd(),
                        ),
                        Height(40.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'N',
                              style:
                                  MyText.bodyBold(color: AppColor.primaryColor),
                            ),
                            Text(
                              controller.pin,
                              style:
                                  MyText.bodyBold(color: AppColor.primaryColor),
                            )
                          ],
                        ),
                        Height(30.h),
                        Container(
                          decoration: const BoxDecoration(),
                          height: 400.h,
                          width: double.maxFinite,
                          child: Column(
                            children: [
                              Height(50.h),
                              SizedBox(
                                width: 300.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildPinDigitButton('1'),
                                    _buildPinDigitButton('2'),
                                    _buildPinDigitButton('3'),
                                  ],
                                ),
                              ),
                              SizedBox(height: 50.h),
                              SizedBox(
                                width: 300.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildPinDigitButton('4'),
                                    _buildPinDigitButton('5'),
                                    _buildPinDigitButton('6'),
                                  ],
                                ),
                              ),
                              SizedBox(height: 50.h),
                              SizedBox(
                                width: 300.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildPinDigitButton('7'),
                                    _buildPinDigitButton('8'),
                                    _buildPinDigitButton('9'),
                                  ],
                                ),
                              ),
                              SizedBox(height: 50.h),
                              SizedBox(
                                width: 300.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Width(50.w),
                                    _buildPinDigitButton('0'),
                                    _buildPinDigitButton('',
                                        icon: Icons.backspace),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Height(70.h),
                        InkWell(
                            onTap: () {
                              showConfirmationDialog(context);
                            },
                            child: Button(text: 'CONTINUE'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinDigitButton(String digit, {IconData? icon}) {
    final isBackspace = icon == Icons.backspace;
    const textStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
    return InkWell(
      onTap: isBackspace
          ? controller.removeDigit
          : () => controller.addDigit(digit),
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: isBackspace ? Colors.red : Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: icon != null
              ? Icon(
                  icon,
                  color: Colors.white,
                )
              : Text(
                  digit,
                  style: MyText.bodyLgBold(),
                ),
        ),
      ),
    );
  }
}
