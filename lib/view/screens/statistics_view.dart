import 'package:at_save/model/expense.dart';
import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/utils/price_format.dart';
import 'package:at_save/view/widgets/expense_widget.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../bloc/budget/budget_bloc.dart';
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
                  BlocBuilder<BudgetBloc, BudgetState>(
                    builder: (context, state) {
                      if (state is BudgetLoaded) {
                        return InkWell(
                          onTap: () {
                            if (state.budget.isNotEmpty) {
                              controller.pushWithdraw();
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
            ),
            Height(20.h),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Text(
                    'Transaction History',
                    style: MyText.bodyBold(),
                  ),
                ),
                // SizedBox(
                //   height: 300.h,
                //   width: 370.w,
                //   child: BlocBuilder<ExpenseTransactionBloc,
                //       ExpenseTransactionState>(
                //     builder: (context, state) {
                //       if (state is ExpenseTransactionLoaded) {
                //         return ListView.builder(
                //             itemCount: state.expenses.length,
                //             itemBuilder: (ctx, index) {
                //               return ExpenseWidget(
                //                   expense: state.expenses[index]);
                //             });
                //       }
                //       return Container();
                //     },
                //   ),
                // )
                SizedBox(
                  height: 350.h,
                  width: 370.w,
                  child: BlocBuilder<ExpenseTransactionBloc,
                      ExpenseTransactionState>(
                    builder: (context, state) {
                      if (state is ExpenseTransactionLoaded) {
                        return state.expenses.isEmpty
                            ? Column(
                                children: [
                                  SizedBox(
                                    height: 300.h,
                                    width: 300.w,
                                    child: Image.asset(
                                        'assets/notransactions.jpg'),
                                  ),
                                  Text(
                                    'You have no transactions at the moment',
                                    style: MyText.mobile(),
                                  )
                                ],
                              )
                            : StickyGroupedListView<Expense, DateTime>(
                                elements: state.expenses,
                                groupBy: (expense) => expense.date,
                                groupComparator: (value1, value2) =>
                                    value2.compareTo(value1),
                                itemComparator: (element1, element2) =>
                                    element1.date.compareTo(element2.date),
                                order: StickyGroupedListOrder.ASC,
                                groupSeparatorBuilder: (Expense transaction) {
                                  final DateTime date = transaction.date;
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: Container(
                                      // Build your group separator widget here using the date
                                      child: Text(
                                        DateFormat('dd MMMM, y').format(date),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  );
                                },
                                itemBuilder: (_, transaction) {
                                  return ExpenseWidget(expense: transaction);
                                },
                              );
                      }
                      return Container();
                    },
                  ),
                )
              ],
            ),

            // Height(30.h),
          ],
        ),
      ],
    );
  }
}
