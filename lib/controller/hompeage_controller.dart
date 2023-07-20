import 'package:at_save/view/screens/homepage_view.dart';
import 'package:at_save/view/widgets/carousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';

import '../theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeController createState() => HomeController();
}

class HomeController extends State<HomeScreen> {
  CarouselSliderController carouselController = CarouselSliderController();
  int currentIndex = 0;
  bool isLoading = false;
  // List<CarouselWidget> carousel = [
  //    CarouselWidget(
  //     amount: 50000,
  //     title: 'Total Savings',
  //     color: AppColor.primaryColor,
  //   ),
  //    CarouselWidget(
  //     amount: 20000,
  //     title: 'Expenses',
  //     color: AppColor.complementaryColor1,
  //   )
  // ];
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

// call back method to get the current index of carousel slider
  void togglePage(value) {
    setState(() {
      currentIndex = value;
    });
  }
// on click withdraw widget, the withdraw screen should pop up
  goToWithdraw() {
    context.push('/withdraw');
  }
// handle when event is loading
  loading() {
    setState(() {
      isLoading = true;
    });
  }

  ///handle when event is not loading
  notLoading() {
    setState(() {
      isLoading = false;
    });
  }
 String getInitials(String fullName) {
  final nameParts = fullName.split(' ');
  final firstName = nameParts[0].trim();

  if (nameParts.length > 1) {
    final lastName = nameParts[nameParts.length - 1].trim();
    return '${firstName[0]}${lastName[0]}';
  } else {
    return firstName[0];
  }
}

}
