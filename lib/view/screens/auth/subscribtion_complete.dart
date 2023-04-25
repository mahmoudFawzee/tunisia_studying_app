import 'package:flutter/material.dart';
import 'package:studying_app/data/firebase_apis/firebase_user_data_api.dart';
import 'package:studying_app/view/animation/image_fade_animation.dart';

import 'package:studying_app/view/screens/home/navigation.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/widgets/app_buttons/app_elevated_button.dart';

class SubscriptionCompleted extends StatelessWidget {
  const SubscriptionCompleted({Key? key}) : super(key: key);
  static const pageRoute = '/subscription_completed_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: AppColors.containerGradient,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'تم ارسال طلب الاشتراك بنجاح',
                style: Theme.of(context).textTheme.headline5,
              ),
              MyFadeAnim(
                child: Image.asset(
                  'assets/registration_images/done.png',
                ),
              ),
              const SelectableText(
                'الرجاء إنهاء خطوة الدفع من خلال التواصل على الرقم 28376398',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 100,
              ),
              AppElevatedButton(
                label: 'الاستمرار',
                onPressed: () async {
                  FirebaseUserDataApi firebaseUserDataApi =
                      FirebaseUserDataApi();
                  bool allowAccesses =
                      await firebaseUserDataApi.getAllowAccess();
                  allowAccesses
                      // ignore: use_build_context_synchronously
                      ? Navigator.of(context).pushReplacementNamed(
                          Navigation.pageRoute,
                        )
                      : showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: const Text(
                              ' الرجاء انهاء خطوة الدفع من خلال الرقم الموضح',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'حسنا',
                                ),
                              )
                            ],
                          ),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
