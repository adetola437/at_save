import 'package:at_save/price_format.dart';
import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/view/widgets/budgetWidget.dart';
import 'package:at_save/view/widgets/header_row.dart';
import 'package:at_save/view/widgets/height.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';

import '../../bloc/budget/budget_bloc.dart';
import '../../bloc/expense_transaction/expense_transaction_bloc.dart';
import '../../boiler_plate/stateless_view.dart';
import '../../controller/expenses_controller.dart';

class ExpensesView extends StatelessView<ExpensesScreen, ExpensesController> {
  const ExpensesView(ExpensesController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return OverlayLoaderWithAppIcon(
      isLoading: controller.isLoading,
      appIcon: SvgPicture.asset(
        'assets/green.svg',
        color: AppColor.primaryColor,
      ),
      child: BlocListener<BudgetBloc, BudgetState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Create Budget'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: controller.nameController,
                          decoration:
                              const InputDecoration(labelText: 'Budget Name'),
                        ),
                        TextField(
                          controller: controller.amountController,
                          decoration:
                              const InputDecoration(labelText: 'Budget Amount'),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle create button pressed
                          // Retrieve the entered values from the text fields
                          // and perform necessary actions
                          Navigator.of(context).pop(); // Close the dialog
                          controller.createBudget();
                        },
                        child: const Text('Create'),
                      ),
                    ],
                  );
                },
              );
              // Handle FAB onPressed event here
              print('Floating Action Button pressed');
            },
            backgroundColor: AppColor.primaryColor,
            child: const Icon(Icons.add),
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Height(10.h),
                  const HeaderRow(
                      leading: Icons.arrow_back_ios,
                      text: 'Expenses',
                      trailing: Icons.pie_chart_outline_rounded),
                  Height(10.h),
                  Container(
                    height: 300.h,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: AppColor.subtle,
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Column(
                            children: [
                              Height(20.h),
                              SizedBox(
                                height: 220.h,
                                width: 220.w,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      BlocBuilder<BudgetBloc, BudgetState>(
                                        builder: (context, state) {
                                          if (state is BudgetLoaded) {
                                            return PieChart(
                                              PieChartData(
                                                sections: controller
                                                    .getSections(state.budget),
                                                centerSpaceColor: Colors.white,
                                                borderData:
                                                    FlBorderData(show: false),
                                                sectionsSpace: 2,
                                                centerSpaceRadius: 60,
                                              ),
                                            );
                                          }
                                          return Container();
                                        },
                                      ),
                                      BlocBuilder<ExpenseTransactionBloc,
                                          ExpenseTransactionState>(
                                        builder: (context, state) {
                                          if (state
                                              is ExpenseTransactionLoaded) {
                                            double amount =
                                                controller.getTotalExpenses(
                                                    state.expenses);

                                            return Text(
                                              'N${PriceFormatter.formatPrice(amount)}',
                                              style: MyText.mobileBold(),
                                            );
                                          }
                                          return Container();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Height(20.h),
                              BlocBuilder<BudgetBloc, BudgetState>(
                                builder: (context, state) {
                                  if (state is BudgetLoaded) {
                                    return SizedBox(
                                      height: 30.h,
                                      width: double.maxFinite,
                                      child: Wrap(
                                        alignment: WrapAlignment.center,
                                        children: controller
                                            .buildColorIndicators(state.budget),
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Height(10.h),
                  Text(
                    'Track Your Expenses',
                    style: MyText.bodyLgBold(color: AppColor.dart),
                  ),
                  Height(10.h),
                  SizedBox(
                    height: 300.h,
                    width: double.maxFinite,
                    child: BlocBuilder<BudgetBloc, BudgetState>(
                      builder: (context, state) {
                        if (state is BudgetLoaded) {
                          return ListView.builder(
                              itemCount: state.budget.length,
                              itemBuilder: (ctx, index) {
                                return BudgetWidget(
                                    budget: state.budget[index]);
                              });
                        }
                        return Container();
                      },
                    ),
                  )
                ],
              ),
            ),
          )),
        ),
      ),
    );
  }
}
