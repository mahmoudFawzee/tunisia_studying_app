import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/data/constants/application_lists.dart';
import 'package:studying_app/data/providers/notification_provider.dart';
import 'package:studying_app/logic/cubits/firebase_exam_cubit/firebase_exam_cubit.dart';
import 'package:studying_app/logic/cubits/notifications_cubit/notifications_cubit.dart';
import 'package:studying_app/view/resources/strings/strings_manger.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/widgets/app_background_container.dart';

class AddExamPage extends StatefulWidget {
  const AddExamPage({super.key});

  @override
  State<AddExamPage> createState() => _AddExamPageState();
}

class _AddExamPageState extends State<AddExamPage> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldGradientColors.first,
        title: Text(
          StringsManger.addHomework,
          style: Theme.of(context).textTheme.headline5,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
      ),
      body: AppBackground(
        child: BlocBuilder<FirebaseExamCubit, FirebaseExamState>(
          buildWhen: (previous, current) {
            return current is FirebaseExamLoadingState ||
                current is GotAllMaterialsState;
          },
          builder: (context, state) {
            if (state is GotAllMaterialsState) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'ما ينتمي اليه الفرض',
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        context.read<FirebaseExamCubit>().checkExamTitle(
                              title: value,
                            );
                      },
                    ),
                    BlocBuilder<FirebaseExamCubit, FirebaseExamState>(
                      buildWhen: (previous, current) {
                        return current is SelectedDateAcceptedState ||
                            current is SelectedDateNotAcceptedState;
                      },
                      builder: (context, state) {
                        if (state is SelectedDateAcceptedState) {
                          return Center(
                            child: Card(
                              margin: const EdgeInsets.symmetric(vertical: 30),
                              child: ListTile(
                                leading:
                                    const Text('${StringsManger.examDate} : '),
                                title: Text(
                                  state.selectedDate,
                                ),
                                subtitle: Text(
                                  state.selectedTime,
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    context
                                        .read<FirebaseExamCubit>()
                                        .setExamDate(context);
                                  },
                                  icon: const Icon(
                                    Icons.date_range,
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (state is SelectedDateNotAcceptedState) {
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 30),
                            child: ListTile(
                              onTap: () {
                                context
                                    .read<FirebaseExamCubit>()
                                    .setExamDate(context);
                              },
                              title: const Text(
                                StringsManger.dateNotAccepted,
                              ),
                              trailing: const Icon(
                                Icons.date_range,
                              ),
                            ),
                          );
                        }
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 30),
                          child: ListTile(
                            onTap: () {
                              context
                                  .read<FirebaseExamCubit>()
                                  .setExamDate(context);
                            },
                            title: const Text(
                              StringsManger.examDate,
                            ),
                            trailing: const Icon(
                              Icons.date_range,
                            ),
                          ),
                        );
                      },
                    ),
                    BlocBuilder<FirebaseExamCubit, FirebaseExamState>(
                      buildWhen: (previous, current) {
                        return current is GotAllMaterialsState ||
                            current is MaterialSelectedState;
                      },
                      builder: (context, state) {
                        if (state is GotAllMaterialsState) {
                          List<String> materials = state.materials;
                          return selectMaterialDropdownButton(
                            context,
                            materials: materials,
                          );
                        } else if (state is MaterialSelectedState) {
                          return selectMaterialDropdownButton(
                            context,
                            materials: state.materials,
                            selectedMaterial: state.selectedMaterial,
                          );
                        }
                        return Container();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        StringsManger.lessons,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    //todo: here show the lessons
                    BlocBuilder<FirebaseExamCubit, FirebaseExamState>(
                      buildWhen: (previous, current) {
                        return current is GotMaterialAllLessonsState ||
                            current is GetNoLessonsState ||
                            current is LessonsLoadingState;
                      },
                      builder: (context, state) {
                        if (state is GotMaterialAllLessonsState) {
                          var allLessons = state.allLessons;
                          return lessonsWrappedBuilder(
                            context,
                            allLessons: allLessons,
                          );
                        } else if (state is GetNoLessonsState) {
                          return Center(
                            child: Text(state.string),
                          );
                        } else if (state is LessonsLoadingState) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.scaffoldGradientColors.first,
                            ),
                          );
                        }
                        return const Center(
                          child: Text(
                            StringsManger.chooseAMaterial,
                          ),
                        );
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Text(
                        StringsManger.homework,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),

                    Column(
                      children: [
                        homeworkColumnBuilder(
                          context,
                          tripleHomework: homeworkList.first,
                          height: height,
                          width: width,
                        ),
                        homeworkColumnBuilder(
                          context,
                          tripleHomework: homeworkList[1],
                          height: height,
                          width: width,
                        ),
                        homeworkColumnBuilder(
                          context,
                          tripleHomework: homeworkList.last,
                          height: height,
                          width: width,
                        ),
                      ],
                    ),
                  ],
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
      floatingActionButton: BlocListener<FirebaseExamCubit, FirebaseExamState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is ValidateExamState) {
            if (state.isValidate) {
              context.read<FirebaseExamCubit>().addExam();
              Navigator.of(context).pop();
            }
          } else if (state is ExamAddedState) {
            MyNotification notification = MyNotification(
              name: state.addedExam.examName,
              dateTime: state.addedExam.examDate,
            );
            context.read<NotificationsCubit>().addNotification(
                  notification: notification,
                  scheduleDaily: true,
                );
          }
        },
        child: FloatingActionButton(
          backgroundColor: AppColors.buttonsLightColor,
          onPressed: () {
            context.read<FirebaseExamCubit>().validateNewExamData(
                  context,
                );
          },
          child: const Icon(
            Icons.done,
          ),
        ),
      ),
    );
  }

  // Column chooseHomework(
  Widget homeworkColumnBuilder(
    BuildContext context, {
    required String tripleHomework,
    required double height,
    required double width,
  }) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            tripleHomework,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontSize: 14,
                ),
          ),
        ),
        BlocBuilder<FirebaseExamCubit, FirebaseExamState>(
          buildWhen: (previous, current) {
            return (current is AddedExamHomeworkState &&
                    current.key == tripleHomework) ||
                (current is RemovedExamHomeworkState &&
                    current.key == tripleHomework);
          },
          builder: (context, state) {
            if (state is AddedExamHomeworkState) {
              return tripleHomeworkRow(
                context,
                height: height,
                width: width,
                tripleHomework: tripleHomework,
                selectedHomeworkSections: state.homeworkSelectedSections,
              );
            } else if (state is RemovedExamHomeworkState) {
              return tripleHomeworkRow(
                context,
                height: height,
                width: width,
                tripleHomework: tripleHomework,
                selectedHomeworkSections: state.homeworkSelectedSections,
              );
            }
            return tripleHomeworkRow(
              context,
              height: height,
              width: width,
              tripleHomework: tripleHomework,
              selectedHomeworkSections: [],
            );
          },
        ),
      ],
    );
  }

  Row tripleHomeworkRow(
    BuildContext context, {
    required double height,
    required double width,
    required String tripleHomework,
    required List<String> selectedHomeworkSections,
  }) {
    return Row(
      children: [
        for (var section in homeWorkSectionsList)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            height: height * .13,
            width: width * .4,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: selectedHomeworkSections.contains(section)
                      ? IconButton(
                          onPressed: () {
                            context.read<FirebaseExamCubit>().removeHomework(
                                  key: tripleHomework,
                                  value: section,
                                );
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.red,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            context.read<FirebaseExamCubit>().addExamHomework(
                                  key: tripleHomework,
                                  value: section,
                                );
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.green,
                          ),
                        ),
                ),
                Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Image.asset(
                        'assets/homework.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      flex: 2,
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
              ],
            ),
          ),
      ],
    );
  }

  Widget lessonsWrappedBuilder(
    BuildContext context, {
    required List<String> allLessons,
  }) {
    return BlocBuilder<FirebaseExamCubit, FirebaseExamState>(
      buildWhen: (previous, current) {
        return current is AddedLessonState || current is RemovedLessonState;
      },
      builder: (context, state) {
        if (state is AddedLessonState) {
          print('selected lessons : ${state.selectedLessons}');
          return materialLessonsWrapped(
            context,
            allLessons: allLessons,
            selectedLessons: state.selectedLessons,
          );
        } else if (state is RemovedLessonState) {
          print('selected lessons : ${state.selectedLessons}');
          return materialLessonsWrapped(
            context,
            allLessons: allLessons,
            selectedLessons: state.selectedLessons,
          );
        }
        return materialLessonsWrapped(
          context,
          allLessons: allLessons,
          selectedLessons: [],
        );
      },
    );
  }

  Wrap materialLessonsWrapped(
    BuildContext context, {
    required List<String> allLessons,
    required List<String> selectedLessons,
  }) {
    return Wrap(
      children: [
        for (var lesson in allLessons)
          Container(
            alignment: Alignment.center,
            height: 100,
            width: 120,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [
                Card(
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      lesson,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: selectedLessons.contains(lesson)
                      ? IconButton(
                          onPressed: () {
                            context.read<FirebaseExamCubit>().removeLesson(
                                  lessonName: lesson,
                                );
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.red,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            context.read<FirebaseExamCubit>().addLesson(
                                  lessonName: lesson,
                                );
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.green,
                          ),
                        ),
                )
              ],
            ),
          ),
      ],
    );
  }

  Container selectMaterialDropdownButton(
    BuildContext context, {
    String? selectedMaterial,
    required List<String> materials,
  }) {
    return Container(
      //margin: const EdgeInsets.symmetric(horizontal: 50),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: selectedMaterial,
          hint: const Text(StringsManger.materialName),
          items: materials
              .map(
                (material) => DropdownMenuItem<String>(
                  value: material,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(
                        width: .5,
                        color: Colors.black,
                      ),
                    )),
                    child: Text(
                      material,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (material) {
            context.read<FirebaseExamCubit>().getMaterialLessons(
                  materialName: material!,
                );
          },
        ),
      ),
    );
  }
}
