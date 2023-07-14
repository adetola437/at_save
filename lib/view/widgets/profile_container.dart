import 'package:at_save/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'height.dart';

class MyProfileContainer extends StatelessWidget {
  String image;
  String text;
  Widget widget;
  MyProfileContainer({
    required this.image,
    required this.text,
    required this.widget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 22.h,
                  width: 22.w,
                  child: SvgPicture.asset(image),
                ),
                Width(16.w),
                Text(
                  text,
                  style: MyText.mobile(),
                )
              ],
            ),
            widget
          ],
        ),
        const Divider()
      ],
    );
  }
}
