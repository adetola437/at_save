
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors.dart';

class LightText extends StatelessWidget {
  String text;
  LightText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 14.sp, color: AppColor.primaryText, fontFamily: "Poppins"),
    );
  }
}
