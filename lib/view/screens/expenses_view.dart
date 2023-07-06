import 'package:at_save/price_format.dart';
import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/view/widgets/header_row.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../boiler_plate/stateless_view.dart';
import '../../controller/expenses_controller.dart';

class ExpensesView extends StatelessView<ExpensesScreen, ExpensesController> {
  const ExpensesView(ExpensesController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Height(10.h),
              const HeaderRow(
                  leading: Icons.arrow_back_ios,
                  text: 'Expenses',
                  trailing: Icons.pie_chart_outline_rounded),
              Height(10.h),
              Container(
                height: 300.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColor.subtle,
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Column(
                        children: [
                          Height(20.h),
                          SizedBox(
                            height: 220.h,
                            width: 220.w,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  PieChart(
                                    PieChartData(
                                      sections: controller.getSections(),
                                      centerSpaceColor: Colors.white,
                                      pieTouchData: PieTouchData(
                                        touchCallback: (FlTouchEvent event,
                                            PieTouchResponse?
                                                pieTouchResponse) {
                                          controller.touch(
                                              event, pieTouchResponse!);
                                        },
                                      ),
                                      borderData: FlBorderData(show: false),
                                      sectionsSpace: 2,
                                      centerSpaceRadius: 60,
                                    ),
                                  ),
                                  Text(
                                    'N${PriceFormatter.formatPrice(20000000)}',
                                    style: MyText.mobileBold(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Height(20.h),
                          SizedBox(
                            height: 30.h,
                            width: double.maxFinite,
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              children: controller.buildColorIndicators(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Height(10.h),
              Text(
                'Track Your Expenses',
                style: MyText.bodyLgBold(color: AppColor.dart),
              ),
              Height(10.h),
              Container(
                height: 80.h,
                width: 130.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColor.secondary),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      child: Center(
                        child: Text(
                          'Travel',
                          style: MyText.bodyLg(),
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        'N${PriceFormatter.formatPrice(300)}',
                        style: MyText.bodyBold(color: AppColor.dart),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
