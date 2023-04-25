import 'package:flutter/material.dart';
import 'package:studying_app/view/screens/home/taps/about_app_screen.dart';
import 'package:studying_app/view/screens/home/navigation.dart';
import 'package:studying_app/view/screens/home/taps/news.dart';

import '../screens/home/taps/educational_materials_screen.dart';
import '../theme/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Drawer(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldGradientColors.first,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'assets/home_page_images/home_page_image.png',
                  width: 280,
                ),
                const SizedBox(
                  height: 20,
                ),
                drawerItem(
                  context,
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      Navigation.pageRoute,
                      ModalRoute.withName(Navigation.pageRoute),
                    );
                  },
                  title: 'الصفحة الرئسية',
                ),
                drawerItem(
                  context,
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      EducationalMaterialsScreen.pageRoute,
                      ModalRoute.withName(Navigation.pageRoute),
                    );
                  },
                  title: 'المواد الدراسية',
                ),
                drawerItem(
                  context,
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      NewsScreen.pageRoute,
                      ModalRoute.withName(Navigation.pageRoute),
                    );
                  },
                  title: "الاخبار",
                ),
                drawerItem(
                  context,
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AboutApp.pageRoute,
                      ModalRoute.withName(Navigation.pageRoute),
                      arguments: {
                        'isFromHome': true,
                      },
                    );
                  },
                  title: "عن التطبيق",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card drawerItem(
    BuildContext context, {
    required void Function()? onTap,
    required String title,
  }) {
    return Card(
      child: ListTile(
        onTap: onTap,
        title: Text(title),
      ),
    );
  }
}
