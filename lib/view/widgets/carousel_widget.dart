import 'package:at_save/price_format.dart';
import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarouselWidget extends StatelessWidget {
  final String title;
  final double amount;
  final Color color;
  const CarouselWidget(
      {required this.amount,
      required this.title,
      required this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(15.r)),
      height: 170.h,
      width: double.maxFinite,
      child: Column(
        children: [
          Height(20.h),
          Text(
            title,
            style:
                MyText.bodyLg(color: const Color.fromARGB(255, 231, 231, 236)),
          ),
          Height(20.h),
          Text(
            'N${PriceFormatter.formatPrice(amount)}',
            style: MyText.balanceLg(color: AppColor.backBackground),
          ),
        ],
      ),
    );
  }
}
