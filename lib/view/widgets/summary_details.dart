import 'package:at_save/theme/text.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/colors.dart';

class Details extends StatefulWidget {
  final String leadng;
  final String trailing;
  final IconData icon;
  const Details(
      {required this.icon,
      required this.leadng,
      required this.trailing,
      super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              widget.icon,
              color: AppColor.secondaryColor,
            ),
            Width(20.w),
            Text(
              widget.leadng,
              style: MyText.mobile(color: AppColor.primaryText),
            ),
          ],
        ),
        Text(
          widget.trailing,
          style: MyText.mobile(color: AppColor.primaryText),
        )
      ],
    );
  }
}
