// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studying_app/data/constants/application_lists.dart';
import 'package:studying_app/data/firebase_apis/fire_base_auth_api.dart';
import 'package:studying_app/data/firebase_apis/firebase_user_data_api.dart';
import 'package:studying_app/data/models/subscription_request.dart';
import 'package:studying_app/view/screens/about_app_screens/app_pros.dart';
import 'package:studying_app/view/screens/about_app_screens/contact_us.dart';
import 'package:studying_app/view/screens/about_app_screens/our_goals_screen.dart';
import 'package:studying_app/view/screens/auth/subscribtion_complete.dart';
import 'package:studying_app/view/screens/home/navigation.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/widgets/drop_down_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({Key? key}) : super(key: key);
  static const String pageRoute = '/about_app';

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  late YoutubePlayerController _youtubeController;

  String? subscriptionType = 'شهري';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'jv9kIErIrLI',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }

  var textStyle = const TextStyle(
    color: Color(0xffD41616),
    fontFamily: 'ElMessiri',
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );
  @override
  void dispose() {
    // TODO: implement dispose
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, bool> isFromHome =
        ModalRoute.of(context)!.settings.arguments as Map<String, bool>;
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: !isFromHome['isFromHome']!
            ? null
            : AppBar(
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                backgroundColor: AppColors.scaffoldGradientColors.first,
                centerTitle: true,
                title: Text(
                  'عن التطبيق',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                ),
              ),
        body: Container(
          decoration: BoxDecoration(
            gradient: AppColors.containerGradient,
          ),
          child: ListView(
            padding: EdgeInsets.only(
              right: screenWidth * .019,
              left: screenWidth * .019,
              bottom: screenHeight * .011,
            ),
            children: [
              mySizedBox(screenHeight * .01),
              Visibility(
                visible: !isFromHome['isFromHome']!,
                child: Center(
                  child: Text(
                    'تعرف علي ما يقدمه التطبيق',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.red,
                        ),
                  ),
                ),
              ),
              mySizedBox(screenHeight * 3),
              //todo: here check if there is network connection and based on it
              //show the player of the no internet connection state.
              Row(
                children: [
                  SizedBox(
                    width: screenWidth * .0048,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      15,
                    ),
                    child: YoutubePlayer(
                      controller: _youtubeController,
                      width: screenWidth * .946,                      
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * .0048,
                  ),
                ],
              ),
              const Divider(
                indent: 20,
                endIndent: 20,
              ),

              Visibility(
                visible: isFromHome['isFromHome']!,
                child: Text(
                  'تعرف على ما يقدمه التطبيق وأهم مميزاته',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontSize: 18,
                      ),
                ),
              ),
              mySizedBox(screenHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  aboutUsInkWell(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    label: 'التميز',
                    imageUrl: 'assets/about_app/buttons_images/excellence.svg',
                    onTap: () { Navigator.of(context).pushNamed(AppPros.pageRoute);},
                  ),
                  aboutUsInkWell(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    label: 'اهدافنا',
                    imageUrl: 'assets/about_app/buttons_images/our_goals.svg',
                    onTap: () {
                      Navigator.of(context).pushNamed(OurGoals.pageRoute);
                    },
                  ),
                ],
              ),
              mySizedBox(screenHeight * 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  aboutUsInkWell(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    label: 'مميزات التطبيق',
                    imageUrl: 'assets/about_app/buttons_images/app_pros.svg',
                    onTap: () {
                      Navigator.of(context).pushNamed(AppPros.pageRoute);
                    },
                  ),
                  aboutUsInkWell(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth,
                    label: 'تواصل معنا',
                    imageUrl: 'assets/about_app/buttons_images/contact_us.svg',
                    onTap: () {
                      _youtubeController.pause();
                      Navigator.of(context).pushNamed(ContactUs.pageRoute);
                    },
                  ),
                ],
              ),
              mySizedBox(screenHeight),
              Visibility(
                visible: !isFromHome['isFromHome']!,
                child: button(
                    label: 'دخول',
                    onPressed: () async {
                      FirebaseUserDataApi firebaseUserDataApi =
                          FirebaseUserDataApi();

                      bool isRequestExists =
                          await firebaseUserDataApi.isRequestExists();

                      if (isRequestExists) {
                        bool allowAccess =
                            await firebaseUserDataApi.getAllowAccess();
                        if (allowAccess) {
                          Navigator.of(context)
                              .pushReplacementNamed(Navigation.pageRoute);
                        } else {
                          Navigator.of(context).pushReplacementNamed(
                            SubscriptionCompleted.pageRoute,
                          );
                        }
                      } else if (!isRequestExists) {
                        await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              'تأكيد طلب الاشتراك',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            content: MyFormDropDownButton(
                              dropItems: subscriptionTypeList.toList(),
                              hint: 'نوع الاشتراك',
                              value: subscriptionTypeList.first,
                              enable: true,
                              onChanged: (value) {
                                setState(() {
                                  subscriptionType = value;
                                });
                              },
                              validator: null,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('الغاء'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  FirebaseAuthApi firebaseAuthApi =
                                      FirebaseAuthApi();
                                  String? email =
                                      firebaseAuthApi.currentUser!.email;
                                  bool allowAccess = false;
                                  SubscriptionRequest subscriptionRequest =
                                      SubscriptionRequest(
                                    email: email!,
                                    subscriptionType: subscriptionType!,
                                    allowAccess: allowAccess,
                                  );
                                  bool requestSent = await firebaseUserDataApi
                                      .sendSubscriptionRequest(
                                    subscriptionRequest,
                                  );
                                  if (requestSent) {
                                    Navigator.of(context).pushReplacementNamed(
                                      SubscriptionCompleted.pageRoute,
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'حدث خطأ ما الرجاء المحاولة لاحقا',
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: const Text('تأكيد'),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell aboutUsInkWell({
    required double screenHeight,
    required double screenWidth,
    required String label,
    required String imageUrl,
    required void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            label,
            style: textStyle,
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 1,
                style: BorderStyle.solid,
              ),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              imageUrl,
              height: screenHeight * .114,
              width: screenWidth * .189,
            ),
          ),
        ],
      ),
    );
  }

  SizedBox mySizedBox(double screenHeight) {
    return SizedBox(
      height: screenHeight * .014,
    );
  }

  ElevatedButton button(
      {required String label, required void Function()? onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        backgroundColor: MaterialStateProperty.all(
          const Color(0xffD41616),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'ElMessiri',
        ),
      ),
    );
  }
}
