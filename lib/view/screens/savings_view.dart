import 'package:at_save/controller/create_controller.dart';
import 'package:at_save/controller/details_controller.dart';
import 'package:at_save/controller/savings_controller.dart';
import 'package:at_save/price_format.dart';
import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/view/widgets/carousel_widget.dart';
import 'package:at_save/view/widgets/header_row.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:at_save/view/widgets/small_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../boiler_plate/stateless_view.dart';

class SavingsView extends StatelessView<SavingsScreen, SavingsController> {
  const SavingsView(SavingsController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          SizedBox(
            height: 150.h,
            width: double.maxFinite,
            child: const CarouselWidget(
                amount: 2000,
                title: 'My Savings',
                color: AppColor.primaryColor),
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
                      labelPadding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
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
                TabBarView(controller: controller.tabController, children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return const DetailsScreen();
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 40.h,
                                    decoration: BoxDecoration(
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/image8.png')),
                                        borderRadius:
                                            BorderRadius.circular(50.r)),
                                  ),
                                  Container(
                                    height: 15.h,
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                        color: AppColor.active.withOpacity(0.1),
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Center(
                                      child: Text(
                                        'Active',
                                        style:
                                            MyText.mobileSm(color: Colors.blue),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Buy a Laptop',
                                    style: MyText.mobile(
                                        color: AppColor.secondaryColor),
                                  ),
                                  Text(
                                    '#${PriceFormatter.formatPrice(12000)} / #${PriceFormatter.formatPrice(22000)} ',
                                    style: MyText.mobile(
                                        color: AppColor.secondaryColor),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 260.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            8.0), // Adjust the value as needed
                                        child: const LinearProgressIndicator(
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
                    ),
                  ),
                  const Text('Active'),
                  const Text('Completed')
                ]),
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
    )));
  }
}
