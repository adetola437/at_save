import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: Container(
          height: 0.5.h,
          width: double.maxFinite,
          decoration: const BoxDecoration(color: Colors.grey),
        ));
  }
}
