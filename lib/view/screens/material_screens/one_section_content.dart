import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:studying_app/data/constants/application_lists.dart';
import 'package:studying_app/logic/blocs/materials_bloc/materials_bloc.dart';
import 'package:studying_app/view/screens/pdf/homework_section_pdfs.dart';
import 'package:studying_app/view/theme/app_colors.dart';

class OneSectionContent extends StatelessWidget {
  const OneSectionContent({super.key});
  static const pageRoute = 'one_section_content_page';

  @override
  Widget build(BuildContext context) {
    final routeArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final materialName = routeArgus['materialName'];
    final homeworkName = routeArgus['homeworkName'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          homeworkName!,
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
          children: homeWorkSectionsList
              .map(
                (section) => InkWell(
                  onTap: () {
                    context.read<MaterialsBloc>().add(
                          GetMaterialHomeWorkEvent(
                            materialName: materialName!,
                            homeworkName: homeworkName,
                            homeworkSectionName: section,
                          ),
                        );
                    Navigator.of(context).pushNamed(
                      HomeworkSectionPdfs.pageRoute,
                      arguments: {'sectionName':section,
                      'materialName':materialName,
                      'homeworkName':homeworkName,
                      },
                    );
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
                            'assets/homework.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              section,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
