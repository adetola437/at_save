import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'nav_container.dart';

class HeaderRow extends StatelessWidget {
  final IconData leading;
  final IconData trailing;
  final String text;
  const HeaderRow({
    required this.leading,
    required this.text,
    required this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NavContainer(icon: leading),
        Text(
          text,
          style: TextStyle(fontSize: 18.sp, fontFamily: "Poppins"),
        ),
        NavContainer(icon: trailing)
      ],
    );
  }
}
