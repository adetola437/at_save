import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors.dart';


class NavContainer extends StatelessWidget {
  IconData icon;
  NavContainer({
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42.h,
      height: 42.h,
      decoration: BoxDecoration(
        color: AppColor.backBackground,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: Center(
        child: Icon(
          icon,
          size: 16.w,
        ),
      ),
    );
  }
}
