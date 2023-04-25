import 'package:flutter/material.dart';
import 'package:studying_app/view/theme/app_colors.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);
  static const pageRoute = '/contact_us';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldGradientColors.first,
        elevation: 0,
        title: const Text(
          'تواصل معنا',
          style: TextStyle(
            color: Colors.red,
            fontFamily: 'ElMessiri',
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          //horizontal: 50,
          vertical: 20,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: AppColors.containerGradient,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/contact_us.png',
                ),
              ),

              Center(
                child: Text(
                  'علاء حمزة',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  ' رقم التواصل:',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.red,
                      ),
                ),
              ),
              Center(
                child: SelectableText(
                  '25242764',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'المقر الرئيسي:',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.red,
                      ),
                ),
              ),
              Center(
                child: Text(
                  'تونس.قبلي - جمنة ',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'مواقع التواصل الاجتماعي:',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.red,
                      ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              //todo:implement the code of the social media icons in a row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  socialMediaButton(
                    iconUrl: 'assets/contact_us_icons/facebook.png',
                    onTap: () {
                      //using url launcher get the url of the social media app and
                      //go to the app directly
                    },
                  ),
                  socialMediaButton(
                    iconUrl: 'assets/contact_us_icons/instagram.png',
                    onTap: () {
                      //using url launcher get the url of the social media app and
                      //go to the app directly
                    },
                  ),
                  socialMediaButton(
                    iconUrl: 'assets/contact_us_icons/twitter.png',
                    onTap: () {
                      //using url launcher get the url of the social media app and
                      //go to the app directly
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkWell socialMediaButton({
    required String iconUrl,
    required void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage(
          iconUrl,
        ),
      ),
    );
  }
}
