import 'package:at_save/view/screens/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../bloc/goals/goals_bloc.dart';
import '../../boiler_plate/stateless_view.dart';
import '../../controller/edit_details_controller.dart';
import '../../theme/colors.dart';
import '../widgets/button.dart';
import '../widgets/description_text.dart';
import '../widgets/heading.dart';
import '../widgets/height.dart';
import '../widgets/nav_container.dart';
import '../widgets/textfield_widget.dart';

class EditView extends StatelessView<EditScreen, EditController> {
  const EditView(EditController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return OverlayLoaderWithAppIcon(
      isLoading: controller.isLoading,
      appIcon: SvgPicture.asset(
        'assets/green.svg',
        color: AppColor.primaryColor,
      ),
      child: BlocListener<GoalsBloc, GoalsState>(
        listener: (context, state) {
          if (state is GoalsLoading) {
            controller.loading();
          }
          if (state is GoalEdited) {
            controller.success();
          }
        },
        child: Scaffold(
          body: Form(
            key: controller.formKey,
            child: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Height(10.h),
                    NavContainer(icon: Icons.arrow_back_ios),
                    Height(10.h),
                    const Heading(text: 'Update Savings Information'),
                    Height(10.h),
                    const DescriptionText(
                        text:
                            'We just need a little information to get started.'),
                    Height(20.h),
                    const Head(text: 'Name your target'),
                    Height(10.h),
                    TextfieldWidget(
                        textFieldType: 'string',
                        controller: controller.nameController,
                        hintText: 'e.g: Buy a laptop'),
                    Height(20.h),
                    const Head(text: 'Description'),
                    Height(10.h),
                    TextfieldWidget(
                        textFieldType: 'string',
                        controller: controller.descriptionController,
                        hintText: 'e.g: Lenovo Thinkpad'),
                    Height(20.h),
                    const Head(text: 'Target Amount'),
                    Height(10.h),
                    TextfieldWidget(
                        textFieldType: 'amount',
                        controller: controller.targetController,
                        hintText: 'e.g: 5,000'),
                    Height(20.h),
                    const Head(text: 'Duration'),
                    Height(10.h),
                    TextfieldWidget(
                        setDate: () {
                          controller.selectDate(context);
                        },
                        textFieldType: 'date',
                        controller: controller.dateController,
                        hintText: 'date'),
                    Height(30.h),
                    InkWell(
                        onTap: () {
                          //  controller.goToSummary();
                          controller.updateGoal();
                        },
                        child: Button(text: 'Next'))
                  ],
                ),
              ),
            )),
          ),
        ),
      ),
    );
  }
}
