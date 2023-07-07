import 'package:at_save/price_format.dart';
import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/view/widgets/header_row.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:at_save/view/widgets/savings_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../bloc/goals/goals_bloc.dart';
import '../../bloc/user/user_bloc.dart';
import '../../boiler_plate/stateless_view.dart';
import '../../controller/details_controller.dart';
import '../widgets/small_button.dart';
import '../widgets/summary_details.dart';

class DetailsView extends StatelessView<DetailsScreen, DetailsController> {
  const DetailsView(DetailsController controller, {Key? key})
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
        body: SafeArea(
            child: BlocConsumer<GoalsBloc, GoalsState>(
          listener: (context, state) {
            if (state is GoalsLoading) {
              controller.loading();
            }
            if (state is GoalsLoaded) {
              controller.notLoading();
              context.read<UserBloc>().add(FetchUserEvent());
            }
            if (state is GoalsLoadingError) {
              controller.notLoading();
              Fluttertoast.showToast(msg: 'Error Adding savings');
            }
          },
          builder: (context, state) {
            if (state is GoalsLoaded) {
              final goal = state.goals
                  .firstWhere((g) => g.id == controller.widget.goalId);
              print(goal.id);
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Height(10.h),
                      const HeaderRow(
                          leading: Icons.arrow_back_ios,
                          text: '',
                          trailing: Icons.notifications_none),
                      Height(20.h),
                      Container(
                        height: 100.h,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            image: const DecorationImage(
                                image: AssetImage(
                                  'assets/box4.png',
                                ),
                                fit: BoxFit.cover)),
                        child: Center(
                            child: Text(
                          goal.title,
                          style:
                              MyText.bodyBold(color: AppColor.backBackground),
                        )),
                      ),
                      Height(20.h),
                      Text(
                        'My Balance',
                        style: MyText.mobileMd(),
                      ),
                      Height(10.h),
                      Text(
                        'N${PriceFormatter.formatPrice(goal.currentAmount)}',
                        style: MyText.bodyBold(),
                      ),
                      Height(10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 260.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  8.0), // Adjust the value as needed
                              child: LinearProgressIndicator(
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    AppColor.primaryColor),
                                minHeight: 9,
                                backgroundColor: AppColor.backGround,
                                value: goal.currentAmount / goal.targetAmount,
                              ),
                            ),
                          ),
                          Text(
                            '${((goal.currentAmount / goal.targetAmount) * 100).toStringAsFixed(1)}%',
                            style: MyText.mobile(),
                          )
                        ],
                      ),
                      Height(30.h),
                      Details(
                          icon: Icons.currency_pound_sharp,
                          leadng: 'My Target',
                          trailing:
                              PriceFormatter.formatPrice(goal.targetAmount)),
                      const Divider(),
                      Height(20.h),
                      Details(
                          icon: Icons.calendar_month,
                          leadng: 'Start Date',
                          trailing: goal.createdDate.toIso8601String()),
                      const Divider(),
                      Height(20.h),
                      Details(
                          icon: Icons.calendar_month,
                          leadng: 'Withdrawal Date',
                          trailing: goal.targetDate.toIso8601String()),
                      const Divider(),
                      Height(20.h),
                      Details(
                          icon: Icons.note,
                          leadng: 'Description',
                          trailing: goal.description),
                      const Divider(),
                      Height(70.h),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SavingsAction(text: 'Edit', icon: Icons.edit_note),
                          SavingsAction(text: 'Delete', icon: Icons.delete),
                          SavingsAction(text: 'Break', icon: Icons.lock_open),
                        ],
                      ),
                      Height(60.h),
                      Center(
                        child: SizedBox(
                            child: InkWell(
                                onTap: () {
                                  // controller.addMoney();
                                  controller.pushToAddPage();
                                },
                                child: SmallButton(text: 'Add Money'))),
                      )
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        )),
      ),
    );
  }
}
