import 'package:at_save/utils/price_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../model/expense.dart';
import '../../theme/text.dart';
import 'height.dart';

class ExpenseWidget extends StatelessWidget {
  Expense expense;
  ExpenseWidget({
    required this.expense,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        height: 70.h,
        width: double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                    height: 50.h,
                    width: 50.h,
                    child: expense.transactionType == 'withdraw'
                        ? Image.asset(
                            'assets/withdraw.png',
                          )
                        : Image.asset('assets/add.png')),
                Width(10.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense.category,
                      style: MyText.bodySmBold(),
                    ),
                    Height(10.h),
                    Text(
                      expense.description,
                      style: MyText.mobileSm(),
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  expense.transactionType == 'withdraw' ||
                          expense.transactionType == 'savings_creation' 
                      ? Text(
                          '-N${PriceFormatter.formatPrice(expense.amount)}',
                          style: MyText.mobileBold(color: Colors.red),
                        )
                      : Text(
                          '+N${PriceFormatter.formatPrice(expense.amount)}',
                          style: MyText.mobileBold(color: Colors.green),
                        ),
                  Height(10.h),
                  Text(DateFormat('h:mm a').format(expense.date))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
