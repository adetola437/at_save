import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors.dart';

class OutlineButton extends StatelessWidget {
  final String text;
  const OutlineButton({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      height: 56.h,
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.secondaryColor),
          borderRadius: BorderRadius.circular(16.r)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
