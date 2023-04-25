import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/widgets/app_buttons/app_elevated_button.dart';

class OurGoals extends StatefulWidget {
  const OurGoals({Key? key}) : super(key: key);
  static const pageRoute = '/our_goals';

  @override
  State<OurGoals> createState() => _OurGoalsState();
}

class _OurGoalsState extends State<OurGoals> {
  List<String> ourGoalsTextList = [
    'تعرف على منهجك الدراسي بطريقة سهلة وأكثر تفاعلية',
    'التدريب على التفكير والابتكار والتصميم والتخطيط والإبداع',
    'تنمية المهرات التحليلة واكتشاف العلاقات وتصنيفها',
    'بناء القدرة على التفكير لايجاد حلول لمشكلات حياتيه',
  ];

  List<String> ourGoalsImagesUrl = [
    'assets/our_goals/image_1.svg',
    'assets/our_goals/image_2.svg',
    'assets/our_goals/image_3.svg',
    'assets/our_goals/image_4.svg',
  ];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return IntroductionScreen(
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
          text: ourGoalsTextList[0],
          isLastPage: false,
          imageUrl: ourGoalsImagesUrl[0],
          context: context,
        ),
        customPageView(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          text: ourGoalsTextList[1],
          imageUrl: ourGoalsImagesUrl[1],
          isLastPage: false,
          context: context,
        ),
        customPageView(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          text: ourGoalsTextList[2],
          imageUrl: ourGoalsImagesUrl[2],
          isLastPage: false,
          context: context,
        ),
        customPageView(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          text: ourGoalsTextList[3],
          imageUrl: ourGoalsImagesUrl[3],
          isLastPage: true,
          context: context,
        ),
      ],
      showDoneButton: false,
      showSkipButton: false,
      showNextButton: false,
      showBackButton: false,
    );
  }

  Container customPageView({
    required double screenHeight,
    required double screenWidth,
    required String text,
    required String imageUrl,
    required bool isLastPage,
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
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
          Visibility(
            visible: isLastPage,
            child: AppElevatedButton(
              label: 'تم',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
