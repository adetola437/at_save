import 'package:at_save/theme/colors.dart';
import 'package:flutter/material.dart';

import '../../theme/text.dart';

class DescriptionText extends StatelessWidget {
  final String text;
  const DescriptionText({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: MyText.bodySm(color: AppColor.primaryText),
    );
  }
}
