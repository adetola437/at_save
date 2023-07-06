import 'package:at_save/view/widgets/button.dart';
import 'package:at_save/view/widgets/summary_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../boiler_plate/stateless_view.dart';
import '../../controller/summary_controller.dart';
import '../../price_format.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../widgets/description_text.dart';
import '../widgets/heading.dart';
import '../widgets/height.dart';
import '../widgets/nav_container.dart';

class SummaryView extends StatelessView<SummaryScreen, SummaryController> {
  const SummaryView(SummaryController controller, {Key? key})
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
              NavContainer(icon: Icons.arrow_back_ios),
              Height(10.h),
              const Heading(text: 'Summary'),
              Height(10.h),
              const DescriptionText(
                  text: 'Here is what your goal will look like.'),
              Height(40.h),
              const Details(
                  icon: Icons.money, leadng: 'Amount', trailing: '800.00'),
              const Divider(),
              Height(20.h),
              const Details(
                  icon: Icons.calendar_month,
                  leadng: 'Expiry Date',
                  trailing: '6 months'),
              const Divider(),
              Height(20.h),
              const Details(
                  icon: Icons.note,
                  leadng: 'Description',
                  trailing: 'My laptop'),
              const Divider(),
              Height(20.h),
              const Details(
                  icon: Icons.currency_exchange,
                  leadng: 'Amount Saved',
                  trailing: '800.00'),
              const Divider(),
              Height(20.h),
              const Details(
                  icon: Icons.interests,
                  leadng: 'Interest Rate',
                  trailing: '5% per month'),
              const Divider(),
              Height(40.h),
              Container(
                height: 100.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColor.backBackground),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Height(20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Buy a Laptop',
                            style:
                                MyText.mobile(color: AppColor.secondaryColor),
                          ),
                          Text(
                            '#${PriceFormatter.formatPrice(12000)} / #${PriceFormatter.formatPrice(22000)} ',
                            style:
                                MyText.mobile(color: AppColor.secondaryColor),
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
                                child: const LinearProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColor.analogousColor2),
                                  minHeight: 9,
                                  backgroundColor: Colors.white,
                                  value: 0.5,
                                ),
                              ),
                            ),
                            Text(
                              '20%',
                              style: MyText.mobile(),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 120.h),
                child: InkWell(
                    onTap: () {
                      controller.showConfirmationDialog(context);
                    },
                    child: Button(text: 'Create Target')),
              )
            ],
          ),
        ),
      )),
    );
  }
}
