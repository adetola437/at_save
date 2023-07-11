import 'package:at_save/price_format.dart';
import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/view/widgets/expense_widget.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/expense_transaction/expense_transaction_bloc.dart';
import '../../bloc/user/user_bloc.dart';
import '../../boiler_plate/stateless_view.dart';
import '../../controller/statistics_controller.dart';
import 'homepage_view.dart';

class StatisticsView
    extends StatelessView<StatisticsScreen, StatisticsController> {
  const StatisticsView(StatisticsController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250.h,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60.r),
                      bottomRight: Radius.circular(60.r))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  children: [
                    Height(50.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                          color: AppColor.white,
                        ),
                        Width(100.w),
                        Text(
                          'My Wallet',
                          style: MyText.bodyLg(color: AppColor.white),
                        )
                      ],
                    ),
                    Height(70.h),
                    Text(
                      'Wallet Balance',
                      style: MyText.body(
                          color: const Color.fromARGB(255, 4, 33, 56)),
                    ),
                    Height(10.h),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserSuccess) {
                          return Text(
                            'N${PriceFormatter.formatPrice(state.user.walletBalance!)}',
                            style: MyText.balanceLg(color: AppColor.white),
                          );
                        }
                        return Container();
                      },
                    )
                  ],
                ),
              ),
            ),
            Height(20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      controller.pushDeposit();
                    },
                    child: const Transaction(
                      color: AppColor.shade4,
                      image: 'assets/add.png',
                      text: 'Add money',
                    ),
                  ),
                  Width(30.w),
                  InkWell(
                    onTap: () {
                      controller.pushWithdraw();
                    },
                    child: const Transaction(
                      color: AppColor.shade5,
                      image: 'assets/withdraw.png',
                      text: 'Withdraw',
                    ),
                  ),
                ],
              ),
            ),
            Height(20.h),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Text(
                'Transaction History',
                style: MyText.bodyBold(),
              ),
            ),

            // Height(30.h),
          ],
        ),
        Positioned(
          top: 330.h,
          child: SizedBox(
            height: 300.h,
            width: 370.w,
            child: BlocBuilder<ExpenseTransactionBloc, ExpenseTransactionState>(
              builder: (context, state) {
                if (state is ExpenseTransactionLoaded) {
                  return ListView.builder(
                      itemCount: state.expenses.length,
                      itemBuilder: (ctx, index) {
                        return ExpenseWidget(expense: state.expenses[index]);
                      });
                }
                return Container();
              },
            ),
          ),
        )
      ],
    );
  }
}
