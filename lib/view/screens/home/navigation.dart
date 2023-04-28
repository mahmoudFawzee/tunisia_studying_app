import 'package:flutter/material.dart';
import 'package:studying_app/view/screens/home/chat_screen.dart';
import 'package:studying_app/view/screens/home/home.dart';
import 'package:studying_app/view/screens/home/notification_page.dart';
import 'package:studying_app/view/screens/home/user_profile.dart';
import 'package:studying_app/view/widgets/app_background_container.dart';

import '../../theme/app_colors.dart';
import '../save_homework_and_exams/local_homework_or_exam_screen.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);
  static const pageRoute = '/navigation';

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  List<Widget> bottomNavigationBarWidgets =  [
   const UserProfile(),
   const HomePage(),
    const AppNotification(),
    ChatScreen(),
  ];
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldGradientColors.last,
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
          child: BottomAppBar(
            color: AppColors.scaffoldGradientColors.first,
            elevation: 0,
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                bottomNavigationBarItem(
                  icon: Icons.person_outline,
                  selectedIcon: Icons.person,
                  index: 0,
                ),
                bottomNavigationBarItem(
                  selectedIcon: Icons.home,
                  icon: Icons.home_outlined,
                  index: 1,
                ),
                bottomNavigationBarItem(
                  selectedIcon: Icons.notifications,
                  icon: Icons.notifications_outlined,
                  index: 2,
                ),
                bottomNavigationBarItem(
                  selectedIcon: Icons.chat,
                  icon: Icons.chat_outlined,
                  index: 3,
                ),
              ],
            ),
          ),
        ),
        body: AppBackground(
          child: bottomNavigationBarWidgets[_currentIndex],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        //extendBody: true,
        floatingActionButton: _currentIndex!=1?null:FloatingActionButton(
          elevation: 0,
          backgroundColor: AppColors.buttonsLightColor,
          onPressed: () {
            Navigator.of(context).pushNamed(
              HomeworkOrExamsPage.pageRoute,
            );
          },
          child: const Icon(
            Icons.add,
          ),
        ));
  }

  IconButton bottomNavigationBarItem({
    required IconData icon,
    required IconData selectedIcon,
    required int index,
  }) {
    return IconButton(
      icon: Icon(
        _currentIndex == index ? selectedIcon : icon,
        color: Colors.black,
      ),
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
