import 'dart:math';

import 'package:at_save/bloc/budget/budget_bloc.dart';
import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/view/screens/expenses_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/budget.dart';
import '../model/expense.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  ExpensesController createState() => ExpensesController();
}

class ExpensesController extends State<ExpensesScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  bool isLoading = false;
  // List<PieChartSectionData> getSections() {
  //   const List<Color> colors = [
  //     AppColor.tint2,
  //     Colors.green,
  //     Colors.blue,
  //     Colors.yellow,
  //     Colors.orange,
  //   ];
  //   const List<String> categories = [
  //     'Food',
  //     'Entertainment',
  //     'Grocery',
  //     'Shopping',
  //     'Miscellenous'
  //   ];
  //   const List<double> percentages = [20, 15, 35, 10, 20];

  //   return List.generate(5, (index) {
  //     final isTouched = index == touchedIndex;
  //     final double fontSize = isTouched ? 18 : 12;
  //     final double radius = isTouched ? 60 : 50;

  //     return PieChartSectionData(
  //       color: colors[index],
  //       value: percentages[index],
  //       title: '${percentages[index].toString()}%',
  //       radius: radius,
  //       titleStyle: MyText.mobileMd(color: AppColor.dart),
  //       titlePositionPercentageOffset: 0.55,
  //       borderSide: isTouched
  //           ? const BorderSide(color: Colors.white, width: 4)
  //           : BorderSide.none,
  //     );
  //   });
  // }

  // List<PieChartSectionData> getSections(List<Budget> budgets) {
  //   return budgets.map((budget) {
  //     //const isTouched = false; // Replace this with your own logic
  //     const double fontSize = 12;
  //     const double radius = 50;

  //     return PieChartSectionData(
  //       color: getColor(budget.color),
  //       value: 20,
  //       title:
  //           '${((budget.currentAmount ?? 0) / budget.amount * 100).toStringAsFixed(2)}%',
  //       radius: radius,
  //       titleStyle: MyText.mobileMd(color: AppColor.dart),
  //       titlePositionPercentageOffset: 0.55,
  //       borderSide: BorderSide.none,
  //     );
  //   }).toList();
  // }

  ///Pie chart data
  List<PieChartSectionData> getSections(List<Budget> budgets) {
    List<PieChartSectionData> sections = [];

    // Calculate the total amount of all budgets
    double totalAmount =
        budgets.fold(0.0, (sum, budget) => sum + budget.currentAmount!);

    // Check if there are no budgets or total amount is zero
    if (budgets.isEmpty || totalAmount == 0) {
      // Add a default section with no data
      sections.add(
        PieChartSectionData(
          color: Colors.grey,
          value: 100,
          title: 'No Data',
          radius: 50,
          titleStyle: MyText.mobileMd(color: AppColor.dart),
          titlePositionPercentageOffset: 0.55,
          borderSide: BorderSide.none,
        ),
      );

      return sections;
    }

    // Calculate the percentage for each budget category
    for (int i = 0; i < budgets.length; i++) {
      Budget budget = budgets[i];
      double percentage = (budget.currentAmount! / totalAmount) * 100;

      //final isTouched = i == touchedIndex;
      const double fontSize = 12;
      const double radius = 50;

      sections.add(
        PieChartSectionData(
          color: getColor(budget.color),
          value: percentage,
          title: '${percentage.toStringAsFixed(2)}%',
          radius: radius,
          titleStyle: MyText.mobileMd(color: AppColor.dart),
          titlePositionPercentageOffset: 0.55,
          borderSide: BorderSide.none,
        ),
      );
    }

    return sections;
  }

  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ExpensesView(this);

  // void touch(FlTouchEvent event, PieTouchResponse pieTouchResponse) {
  //   setState(() {
  //     if (pieTouchResponse.touchedSection == null) {
  //       touchedIndex = -1;
  //     } else {
  //       touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
  //     }
  //   });
  // }
  ///method called to create a new budget
  void createBudget() async {
    context.read<BudgetBloc>().add(CreateBudgetEvent(
        budgetAmount: double.parse(amountController.text),
        budgetName: nameController.text,
        color: getColorValue(generateRandomColor())));
    nameController.clear();
    amountController.clear();
  }

  loading() {
    setState(() {
      isLoading = true;
    });
  }

  /// widget to build the indicators for all the colors with their respective category
  List<Widget> buildColorIndicators(List<Budget> budgets) {
    List<Widget> indicators = [];

    // Check if there are no budgets
    if (budgets.isEmpty) {
      // Add a default indicator for no budgets
      Widget noBudgetIndicator = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          'No Budgets',
          style: MyText.mobileMd(color: AppColor.dart),
        ),
      );

      indicators.add(noBudgetIndicator);
      return indicators;
    }

    for (int i = 0; i < budgets.length; i++) {
      Budget budget = budgets[i];
      Color myColor = getColor(budget.color);
      Color color = myColor;
      String percentage = budget.name;

      // Check if budget has no amount
      if (budget.currentAmount == null || budget.currentAmount == 0) {
        // Add a default indicator for budgets with no amount
        Widget noAmountIndicator = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.5),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                percentage,
                style: MyText.mobileMd(color: AppColor.dart),
              ),
            ],
          ),
        );

        indicators.add(noAmountIndicator);
      } else {
        // Add indicator for budgets with amount
        Widget indicator = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                percentage,
                style: MyText.mobileMd(color: AppColor.dart),
              ),
            ],
          ),
        );

        indicators.add(indicator);
      }
    }

    return indicators;
  }

  /// when creating a budget, this method is used to generate a random color
  Color generateRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  ///converts a color variable to its respective integer
  int getColorValue(Color color) {
    return color.value;
  }

  Color getColor(int colorValue) {
    return Color(colorValue);
  }

  ///Get the total expenses for all the expense transactions made
  double getTotalExpenses(List<Expense> expenses) {
    double totalExpenses = 0;
    for (Expense expense in expenses) {
      totalExpenses += expense.amount;
    }
    return totalExpenses;
  }
}
