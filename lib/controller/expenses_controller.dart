import 'package:at_save/theme/colors.dart';
import 'package:at_save/theme/text.dart';
import 'package:at_save/view/screens/expenses_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  ExpensesController createState() => ExpensesController();
}

class ExpensesController extends State<ExpensesScreen> {
  List<PieChartSectionData> getSections() {
    const List<Color> colors = [
      AppColor.tint2,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.orange,
    ];
    const List<String> categories = [
      'Food',
      'Entertainment',
      'Grocery',
      'Shopping',
      'Miscellenous'
    ];
    const List<double> percentages = [20, 15, 35, 10, 20];

    return List.generate(5, (index) {
      final isTouched = index == touchedIndex;
      final double fontSize = isTouched ? 18 : 12;
      final double radius = isTouched ? 60 : 50;

      return PieChartSectionData(
        color: colors[index],
        value: percentages[index],
        title: '${percentages[index].toString()}%',
        radius: radius,
        titleStyle: MyText.mobileMd(color: AppColor.dart),
        titlePositionPercentageOffset: 0.55,
        borderSide: isTouched
            ? const BorderSide(color: Colors.white, width: 4)
            : BorderSide.none,
      );
    });
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

  void touch(FlTouchEvent event, PieTouchResponse pieTouchResponse) {
    setState(() {
      if (pieTouchResponse.touchedSection == null) {
        touchedIndex = -1;
      } else {
        touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
      }
    });
  }

  List<Widget> buildColorIndicators() {
    // Replace this with your actual data structure for categories and percentages
    List<Map<String, dynamic>> categoryData = [
      {"color": AppColor.tint2, "percentage": 20.0, 'category': 'Food'},
      {"color": Colors.green, "percentage": 15.0, 'category': 'Entertainment'},
      {"color": Colors.blue, "percentage": 35.0, 'category': 'Grocery'},
      {"color": Colors.yellow, "percentage": 10.0, 'category': 'Shopping'},
      {"color": Colors.orange, "percentage": 20.0, 'category': 'Miscellenous'},
    ];

    List<Widget> indicators = [];

    for (int i = 0; i < categoryData.length; i++) {
      Color color = categoryData[i]["color"];
      String percentage = categoryData[i]["category"];

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

    return indicators;
  }
}
