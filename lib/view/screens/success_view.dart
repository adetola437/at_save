import 'package:at_save/theme/text.dart';
import 'package:at_save/view/widgets/button.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../boiler_plate/stateless_view.dart';
import '../../controller/success_controller.dart';

class SuccessView extends StatelessView<SuccessScreen, SuccessController> {
  const SuccessView(SuccessController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Height(200.h),
            SvgPicture.asset('assets/check.svg'),
            Height(30.h),
            Text(
              'Successful!',
              style: MyText.balanceLg(),
            ),
            Text(
              controller.widget.text,
              style: MyText.bodySm(),
            ),
            Height(200.h),
            InkWell(
                onTap: () {
                  controller.goHome();
                },
                child: Button(text: 'CLOSE'))
          ],
        ),
      ),
    );
  }
}
