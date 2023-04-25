import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/data/constants/enums.dart';
import 'package:studying_app/logic/blocs/lessons_bloc/lessons_bloc.dart';
import 'package:studying_app/view/resources/assets/assets_manger.dart';
import 'package:studying_app/view/screens/pdf/pdf_viewer_page.dart';
import 'package:studying_app/view/theme/app_colors.dart';

import '../../../logic/cubits/pdf_cubit/pdf_cubit.dart';
import '../../widgets/pdf_form.dart';

class LessonMaterialPdfsPage extends StatelessWidget {
  const LessonMaterialPdfsPage({super.key});
  static const pageRoute = 'lesson_material_pdfs_page';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final routeArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final materialName = routeArgus['materialName'];
    final lessonName = routeArgus['lessonName'];
    final LessonProperty lessonProperty = routeArgus['lessonProperty'];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.scaffoldGradientColors.first,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          lessonName,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(
          top: 10,
        ),
        decoration: BoxDecoration(
          gradient: AppColors.containerGradient,
        ),
        child: BlocBuilder<LessonsBloc, LessonsState>(
          builder: (context, state) {
            if (state is GotLessonSummariesState) {
              List<String> pdfs = state.lessonMaterialsPdfs;
              return ListView.builder(
                itemCount: pdfs.length,
                itemBuilder: (context, index) {
                  return PdfForm(
                    name: pdfs[index],
                    onTap: () {
                      context.read<PdfCubit>().getPdf(
                            materialName: materialName!,
                            pdfName: pdfs[index],
                            lessonName: lessonName,
                            lessonProperty: lessonProperty,
                          );
                      Navigator.of(context).pushNamed(
                        PdfViewerPage.pageRoute,
                        arguments: {
                          'materialName': materialName,
                          'lessonProperty': lessonProperty,
                          'pdfName': pdfs[index],
                        },
                      );
                    },
                  );
                },
              );
            } else if (state is GotLessonExercisesState) {
              final exercises = state.lessonExercisesPdfs;
              return GridView.builder(
                itemCount: exercises.length,
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
                            materialName: materialName!,
                            pdfName: exercises[index],
                            lessonName: lessonName,
                            lessonProperty: lessonProperty,
                          );
                      Navigator.of(context).pushNamed(
                        PdfViewerPage.pageRoute,
                        arguments: {
                          'materialName': materialName,
                          'lessonProperty': lessonProperty,
                          'lessonName': lessonName,
                          'pdfName': exercises[index],
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
            } else if (state is GetMaterialLessonsErrorState) {
              return Center(
                child: Text(state.error),
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
