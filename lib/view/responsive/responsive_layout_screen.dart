import 'package:flutter/cupertino.dart';
import 'package:studying_app/view/responsive/app_dimentions.dart';

class ResponsiveLayoutScreen extends StatelessWidget {
  const ResponsiveLayoutScreen({
    super.key,
    required this.horizontalScreen,
    required this.verticalScreen,
  });
  final Widget horizontalScreen;
  final Widget verticalScreen;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      if (constrains.maxWidth > verticalSize) {
        return horizontalScreen;
      } else {
        return verticalScreen;
      }
    });
  }
}
