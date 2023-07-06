import 'package:at_save/price_format.dart';
import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/view/widgets/header_row.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:at_save/view/widgets/savings_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../boiler_plate/stateless_view.dart';
import '../../controller/details_controller.dart';
import '../widgets/small_button.dart';
import '../widgets/summary_details.dart';

class DetailsView extends StatelessView<DetailsScreen, DetailsController> {
  const DetailsView(DetailsController controller, {Key? key})
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
                  text: '',
                  trailing: Icons.notifications_none),
              Height(20.h),
              Container(
                height: 100.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    image: const DecorationImage(
                        image: AssetImage(
                          'assets/box4.png',
                        ),
                        fit: BoxFit.cover)),
                child: Center(
                    child: Text(
                  'Buy a Laptop',
                  style: MyText.bodyBold(color: AppColor.backBackground),
                )),
              ),
              Height(20.h),
              Text(
                'My Balance',
                style: MyText.mobileMd(),
              ),
              Height(10.h),
              Text(
                'N${PriceFormatter.formatPrice(2000.20)}',
                style: MyText.bodyBold(),
              ),
              Height(10.h),
              Row(
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
                        backgroundColor: AppColor.backGround,
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
              Height(30.h),
              const Details(
                  icon: Icons.currency_pound_sharp,
                  leadng: 'My Target',
                  trailing: '800.00'),
              const Divider(),
              Height(20.h),
              const Details(
                  icon: Icons.calendar_month,
                  leadng: 'Start Date',
                  trailing: '6 months'),
              const Divider(),
              Height(20.h),
              const Details(
                  icon: Icons.calendar_month,
                  leadng: 'Withdrawal Date',
                  trailing: '6 months'),
              const Divider(),
              Height(20.h),
              const Details(
                  icon: Icons.note,
                  leadng: 'Description',
                  trailing: 'My laptop'),
              const Divider(),
              Height(70.h),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SavingsAction(text: 'Edit', icon: Icons.edit_note),
                  SavingsAction(text: 'Delete', icon: Icons.delete),
                  SavingsAction(text: 'Break', icon: Icons.lock_open),
                ],
              ),
              Height(60.h),
              Center(
                child: SizedBox(
                    child: InkWell(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(
                          //     builder: (BuildContext context) {
                          //   return const CreateScreen();
                          // }));
                        },
                        child: SmallButton(text: 'Add Money'))),
              )
            ],
          ),
        ),
      )),
    );
  }
}
