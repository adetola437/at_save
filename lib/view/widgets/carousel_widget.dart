import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/utils/price_format.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/visibility/visibility_bloc.dart';

class CarouselWidget extends StatelessWidget {
  String title;
  double amount;
  Color color;
  CarouselWidget(
      {required this.amount,
      required this.title,
      required this.color,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15.r)),
        height: 140.h,
        width: double.maxFinite,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: SizedBox(
                  height: 30.h,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.wifi,
                        color: Colors.white,
                      ),
                      // Container(
                      //     height: 20.h,
                      //     width: 20.w,
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(50.r),
                      //         color: AppColor.white),
                      //     child: Icon(
                      //       Icons.visibility,
                      //       color: AppColor.secondaryColor,
                      //       size: 15.sp,
                      //     ))
                    ],
                  )),
            ),
            Text(
              title,
              style: MyText.bodyLg(
                  color: const Color.fromARGB(255, 231, 231, 236)),
            ),
            Height(10.h),
            BlocBuilder<VisibilityBloc, VisibilityState>(
              builder: (context, state) {
                if (state is VisibilityLoaded) {
                  return state.visible
                      ? const Text('******')
                      : Text(
                          'N${PriceFormatter.formatPrice(amount)}',
                          style:
                              MyText.balanceLg(color: AppColor.backBackground),
                        );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
