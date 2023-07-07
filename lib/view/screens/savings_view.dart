import 'package:at_save/controller/create_controller.dart';
import 'package:at_save/controller/savings_controller.dart';
import 'package:at_save/model/savings_goal.dart';
import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/view/widgets/carousel_widget.dart';
import 'package:at_save/view/widgets/header_row.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:at_save/view/widgets/small_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/goals/goals_bloc.dart';
import '../../bloc/user/user_bloc.dart';
import '../../boiler_plate/stateless_view.dart';
import '../widgets/savings_widget.dart';

class SavingsView extends StatelessView<SavingsScreen, SavingsController> {
  const SavingsView(SavingsController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: RefreshIndicator(
      onRefresh: () {
        return controller.onRefresh();
      },
      child: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Height(10.h),
            const HeaderRow(
                leading: Icons.arrow_back_ios,
                text: 'Savings',
                trailing: Icons.save),
            Height(20.h),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserSuccess) {
                  double amount = state.user.savingsBalance!.toDouble();
                  return SizedBox(
                    height: 150.h,
                    width: double.maxFinite,
                    child: CarouselWidget(
                        amount: amount,
                        title: 'My Savings',
                        color: AppColor.primaryColor),
                  );
                }
                return Container();
              },
            ),
            Height(20.h),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Goals',
                    style: MyText.bodyBold(),
                  ),
                  Container(
                    child: TabBar(
                        labelPadding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 0.h),
                        controller: controller.tabController,
                        labelColor: Colors.white,
                        indicator: BoxDecoration(
                            color: AppColor.primaryColor,
                            borderRadius: BorderRadius.circular(15)),
                        labelStyle: MyText.mobile(),
                        unselectedLabelColor: Colors.black,
                        isScrollable: true,
                        tabs: const [
                          Tab(
                            text: 'All',
                          ),
                          Tab(
                            text: 'Active',
                          ),
                          Tab(
                            text: 'Completed',
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 400.h,
              width: double.maxFinite,
              child: Stack(
                children: [
                  BlocBuilder<GoalsBloc, GoalsState>(
                    builder: (context, state) {
                      if (state is GoalsLoaded) {
                        List<SavingsGoal> goals = state.goals;
                        return TabBarView(
                            controller: controller.tabController,
                            children: [
                              ListView.builder(
                                  itemCount: goals.length,
                                  itemBuilder: (ctx, index) {
                                    return SavingsWidget(
                                      goal: goals[index],
                                    );
                                  }),
                              const Text('Active'),
                              const Text('Completed')
                            ]);
                      }
                      return Container();
                    },
                  ),
                  Positioned(
                      left: 120.w,
                      top: 320.h,
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return const CreateScreen();
                            }));
                          },
                          child: SmallButton(text: 'Start Saving')))
                ],
              ),
            )
          ],
        ),
      )),
    ));
  }
}
