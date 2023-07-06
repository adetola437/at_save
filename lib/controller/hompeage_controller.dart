import 'package:at_save/view/screens/homepage_view.dart';
import 'package:at_save/view/widgets/carousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

import '../theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeController createState() => HomeController();
}

class HomeController extends State<HomeScreen> {
  CarouselSliderController carouselController = CarouselSliderController();
  int currentIndex = 0;
  List<CarouselWidget> carousel = [
    const CarouselWidget(
      amount: 50000,
      title: 'Total Savings',
      color: AppColor.primaryColor,
    ),
    const CarouselWidget(
      amount: 20000,
      title: 'Expenses',
      color: AppColor.complementaryColor1,
    )
  ];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => HomePageView(this);

  void togglePage(value) {
    setState(() {
      currentIndex = value;
    });
  }
}
