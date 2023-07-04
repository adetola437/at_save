import 'package:at_save/theme/colors.dart';
import 'package:at_save/controller/sign_up_controller.dart';
import 'package:at_save/controller/welcome_controller.dart';
import 'package:at_save/view/widgets/button.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:at_save/view/widgets/outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../boiler_plate/stateless_view.dart';
import '../../controller/sign_in_controller.dart';
import '../../theme/text.dart';

class WelcomeView extends StatelessView {
  const WelcomeView(WelcomeController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: SizedBox(
              height: 300.h,
              width: 300.w,
              child: SvgPicture.asset(
                'assets/green.svg',
                fit: BoxFit.cover,
                color: AppColor.primaryColor,
              ),
            ),
          ),
          Height(70.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome To ', style: MyText.bodyLgBold()),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'AT',
                      style: MyText.bodyLgBold(color: AppColor.primaryColor),
                    ),
                    TextSpan(
                        text: 'SAVE',
                        style:
                            MyText.bodyLgBold(color: AppColor.secondaryColor)),
                  ],
                ),
              ),
            ],
          ),
          Height(20.h),
          Text(
            'Small money, big doings',
            style: MyText.italics(color: Colors.grey),
          ),
          Height(80.h),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const SignUpScreen();
                }));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Button(text: 'CREATE YOUR FREE ACCOUNT'),
              )),
          Height(20.h),
          InkWell(
            onTap: (){
               Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return const SignInScreen();
                }));
            },
            child: const OutlineButton(text: 'LOG INTO YOUR ACCOUNT'))
        ],
      ),
    );
  }
}
