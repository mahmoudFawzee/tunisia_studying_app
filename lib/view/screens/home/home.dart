import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:studying_app/data/firebase_apis/firebase_user_data_api.dart';
import 'package:studying_app/data/models/user.dart';
import 'package:studying_app/logic/blocs/materials_bloc/materials_bloc.dart';
import 'package:studying_app/view/screens/home/taps/about_app_screen.dart';
import 'package:studying_app/view/screens/home/taps/educational_materials_screen.dart';
import 'package:studying_app/view/screens/home/taps/news.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/widgets/image_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseUserDataApi firebaseApi = FirebaseUserDataApi();

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    double screenHeight = orientation == Orientation.portrait
        ? MediaQuery.of(context).size.height
        : MediaQuery.of(context).size.width;
    double screenWidth = orientation == Orientation.portrait
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;

    TextStyle textStyle = const TextStyle(
      color: Colors.white,
      fontFamily: 'ElMessiri',
      fontWeight: FontWeight.w400,
      fontSize: 18,
    );
    TextStyle buttonsStyle = const TextStyle(
      color: Color(0xffBA68C8),
      fontFamily: 'ElMessiri',
      fontWeight: FontWeight.w400,
      fontSize: 15,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: FutureBuilder<MyUser>(
        future: firebaseApi.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String userName = snapshot.data!.name;
            String userStudyingYear = snapshot.data!.studyingYear;
            String userGender = snapshot.data!.gender;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: ImageSlider(),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: screenHeight * .1,
                  width: screenWidth * .64,
                  child: Stack(
                    fit: StackFit.loose,
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        bottom: 1,
                        child: Container(
                          alignment: Alignment.center,
                          width: screenWidth * .58,
                          height: screenHeight * .1,
                          decoration: BoxDecoration(
                            color: const Color(0xffD6C2DA),
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: textStyle,
                              ),
                              Text(
                                userStudyingYear,
                                style: textStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // h = 684
                      // w = 412
                      Positioned(
                        height: screenHeight * .133,
                        width: screenWidth * .218,
                        bottom: screenHeight * -.0073,
                        right: screenWidth * -.0364,
                        child: Image.asset(
                          userGender == 'ذكر'
                              ? 'assets/home_page_images/boy_image.png'
                              : 'assets/home_page_images/girl_image.png',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    homeButtons(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      textStyle: buttonsStyle,
                      imageUrl: 'assets/home_page_images/books.png',
                      onTap: () {
                        context.read<MaterialsBloc>().add(
                              const GetAllMaterialsEvent(),
                            );
                        Navigator.of(context).pushNamed(
                          EducationalMaterialsScreen.pageRoute,
                        );
                      },
                      text: 'المواد الدراسية',
                    ),
                    homeButtons(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      textStyle: buttonsStyle,
                      imageUrl: 'assets/home_page_images/rate.png',
                      onTap: () {},
                      text: 'حساب المعدل',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    homeButtons(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      textStyle: buttonsStyle,
                      imageUrl: 'assets/home_page_images/news.png',
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          NewsScreen.pageRoute,
                        );
                      },
                      text: ' اخبار تهمك',
                    ),
                    homeButtons(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      textStyle: buttonsStyle,
                      imageUrl: 'assets/home_page_images/about_app.png',
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AboutApp.pageRoute,
                          arguments: {
                            'isFromHome': true,
                          },
                        );
                      },
                      text: 'عن التطبيق',
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.buttonsLightColor,
              ),
            );
          }
        },
      ),
    );
  }

  InkWell homeButtons({
    required double screenHeight,
    required double screenWidth,
    required String imageUrl,
    required String text,
    required TextStyle textStyle,
    required void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: screenHeight * .137,
        width: screenWidth * .38,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              15,
            )),
        child: Column(
          children: [
            Image.asset(
              imageUrl,
              color: const Color(0xff959595),
              height: screenHeight * .065,
              width: screenWidth * .12,
            ),
            SizedBox(
              height: screenHeight * .005,
            ),
            Text(
              text,
              style: textStyle,
            )
          ],
        ),
      ),
    );
  }
}
