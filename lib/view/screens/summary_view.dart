import 'package:at_save/view/widgets/button.dart';
import 'package:at_save/view/widgets/summary_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../bloc/target/target_bloc.dart';
import '../../bloc/user/user_bloc.dart';
import '../../boiler_plate/stateless_view.dart';
import '../../controller/summary_controller.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../../utils/price_format.dart';
import '../widgets/description_text.dart';
import '../widgets/heading.dart';
import '../widgets/height.dart';
import '../widgets/nav_container.dart';

class SummaryView extends StatelessView<SummaryScreen, SummaryController> {
  const SummaryView(SummaryController controller, {Key? key})
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
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('cancel')),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserSuccess) {
                  return ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(true); // Return true when create is pressed

                        controller.createGoal(state.user.walletBalance!);
                      },
                      child: const Text('Create'));
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
    return OverlayLoaderWithAppIcon(
      isLoading: controller.isLoading,
      appIcon: SvgPicture.asset(
        'assets/green.svg',
        color: AppColor.primaryColor,
      ),
      child: BlocListener<TargetBloc, TargetState>(
        listener: (context, state) {
          if (state is TargetLoaded) {
            print('targetLoaded');
            controller.success();
          }
          if (state is TargetLoading) {
            controller.loading();
          }
          if (state is TargetError) {
            controller.error();
          }
          // TODO: implement listener
        },
        child: Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Height(10.h),
                  InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: NavContainer(icon: Icons.arrow_back_ios)),
                  Height(10.h),
                  const Heading(text: 'Summary'),
                  Height(10.h),
                  const DescriptionText(
                      text: 'Here is what your goal will look like.'),
                  Height(40.h),
                  Details(
                      icon: Icons.money,
                      leadng: 'Goal Name',
                      trailing: controller.widget.goal.title),
                  const Divider(),
                  Height(20.h),
                  Details(
                      icon: Icons.calendar_month,
                      leadng: 'Expiry Date',
                      trailing: controller.formatDateToString(
                          controller.widget.goal.targetDate)),
                  const Divider(),
                  Height(20.h),
                  Details(
                      icon: Icons.note,
                      leadng: 'Description',
                      trailing: controller.widget.goal.description),
                  const Divider(),
                  Height(20.h),
                  Details(
                      icon: Icons.currency_exchange,
                      leadng: 'Amount Saved',
                      trailing: PriceFormatter.formatPrice(
                          controller.widget.goal.currentAmount)),
                  const Divider(),
                  Height(20.h),
                  const Details(
                      icon: Icons.interests,
                      leadng: 'Interest Rate',
                      trailing: '5% per month'),
                  const Divider(),
                  Height(40.h),
                  Container(
                    height: 100.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: AppColor.backBackground),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Height(20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Buy a Laptop',
                                style: MyText.mobile(
                                    color: AppColor.secondaryColor),
                              ),
                              Text(
                                'N${PriceFormatter.formatPrice(widget.goal.currentAmount)} / N${PriceFormatter.formatPrice(widget.goal.targetAmount)} ',
                                style: MyText.mobile(
                                    color: AppColor.secondaryColor),
                              )
                            ],
                          ),
                        ),
                        Height(20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r)),
                            height: 20.h,
                            width: double.maxFinite,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 260.w,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        8.0), // Adjust the value as needed
                                    child: LinearProgressIndicator(
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              AppColor.analogousColor2),
                                      minHeight: 9,
                                      backgroundColor: Colors.white,
                                      value: widget.goal.currentAmount /
                                          widget.goal.targetAmount,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${((widget.goal.currentAmount / widget.goal.targetAmount) * 100).toStringAsFixed(1)}%',
                                  style: MyText.mobile(),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 120.h),
                    child: InkWell(
                        onTap: () {
                          showConfirmationDialog(context);
                        },
                        child: Button(text: 'Create Target')),
                  )
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
