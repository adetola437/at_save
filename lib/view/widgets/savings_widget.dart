import 'package:at_save/model/savings_goal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../controller/details_controller.dart';
import '../../price_format.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import 'height.dart';

class SavingsWidget extends StatelessWidget {
  final SavingsGoal goal;
  const SavingsWidget({
    required this.goal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late Color borderColor;
    if (goal.status == 'Active') {
      borderColor = AppColor.primaryColor;
    } else if (goal.status == 'Completed') {
      borderColor = Colors.green;
    } else {
      borderColor = Colors.red;
    }
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Align(
        alignment: Alignment.topCenter,
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return DetailsScreen(
                goalId: goal.id,
              );
            }));
          },
          child: Container(
            height: 140.h,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColor.backBackground),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage('assets/image8.png')),
                            borderRadius: BorderRadius.circular(50.r)),
                      ),
                      Container(
                        height: 15.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            color: borderColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Center(
                          child: Text(
                            'Active',
                            style: MyText.mobileSm(color: borderColor),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Height(10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        goal.title,
                        style: MyText.mobile(color: AppColor.secondaryColor),
                      ),
                      Text(
                        'N${PriceFormatter.formatPrice(goal.currentAmount)} / N${PriceFormatter.formatPrice(goal.targetAmount)} ',
                        style: MyText.mobile(color: AppColor.secondaryColor),
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
                              minHeight: 9,
                              backgroundColor: Colors.white,
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
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
