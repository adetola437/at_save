import 'package:at_save/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors.dart';

class SmallButton extends StatelessWidget {
  String text;
  SmallButton({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 40.h,
      decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(16.r)),
      child: Center(
        child: Text(
          text,
          style: MyText.mobile(color: Colors.white),
        ),
      ),
    );
  }
}
