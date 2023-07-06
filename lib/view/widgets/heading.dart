import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../../theme/text.dart';

class Heading extends StatelessWidget {
 final String text;
  const Heading({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: MyText.heading(color: AppColor.primaryColor),
    );
  }
}