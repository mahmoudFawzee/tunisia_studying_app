import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/logic/cubits/pdf_cubit/pdf_cubit.dart';
import 'package:studying_app/view/resources/assets/assets_manger.dart';
import 'package:studying_app/view/screens/pdf/pdf_viewer_page.dart';

import '../../../logic/blocs/materials_bloc/materials_bloc.dart';
import '../../theme/app_colors.dart';

class HomeworkSectionPdfs extends StatelessWidget {
  const HomeworkSectionPdfs({super.key});
  static const pageRoute = 'homework_section_pdf_page';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final routeArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final materialName = routeArgus['materialName']!;
    final homeworkName = routeArgus['homeworkName'];
    final sectionName = routeArgus['sectionName'];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          sectionName!,
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
        child: BlocBuilder<MaterialsBloc, MaterialsState>(
          builder: (context, state) {
            if (state is GotMaterialHomeworkState) {
              final homework = state.homework;
              return GridView.builder(
                itemCount: homework.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: width / 4,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      context.read<PdfCubit>().getPdf(
                            materialName: materialName,
                            pdfName: homework[index],
                            homeworkName: homeworkName,
                            homeworkSectionName: sectionName,
                          );
                      Navigator.of(context).pushNamed(
                        PdfViewerPage.pageRoute,
                        arguments: {
                          'materialName': materialName,
                          'homeworkName':homeworkName,
                          'homeworkSectionName':sectionName,
                          'pdfName':homework[index],
                        },
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          LessonImagesManger.exercisesQuestion,
                          height: width / 8,
                        ),
                        Text(
                          '${index + 1}',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is GetMaterialErrorState) {
              return Center(
                child: Text(
                  state.errorMessage,
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.scaffoldGradientColors.first,
              ),
            );
          },
        ),
      ),
    );
  }
}