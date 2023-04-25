import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:studying_app/data/models/exam.dart';
import 'package:studying_app/logic/blocs/firebase_exam_bloc/firebase_exam_bloc.dart';
import 'package:studying_app/logic/cubits/firebase_exam_cubit/firebase_exam_cubit.dart';
import 'package:studying_app/view/screens/exam_revision_screen/exam_revision_screen.dart';
import 'package:studying_app/view/screens/material_screens/material_all_lessons.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/widgets/app_background_container.dart';

class ExamsPage extends StatelessWidget {
  const ExamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBackground(
        child: BlocBuilder<FirebaseExamCubit, FirebaseExamState>(
          buildWhen: (previous, current) {
            return current is GotAllExamsState ||
                current is GetExamsErrorState ||
                current is FirebaseExamLoadingState;
          },
          builder: (context, state) {
            if (state is GotAllExamsState) {
              List<Exam> exams = state.exams;
              return Align(
                alignment: Alignment.topCenter,
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: exams.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white.withOpacity(0),
                      elevation: 0,
                      child: Center(
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              exams[index].examName,
                            ),
                            subtitle: Text(exams[index].formatDate()),
                            trailing: Material(
                              color: AppColors.buttonsLightColor,
                              borderRadius: BorderRadius.circular(5),
                              child: InkWell(
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 3,
                                  ),
                                  child: Text(
                                    'مراجعة',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                onTap: () {
                                  context.read<FirebaseExamContentBloc>().add(
                                        GetExamLessonsEvent(
                                          lessonsNamesList:
                                              exams[index].lessons,
                                          materialName:
                                              exams[index].materialName,
                                        ),
                                      );
                                  print('start');
                                  //TODO here we will move to the exam content like lessons and
                                  //homework and revision advices.
                                  Navigator.of(context).pushNamed(
                                    ExamRevisionScreen.pageRoute,
                                    arguments: {
                                      'materialName': exams[index].materialName,
                                      'examName':exams[index].examName,
                                      'lessonsList':exams[index].lessons,
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            if (state is GetExamsErrorState) {
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
