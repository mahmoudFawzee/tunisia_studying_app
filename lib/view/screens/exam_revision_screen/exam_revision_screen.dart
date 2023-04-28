import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/data/models/lesson.dart';
import 'package:studying_app/logic/blocs/firebase_exam_bloc/firebase_exam_bloc.dart';
import 'package:studying_app/logic/blocs/materials_bloc/materials_bloc.dart';
import 'package:studying_app/view/resources/strings/strings_manger.dart';
import 'package:studying_app/view/screens/material_screens/lesson_content.dart';
import 'package:studying_app/view/screens/pdf/homework_section_pdfs.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/widgets/app_background_container.dart';

class ExamRevisionScreen extends StatelessWidget {
  const ExamRevisionScreen({super.key});
  static const pageRoute = 'exam_revision_page';
  final List<String> examContent = const [
    StringsManger.lessons,
    StringsManger.homework,
    StringsManger.advices,
  ];
  @override
  Widget build(BuildContext context) {
    final routeArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final examName = routeArgus['examName'];
    final materialName = routeArgus['materialName'];
    final lessonsList = routeArgus['lessonsList'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldGradientColors.first,
        elevation: 0,
        title: Text(
          StringsManger.revision,
          style: Theme.of(context).textTheme.headline5,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              DropdownButtonHideUnderline(
                  child: BlocBuilder<FirebaseExamContentBloc,
                      FirebaseExamContentState>(
                buildWhen: (previous, current) {
                  return current is ChosenExamSpecificSectionState;
                },
                builder: (context, state) {
                  if (state is ChosenExamSpecificSectionState) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      color: Colors.white.withOpacity(.8),
                      child: DropdownButton<String>(
                        items: examContent
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                ),
                              ),
                            )
                            .toList(),
                        value: state.section,
                        onChanged: (value) {
                          context.read<FirebaseExamContentBloc>().add(
                                ChooseSpecificExamSectionEvent(
                                  section: value!,
                                ),
                              );
                          if (value == StringsManger.homework) {
                            context
                                .read<FirebaseExamContentBloc>()
                                .add(GetExamHomeworkEvent(examName: examName!));
                          } else if (value == StringsManger.advices) {
                            context.read<FirebaseExamContentBloc>().add(
                                GetExamAdvicesEvent(
                                    materialName: materialName!));
                          } else {
                            context.read<FirebaseExamContentBloc>().add(
                                  GetExamLessonsEvent(
                                    materialName: materialName!,
                                    lessonsNamesList: lessonsList!,
                                  ),
                                );
                          }
                        },
                      ),
                    );
                  }
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    color: Colors.white.withOpacity(.8),
                    child: DropdownButton<String>(
                      items: examContent
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                              ),
                            ),
                          )
                          .toList(),
                      value: examContent.first,
                      onChanged: (value) {
                        context.read<FirebaseExamContentBloc>().add(
                              ChooseSpecificExamSectionEvent(
                                section: value!,
                              ),
                            );
                        if (value == StringsManger.homework) {
                          context
                              .read<FirebaseExamContentBloc>()
                              .add(GetExamHomeworkEvent(examName: examName!));
                        } else if (value == StringsManger.advices) {
                          context.read<FirebaseExamContentBloc>().add(
                              GetExamAdvicesEvent(materialName: materialName!));
                        } else {
                          context.read<FirebaseExamContentBloc>().add(
                                GetExamLessonsEvent(
                                  materialName: materialName!,
                                  lessonsNamesList: lessonsList!,
                                ),
                              );
                        }
                        print(value);
                      },
                    ),
                  );
                },
              )),
              const SizedBox(
                height: 15,
              ),
              BlocBuilder<FirebaseExamContentBloc, FirebaseExamContentState>(
                buildWhen: (previous, current) {
                  return current is! ChosenExamSpecificSectionState;
                },
                builder: (context, state) {
                  print(state);
                  if (state is GotFirebaseExamLessonsState) {
                    List<Lesson> lessonsList = state.lessonsList;
                    return ListView.builder(
                        itemCount: lessonsList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return lessonForm(
                            index,
                            context,
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  LessonContent.pageRoute,
                                  arguments: {
                                    'materialName': materialName,
                                    'name': lessonsList[index].name,
                                  });
                            },
                            lessonName: lessonsList[index].name,
                          );
                        });
                  } else if (state is GotFirebaseHomeworkState) {
                    Map<String, dynamic> homeworkMap = state.homeworkMap;

                    return ListView.builder(
                      itemCount: homeworkMap.keys.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        String key = homeworkMap.keys.elementAt(index);
                        print(key);
                        List<dynamic> homeworkSections = homeworkMap[key];

                        print(homeworkSections.runtimeType);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                key,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: homeworkSections
                                    .map(
                                      (item) => InkWell(
                                        onTap: () {
                                          context.read<MaterialsBloc>().add(
                                                GetMaterialHomeWorkEvent(
                                                  materialName: materialName!,
                                                  homeworkName: key,
                                                  homeworkSectionName: item,
                                                ),
                                              );
                                          Navigator.of(context).pushNamed(
                                            HomeworkSectionPdfs.pageRoute,
                                            arguments: {
                                              'sectionName': item,
                                              'materialName': materialName,
                                              'homeworkName': key,
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            item,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                                indent: 20,
                                endIndent: 20,
                                height: 20,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (state is GotFirebaseExamAdvicesState) {
                    List advices = state.advicesList;
                    return ListView.builder(
                      itemCount: advices.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 8),
                            child: Text(
                              advices[index],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.scaffoldGradientColors.first,
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

  Column lessonForm(int index, BuildContext context,
      {required void Function()? onTap, required String lessonName}) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundColor: const Color(0xffBA68C8),
            child: Center(
              child: Text(
                '${index + 1}',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white),
              ),
            ),
          ),
          title: Text(
            lessonName,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        const Divider(
          thickness: 1,
          height: 15,
        ),
      ],
    );
  }
}
