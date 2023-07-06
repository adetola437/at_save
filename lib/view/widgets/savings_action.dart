import 'package:at_save/theme/text.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors.dart';

class SavingsAction extends StatelessWidget {
  final IconData icon;
  final String text;
  const SavingsAction({
    required this.text,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 42.h,
          height: 42.h,
          decoration: BoxDecoration(
            color: AppColor.shade3.withOpacity(0.1),
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Center(
            child: Icon(
              icon,
              color: AppColor.shade3,
              size: 20.sp,
            ),
          ),
        ),
        Height(10.h),
        Text(
          text,
          style: MyText.mobile(),
        )
      ],
    );
  }
}
