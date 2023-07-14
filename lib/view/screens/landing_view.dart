import 'package:at_save/controller/expenses_controller.dart';
import 'package:at_save/controller/landing_controller.dart';
import 'package:at_save/controller/profile_controller.dart';
import 'package:at_save/controller/savings_controller.dart';
import 'package:at_save/controller/statistics_controller.dart';
import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../boiler_plate/stateless_view.dart';
import '../../controller/hompeage_controller.dart';

class LandingView extends StatelessView<LandingScreen, LandingController> {
  const LandingView(LandingController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: currentIndex,
          builder: (context, value, widget) {
            return Stack(
              children: [
                IndexedStack(
                  index: value,
                  children: const [
                    HomeScreen(),
                    SavingsScreen(),
                    ExpensesScreen(),
                    StatisticsScreen(),
                    ProfileScreen()
                  ],
                ),
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: controller.isConnected ? Colors.green : Colors.red,
                    height: 0.0,
                    child: Center(
                      child: Icon(
                        controller.isConnected
                            ? Icons.check_circle
                            : Icons.error,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        notchMargin: 10,
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ValueListenableBuilder(
              valueListenable: currentIndex,
              builder: (context, value, widget) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _bottomBarItem('assets/home.svg', value == 0, 'Home',
                        onTap: () {
                      controller.onItemTapped(0);
                    }),
                    _bottomBarItem('assets/savings.svg', value == 1, 'Savings',
                        onTap: () {
                      controller.onItemTapped(1);
                    }),
                    _bottomBarItem(
                        'assets/expenses.svg', value == 2, 'Expenses',
                        onTap: () {
                      controller.onItemTapped(2);
                    }),
                    _bottomBarItem(
                        'assets/statistics.svg', value == 3, 'Wallet',
                        onTap: () {
                      controller.onItemTapped(3);
                    }),
                    _bottomBarItem('assets/profile.svg', value == 4, 'Profile',
                        onTap: () {
                      controller.onItemTapped(4);
                    }),
                  ],
                );
              }),
        ),
      ),
    );
  }

  _bottomBarItem(String image, bool selected, String text,
      {required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              color: selected
                  ? AppColor.primaryColor
                  : const Color.fromARGB(255, 139, 138, 143),
            ),
            Height(5.h),
            Text(
              text,
              style: MyText.mobileSm(
                color: selected
                    ? AppColor.primaryColor
                    : const Color.fromARGB(255, 139, 138, 143),
              ),
            )
            //  SizedBox(height: 4)
          ],
        ),
      ),
    );
  }
}
