import 'package:flutter/material.dart';

class AppColors {
  static List<Color> scaffoldGradientColors = [
    const Color(0xffBA68C8).withOpacity(.3),
    const Color(0xffE0E0E0)
  ];
  static LinearGradient containerGradient = LinearGradient(
    colors: AppColors.scaffoldGradientColors,
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: const [0, .5],
  );
  static const Color buttonsLightColor = Color(0xffBA68C8);

  static const Color scaffoldDarkColor = Color(0xff070604);
  static const Color buttonsDarkColor = Color(0xffA36726);
  static const Color gradientDarkColor = Color(0xffA85148);
  static const Color secondaryDarkColor = Color(0xff4B4F45);
}
