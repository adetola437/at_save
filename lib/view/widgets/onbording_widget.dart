import 'package:at_save/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/onboarding.dart';
import '../../theme/text.dart';

class SliderText extends StatefulWidget {
  const SliderText({super.key, required this.slider});
  final SliderModel slider;

  @override
  State<SliderText> createState() => _SliderTextState();
}

class _SliderTextState extends State<SliderText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300.h,
          child: Image.asset(widget.slider.imagePath!),
        ),
        SizedBox(
          height: 100.h,
          child: Center(
            child: Text(
              widget.slider.title!,
              textAlign: TextAlign.center,
              style: MyText.bodyLgBold(color: AppColor.secondaryColor),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
          child: SizedBox(
            height: 60.h,
            child: Text(
              widget.slider.description!,
              textAlign: TextAlign.center,
              style: MyText.bodySm(),
            ),
          ),
        )
      ],
    );
  }
}
