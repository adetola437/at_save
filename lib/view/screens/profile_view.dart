import 'package:at_save/theme/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../bloc/user/user_bloc.dart';
import '../../bloc/visibility/visibility_bloc.dart';
import '../../boiler_plate/stateless_view.dart';
import '../../controller/profile_controller.dart';
import '../../theme/colors.dart';
import '../widgets/header_row.dart';
import '../widgets/height.dart';
import '../widgets/profile_container.dart';

class ProfileView extends StatelessView<ProfileScreen, ProfileController> {
  const ProfileView(ProfileController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w),
        child: Column(
          children: [
            Height(10.h),
            const HeaderRow(
                leading: Icons.arrow_back_ios,
                text: 'My Profile',
                trailing: Icons.person_4),
            Height(32.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserSuccess) {
                      String initials = controller.getInitials(state.user.name);
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 3, color: AppColor.secondaryColor),
                            shape: BoxShape.circle),
                        height: 50.h,
                        width: 50.h,
                        child: Center(
                          child: Text(
                            initials,
                            style: MyText.bodyLg(),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                Width(22.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Height(10.h),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) {
                        if (state is UserSuccess) {
                          return Text(
                            state.user.name,
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500),
                          );
                        }
                        return Container();
                      },
                    ),
                    Height(5.h),
                  ],
                )
              ],
            ),
            Height(32.h),
            MyProfileContainer(
              image: 'assets/p1.svg',
              text: 'Personal Information',
              widget: IconButton(
                  onPressed: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (BuildContext context) {
                    //   return const EditProfile();
                    // }));
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 16.w,
                  )),
            ),
            MyProfileContainer(
              image: 'assets/p2.svg',
              text: 'Payment Preferences',
              widget: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 16.w,
                  )),
            ),
            MyProfileContainer(
              image: 'assets/p3.svg',
              text: 'Banks and Cards',
              widget: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 16.w,
                  )),
            ),
            Height(10.h),
            MyProfileContainer(
                image: 'assets/p4.svg',
                text: 'Notifications',
                widget: Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Container(
                    height: 18.h,
                    width: 18.w,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20.r)),
                    child: const Center(
                      child: Text(
                        '2',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )),
            Height(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    Width(17.w),
                    Text(
                      'Hide balance',
                      style: MyText.mobile(),
                    ),
                  ],
                ),
                BlocBuilder<VisibilityBloc, VisibilityState>(
                  builder: (context, state) {
                    if (state is VisibilityLoaded) {
                      return SizedBox(
                        height: 30.h,
                        width: 60.w,
                        child: FlutterSwitch(
                          value: state.visible,
                          onToggle: (val) {
                            context
                                .read<VisibilityBloc>()
                                .add(ToggleVisibility(visible: val));
                          },
                          activeColor: Colors.green,
                          inactiveColor: Colors.grey,
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
            const Divider(),
            MyProfileContainer(
              image: 'assets/p6.svg',
              text: 'Settings',
              widget: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 16.w,
                  )),
            ),
            MyProfileContainer(
              image: 'assets/logout.svg',
              text: 'Logout',
              widget: IconButton(
                  onPressed: () {
                    controller.logout();
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 16.w,
                  )),
            ),
          ],
        ),
      )),
    );
  }
}
