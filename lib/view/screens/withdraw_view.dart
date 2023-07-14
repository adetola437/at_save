import 'package:at_save/view/screens/sign_up_view.dart';
import 'package:at_save/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../bloc/budget/budget_bloc.dart';
import '../../bloc/expense_transaction/expense_transaction_bloc.dart';
import '../../bloc/user/user_bloc.dart';
import '../../boiler_plate/stateless_view.dart';
import '../../controller/withdraw_controller.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../widgets/height.dart';
import '../widgets/textfield_widget.dart';

class WithdrawView extends StatelessView<WithdrawScreen, WithdrawController> {
  const WithdrawView(WithdrawController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return OverlayLoaderWithAppIcon(
      isLoading: controller.isLoading,
      appIcon: SvgPicture.asset(
        'assets/green.svg',
        color: AppColor.primaryColor,
      ),
      child: BlocListener<ExpenseTransactionBloc, ExpenseTransactionState>(
        listener: (context, state) {
          if (state is ExpenseTransactionLoading) {
            controller.loading();
          }
          if (state is ExpenseTransactionCreated) {
            controller.pushSuccess();
          }
          if (state is ExpenseTransactionError) {
            controller.pushError();
          }

          // TODO: implement listener
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
                  InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.h),
                      child: SizedBox(
                        height: 30.h,
                        width: 30.w,
                        child: SvgPicture.asset('assets/cancel.svg'),
                      ),
                    ),
                  ),
                  Height(40.h),
                  Text(
                    'Withdraw',
                    style: MyText.heading(color: AppColor.primaryColor),
                  ),
                  Height(10.h),
                  Text(
                    'Fill the details below to withdraw your funds',
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
                  Height(10.h),
                  const Head(text: 'Category'),
                  Height(10.h),
                  BlocBuilder<BudgetBloc, BudgetState>(
                    builder: (context, state) {
                      if (state is BudgetLoaded) {
                        List<String> budgetCategories = [];
                        for (final category in state.budget) {
                          budgetCategories.add(category.name);
                        }
                        return DropdownButtonFormField<String>(
                          value: controller.selectedOption,
                          onChanged: (newValue) {
                            controller.onChanged(newValue);
                          },
                          items: budgetCategories.map((category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
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
                        );
                      }
                      return Container();
                    },
                  ),
                  Height(190.h),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserSuccess) {
                        return InkWell(
                            onTap: () {
                              controller.withdraw(state.user.walletBalance!);
                            },
                            child: Button(text: 'Withdraw'));
                      }
                      return Container();
                    },
                  )
                ],
              ),
            ))),
          ),
        ),
      ),
    );
  }
}
