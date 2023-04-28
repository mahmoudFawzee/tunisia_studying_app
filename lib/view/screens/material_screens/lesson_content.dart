import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/data/constants/enums.dart';
import 'package:studying_app/logic/blocs/lessons_bloc/lessons_bloc.dart';
import 'package:studying_app/logic/cubits/quiz_cubit/quiz_cubit.dart';
import 'package:studying_app/view/resources/assets/assets_manger.dart';
import 'package:studying_app/view/screens/pdf/lesson_pdfs.dart';
import 'package:studying_app/view/screens/quiz/quiz_page.dart';
import 'package:studying_app/view/screens/video/lesson_video.dart';
import 'package:studying_app/view/theme/app_colors.dart';

class LessonContent extends StatelessWidget {
  const LessonContent({super.key});
  static const pageRoute = 'lesson_content_page';
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    double screenHeight = orientation == Orientation.portrait
        ? MediaQuery.of(context).size.height
        : MediaQuery.of(context).size.width;
    double screenWidth = orientation == Orientation.portrait
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;
    final routArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final lessonName = routArgus['name'];
    final materialName = routArgus['materialName'];

    return WillPopScope(
      onWillPop: () async {
        context.read<LessonsBloc>().add(
              GetMaterialLessonEvent(materialName: materialName!),
            );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: AppColors.scaffoldGradientColors.first,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              context.read<LessonsBloc>().add(
                    GetMaterialLessonEvent(materialName: materialName!),
                  );
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            lessonName,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: AppColors.containerGradient,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customItem(
                    context: context,
                    name: 'الكويز',
                    imagePath: LessonImagesManger.quiz,
                    height: screenHeight,
                    width: screenWidth,
                    onTap: () {
                      context.read<QuizCubit>().getQuiz(
                            materialName: materialName!,
                            lessonName: lessonName!,
                          );
                      Navigator.of(context).pushNamed(
                        QuizPage.pageRoute,
                        arguments: {
                          'materialName': materialName,
                          'lessonName': lessonName,
                        },
                      );
                      print(materialName);
                      print(lessonName);
                    },
                  ),
                  customItem(
                    context: context,
                    name: 'فيديو للدرس',
                    imagePath: LessonImagesManger.video,
                    height: screenHeight,
                    width: screenWidth,
                    onTap: () {
                      context.read<LessonsBloc>().add(
                            GetLessonVideoEvent(
                              lessonName: lessonName!,
                              materialName: materialName!,
                            ),
                          );
                      Navigator.of(context).pushNamed(
                        LessonVideoScreen.pageRoute,
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customItem(
                    context: context,
                    name: 'التمارين',
                    imagePath: LessonImagesManger.exercises,
                    height: screenHeight,
                    width: screenWidth,
                    onTap: () {
                      context.read<LessonsBloc>().add(
                            GetLessonExercisesEvent(
                              lessonName: lessonName!,
                              materialName: materialName!,
                              lessonProperty: LessonProperty.exercises,
                            ),
                          );
                      Navigator.of(context).pushNamed(
                        LessonMaterialPdfsPage.pageRoute,
                        arguments: {
                          'materialName': materialName,
                          'lessonName': lessonName,
                          'lessonProperty': LessonProperty.exercises,
                        },
                      );
                    },
                  ),
                  customItem(
                    context: context,
                    name: 'ملخصات الدرس',
                    imagePath: LessonImagesManger.summaries,
                    height: screenHeight,
                    width: screenWidth,
                    onTap: () {
                      context.read<LessonsBloc>().add(GetLessonSummariesEvent(
                            lessonName: lessonName!,
                            materialName: materialName!,
                            lessonProperty: LessonProperty.summary,
                          ));
                      Navigator.of(context).pushNamed(
                        LessonMaterialPdfsPage.pageRoute,
                        arguments: {
                          'materialName': materialName,
                          'lessonName': lessonName,
                          'lessonProperty': LessonProperty.summary,
                        },
                      );
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

  SizedBox customItem({
    required BuildContext context,
    required String name,
    required String imagePath,
    required void Function()? onTap,
    required double height,
    required double width,
  }) {
    return SizedBox(
      height: height * (18 / 68),
      width: width * (14 / 41),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            ClipRRect(
              child: Image.asset(
                imagePath,
              ),
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
      ),
    );
  }
}
