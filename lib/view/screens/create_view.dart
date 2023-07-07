import 'package:at_save/view/screens/sign_up_view.dart';
import 'package:at_save/view/widgets/button.dart';
import 'package:at_save/view/widgets/description_text.dart';
import 'package:at_save/view/widgets/heading.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:at_save/view/widgets/nav_container.dart';
import 'package:at_save/view/widgets/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../boiler_plate/stateless_view.dart';
import '../../controller/create_controller.dart';

class CreateView extends StatelessView<CreateScreen, CreateController> {
  const CreateView(CreateController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const Heading(text: 'Create savings'),
                Height(10.h),
                const DescriptionText(
                    text: 'We just need a little information to get started.'),
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
                Height(20.h),
                const Head(text: 'How much do you want to save now?'),
                Height(10.h),
                TextfieldWidget(
                    textFieldType: 'amount',
                    controller: controller.savedController,
                    hintText: 'e.g: 5,000'),
                Height(30.h),
                InkWell(
                    onTap: () {
                      controller.goToSummary();
                    },
                    child: Button(text: 'Next'))
              ],
            ),
          ),
        )),
      ),
    );
  }
}
