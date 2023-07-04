import 'package:at_save/controller/splash_controller.dart';
import 'package:at_save/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../boiler_plate/stateless_view.dart';

class SplashScreen extends StatelessView {
  const SplashScreen(SplashController controller, {Key? key})
      : super(controller, key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'AT',
                        style: MyText.splashText(color: Colors.red),
                      ),
                      const TextSpan(
                        text: 'SAVE',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'Small money, big doings',
                  style: MyText.italics(color: Colors.grey),
                ),
              ],
            ),
            Positioned(
              top: 650.h,
              left: 50.w,
              child: SvgPicture.asset(
                'assets/loading.svg',
              ),
            )
          ],
        ),
      ),
    );
  }
}
