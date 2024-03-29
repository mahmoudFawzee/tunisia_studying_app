// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:studying_app/data/firebase_apis/fire_base_auth_api.dart';
import 'package:studying_app/data/firebase_apis/firebase_user_data_api.dart';
import 'package:studying_app/view/resources/assets/assets_manger.dart';
import 'package:studying_app/view/screens/auth/subscribtion_complete.dart';

import 'package:studying_app/view/screens/home/navigation.dart';
import 'package:studying_app/view/screens/start/introduction_screen.dart';
import 'package:studying_app/view/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const pageRoute = '/splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuthApi _firebaseApi = FirebaseAuthApi();
  final FirebaseUserDataApi _firebaseUserDataApi = FirebaseUserDataApi();
  
  Future <bool>canAccess() async {
    try {
      return await _firebaseUserDataApi.getAllowAccess();
    } catch (e) {
      return false;
    }
    
  }

  nextPage() async{
    //todo: handle the state of no network to get the home page
    //but without content and show to the user that no internet connection
    if (_firebaseApi.isUser) {
      bool access = await canAccess();
      print(_firebaseApi.isUser);
      if (access == true) {
        Navigator.of(context).pushReplacementNamed(Navigation.pageRoute);
      } else {
        Navigator.of(context)
            .pushReplacementNamed(SubscriptionCompleted.pageRoute);
      }
    } else {
      Navigator.of(context).pushReplacementNamed(OnBoardingScreen.pageRoute);
    }   
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        const Duration(
          seconds: 3,
        ), () {
      nextPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.scaffoldGradientColors,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            //  stops: const [0, .5],
          ),
        ),
        child: Image.asset(
          SplashImageManger.splashImage,
          //height: 100,
          //width: 100,
        ),
      ),
    );
  }
}
