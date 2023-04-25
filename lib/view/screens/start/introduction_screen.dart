import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:studying_app/view/screens/auth/log_in.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/widgets/app_buttons/app_elevated_button.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);
  static const pageRoute = '/introduction_screen';

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return IntroductionScreen(
      showNextButton: false,
      showDoneButton: false,      
      dotsDecorator: DotsDecorator(
        activeColor: const Color(0xffBA68C8),
        color: Colors.white,
        activeSize: const Size(20, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      ),
      rawPages: [
        customPageView(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          buttonLabel: 'تخطي',
          text: 'تدريب على كيفية حل الأسئلة',
          imageUrl: 'assets/intro_screen_images/intro_one.svg',
          context: context,
        ),
        customPageView(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          buttonLabel: 'تخطي',
          text: 'تعرف علي تقاريرك التعليمية',
          imageUrl: 'assets/intro_screen_images/intro_two.svg',
          context: context,
        ),
        customPageView(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          buttonLabel: 'ابدأ',
          text: 'كن واحدا من الافضل',
          imageUrl: 'assets/intro_screen_images/intro_three.svg',
          context: context,
        ),
      ],
    );
  }

  Container customPageView({
    required double screenHeight,
    required double screenWidth,
    required String buttonLabel,
    required String text,
    required String imageUrl,
    required BuildContext context,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.scaffoldGradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0, .5],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(imageUrl),
          Text(
            text,
            style: Theme.of(context).textTheme.headline5,
          ),
          AppElevatedButton(
            label: buttonLabel,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(LogIn.pageRoute);
            },
          ),
        ],
      ),
    );
  }
}
