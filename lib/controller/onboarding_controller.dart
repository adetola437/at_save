import 'package:at_save/controller/welcome_controller.dart';
import 'package:at_save/view/screens/onboarding_view.dart';
import 'package:flutter/material.dart';

import '../model/onboarding.dart';
import '../view/widgets/onbording_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingController createState() => OnboardingController();
}

class OnboardingController extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool lastPage = false;
  int currentIndex = 0;
  final PageController controller = PageController();

  List<SliderText> sliderNote = [
    SliderText(
      slider: SliderModel(
          imagePath: 'assets/image 1.png',
          title: 'Turn Your Small\n Saving Into\n Something Big',
          description:
              'Integrate multiple payment methods to help you up the process quickly'),
    ),
    SliderText(
      slider: SliderModel(
          imagePath: 'assets/image 2.png',
          title: 'Transfer Money\n Seamlessly',
          description:
              'Built-in Fingerprint, face recognition and more, keeping you completely safe.'),
    ),
    SliderText(
      slider: SliderModel(
          imagePath: 'assets/image 3.png',
          title: 'Manage\n Your Expenses',
          description:
              'Integrate multiple payment methods to help you up the process quickly'),
    ),
  ];
  onNextClick() {
    setState(() {
      if (currentIndex <= 1) {
        currentIndex++;

        print(currentIndex);

        controller.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut);
      }

      // print(lastPage);
    });
  }

  @override
  Widget build(BuildContext context) => OnboardingView(this);

  togglePage(value) {
    setState(() {
      currentIndex = value;

      lastPage = value == 2;
    });
  }

  pushWelcomeScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const WelcomeScreen(),
    ));
  }
}
