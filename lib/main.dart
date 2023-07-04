import 'package:at_save/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controller/splash_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Initialize the Flutter binding
  GoogleFonts.ibmPlexSans(); // Initialize the desired font
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => const MaterialApp(
        home: Splash(),
      ),
    );
  }
}
