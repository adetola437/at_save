import 'package:at_save/price_format.dart';
import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                    Text(
                      'N${PriceFormatter.formatPrice(200000)}',
                      style: MyText.balanceLg(color: AppColor.white),
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
                  const Transaction(
                    color: AppColor.shade4,
                    image: 'assets/add.png',
                    text: 'Add money',
                  ),
                  Width(20.w),
                  const Transaction(
                    color: AppColor.shade5,
                    image: 'assets/withdraw.png',
                    text: 'Withdraw',
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
