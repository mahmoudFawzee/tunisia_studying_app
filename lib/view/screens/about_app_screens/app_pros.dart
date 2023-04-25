import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/widgets/app_buttons/app_elevated_button.dart';

class AppPros extends StatelessWidget {
  AppPros({Key? key}) : super(key: key);
  static const pageRoute = 'app_pros';
  final List<Text> prosList = [
    prosText(oneAdvantage: '1-سجل في التطبيق بخطوات سهلة وبسيطة.'),
    prosText(oneAdvantage: '2-اشترك في التطبيق'),
    prosText(oneAdvantage: '3-يتميز هذا التطبيق سهولة التواصل بين الطلاب '),
    prosText(oneAdvantage: '4-تدريبات تفاعلية'),
    prosText(
        oneAdvantage:
            '5-يساعدك في مذاكرتك واستعدادك للامتحانات عن طريق عرض أسئلة وتدريبات  متنوعة لكافة المواد الدراسية.'),
    prosText(
        oneAdvantage:
            '6-يساعدك على تحصيل دروسك من اي مكان، كل ما تحتاجة هو هاتفك المحمول وإتصال بالانترنت. يمكنك مشاهدة الفيديوهات، حضور الدروس اونلاين، حل الاختبارات، والعديد من المميزات الاخرى'),
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
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
        title: const Text(
          'مميزات التطبيق',
          style: TextStyle(
            color: Colors.red,
            fontFamily: 'ElMessiri',
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(
          8,
        ),
        decoration: BoxDecoration(
          gradient: AppColors.containerGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...prosList,
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                'assets/about_app/pros_image.svg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Text prosText({required String oneAdvantage}) {
  return Text(
    oneAdvantage,
    textAlign: TextAlign.center,
    style: const TextStyle(
      fontFamily: 'ElMessiri',
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
  );
}
