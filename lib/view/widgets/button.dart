import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors.dart';

class Button extends StatelessWidget {
  String text;
  Button({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 56.h,
      decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(16.r)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
