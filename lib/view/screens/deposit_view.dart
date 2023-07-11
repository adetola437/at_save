import 'package:at_save/view/screens/sign_up_view.dart';
import 'package:at_save/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../bloc/expense_transaction/expense_transaction_bloc.dart';
import '../../boiler_plate/stateless_view.dart';
import '../../controller/deposit_controller.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../widgets/height.dart';
import '../widgets/textfield_widget.dart';

class DepositView extends StatelessView<DepositScreen, DepositController> {
  const DepositView(DepositController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return OverlayLoaderWithAppIcon(
      isLoading: controller.isLoading,
      appIcon: SvgPicture.asset(
        'assets/green.svg',
        color: AppColor.primaryColor,
      ),
      child: Scaffold(
        body: Form(
          key: controller.formKey,
          child: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child:
                  BlocListener<ExpenseTransactionBloc, ExpenseTransactionState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is ExpenseTransactionLoading) {
                    controller.loading();
                  }
                  if (state is ExpenseTransactionCreated) {
                    controller.pushSuccess();
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30.h),
                      child: SizedBox(
                        height: 30.h,
                        width: 30.w,
                        child: SvgPicture.asset('assets/cancel.svg'),
                      ),
                    ),
                    Height(40.h),
                    Text(
                      'Deposit',
                      style: MyText.heading(color: AppColor.primaryColor),
                    ),
                    Height(10.h),
                    Text(
                      'Enter the amount you will like to deposit below',
                      style: MyText.bodySm(),
                    ),
                    Height(20.h),
                    const Head(text: 'Amount'),
                    Height(10.h),
                    TextfieldWidget(
                        textFieldType: 'amount',
                        controller: controller.amountController,
                        hintText: 'e.g: 5,000'),
                    Height(20.h),
                    const Head(text: 'Description'),
                    Height(10.h),
                    TextfieldWidget(
                        textFieldType: 'string',
                        controller: controller.descriptionController,
                        hintText: 'e.g: Lenovo Thinkpad'),
                    Height(20.h),
                    const Head(text: 'Payment Option'),
                    Height(10.h),
                    DropdownButtonFormField(
                      items: const [
                        DropdownMenuItem<String>(
                          value: 'Bank Transfer',
                          child: Text('Bank Transfer'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'Debit Card',
                          child: Text('Debit Card'),
                        ),
                        DropdownMenuItem<String>(
                          value: 'PayStack',
                          child: Text('Paystack'),
                        )
                      ],
                      onChanged: (value) {
                        controller.onChanged(value);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Select an option',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                    Height(170.h),
                    InkWell(
                        onTap: () {
                          controller.deposit();
                        },
                        child: Button(text: 'Deposit'))
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
