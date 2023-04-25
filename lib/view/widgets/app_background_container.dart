import 'package:flutter/material.dart';
import 'package:studying_app/view/theme/app_colors.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
  });
  final Widget child;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: AppColors.containerGradient,
      ),
      child: child,
    );
  }
}
