import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText {
  static TextStyle h1({Color? color}) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 56.sp,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle h2({Color? color}) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 48.sp,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle h3({Color? color}) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 40.sp,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle h4({Color? color}) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 32.sp,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle h5({Color? color}) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle h6({Color? color}) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle bodySm({Color? color}) {
    return GoogleFonts.karla(
        color: color,
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        height: 1.7);
  }

  static TextStyle bodySmBold({Color? color}) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle body({Color? color}) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle bodyBold({Color? color}) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle bodyLg({Color? color}) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 22.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle bodyLgBold({Color? color}) {
    return GoogleFonts.inter(
        color: color,
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        height: 1.5);
  }

  static TextStyle mobileSm({Color? color}) {
    return GoogleFonts.inter(
      color: color,
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle mobileMd({Color? color}) {
    return GoogleFonts.karla(
      color: color,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle mobile({Color? color}) {
    return GoogleFonts.karla(
      color: color,
      fontSize: 15.sp,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle splashText({Color? color}) {
    return GoogleFonts.ibmPlexSans(
      color: color,
      fontSize: 40.sp,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle italics({Color? color}) {
    return GoogleFonts.inter(
      fontStyle: FontStyle.italic,
      color: color,
      fontSize: 15.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle heading({Color? color}) {
    return GoogleFonts.karla(
      color: color,
      fontSize: 30.sp,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle header({Color? color}) {
    return GoogleFonts.karla(
      color: color,
      fontSize: 25.sp,
      height: 1.4,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle balanceLg({Color? color}) {
    return GoogleFonts.karla(
      color: color,
      fontSize: 37.sp,
      fontWeight: FontWeight.w400,
    );
  }
}
