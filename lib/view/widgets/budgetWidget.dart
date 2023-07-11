import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/budget.dart';
import '../../price_format.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';

class BudgetWidget extends StatelessWidget {
  Budget budget;
  BudgetWidget({
    required this.budget,
    super.key,
  });
  int getColorValue(Color color) {
    return color.value;
  }

  Color getColor(int colorValue) {
    return Color(colorValue);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      height: 80.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: getColor(budget.color).withOpacity(0.2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Center(
                  child: Text(
                    budget.name,
                    style: MyText.bodyLg(
                        color: getColor(budget.color).withBlue(200)),
                  ),
                ),
              ),
              Center(
                child: Text(
                  'N${(PriceFormatter.formatPrice(budget.currentAmount!))}/ N${PriceFormatter.formatPrice(budget.amount)}',
                  style: MyText.mobile(color: AppColor.dart),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SizedBox(
              width: 260.w,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: LinearProgressIndicator(
                  minHeight: 9,
                  backgroundColor: Colors.white,
                  value: budget.amount != 0
                      ? budget.currentAmount! / budget.amount
                      : 0.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
