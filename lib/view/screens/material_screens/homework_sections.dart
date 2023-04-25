import 'package:flutter/material.dart';
import 'package:studying_app/data/constants/application_lists.dart';
import 'package:studying_app/view/screens/material_screens//one_section_content.dart';
import 'package:studying_app/view/theme/app_colors.dart';

class HomeworkSections extends StatelessWidget {
  const HomeworkSections({super.key});
  static const pageRoute = 'homework_sections';

  @override
  Widget build(BuildContext context) {
    final routeArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String materialName = routeArgus['materialName']!;
    //todo here show the sections of the homework which is the three threes
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الفروض',
          style: Theme.of(context).textTheme.headline5,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: AppColors.scaffoldGradientColors.first,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(
          top: 10,
        ),
        decoration: BoxDecoration(
          gradient: AppColors.containerGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: homeworkList
              .map((homework) => InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(OneSectionContent.pageRoute, arguments: {
                        'materialName': materialName,
                        'homeworkName': homework,
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: MediaQuery.of(context).size.height * .25,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Image.asset(
                              'assets/exam.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                homework,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
