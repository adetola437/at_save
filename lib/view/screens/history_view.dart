import 'package:at_save/utils/price_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import '../../bloc/savings_transaction/savings_transactions_bloc.dart';
import '../../boiler_plate/stateless_view.dart';
import '../../controller/view_history_controller.dart';
import '../../model/savings_transaction.dart';
import '../../theme/text.dart';
import '../widgets/height.dart';

class HistoryView extends StatelessView<HistoryScreen, HistoryController> {
  const HistoryView(HistoryController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Height(20.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  // Width(100.w),
                  Text(
                    'My Savings Transactions',
                    style: MyText.bodyLg(),
                  )
                ],
              ),
              Height(20.h),
              SizedBox(
                height: 400.h,
                width: double.maxFinite,
                child: BlocBuilder<SavingsTransactionsBloc,
                    SavingsTransactionsState>(
                  builder: (context, state) {
                    if (state is SavingsTransactionsLoaded) {
                      return StickyGroupedListView<SavingsTransaction,
                          DateTime>(
                        elements: state.transactions
                            .where((element) =>
                                element.savingsGoalId == controller.widget.id)
                            .toList(),
                        groupBy: (transaction) => DateTime(
                            transaction.date.year,
                            transaction.date.month,
                            transaction.date.day),
                        groupComparator: (group1, group2) => group2.compareTo(
                            group1), // Sort groups in descending order
                        itemComparator: (item1, item2) => item1.date.compareTo(item2
                            .date), // Sort items within a group by ascending order
                        order: StickyGroupedListOrder.ASC,
                        floatingHeader: true,
                        groupSeparatorBuilder:
                            (SavingsTransaction transaction) {
                          final DateTime date = transaction.date;
                          return Container(
                            // Build your group separator widget here using the date
                            child: Text(
                              DateFormat('dd MMMM, y').format(date),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                        itemBuilder: (_, transaction) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 10.h),
                            height: 100.h,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 232, 236, 242),
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 50.h,
                                        width: 50.h,
                                        child: Icon(
                                          Icons.check_circle_rounded,
                                          color: Colors.green,
                                          size: 50.sp,
                                        ),
                                      ),
                                      Width(10.w),
                                      Text(
                                        transaction.note,
                                        style: MyText.mobileBold(),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'N${PriceFormatter.formatPrice(transaction.amount)}',
                                        style: MyText.bodyBold(),
                                      ),
                                      Height(20.h),
                                      Text(PriceFormatter.formatDateToString(
                                          transaction.date))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                          //  ListTile(
                          //   title: Text(transaction.note),
                          //   subtitle: Text(transaction.amount.toString()),
                          //   trailing: Text(transaction.date.toString()),
                          // );
                        },
                      );
                    }
                    return Container();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
