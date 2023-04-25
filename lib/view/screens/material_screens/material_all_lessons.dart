import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/logic/blocs/lessons_bloc/lessons_bloc.dart';
import 'package:studying_app/view/screens/material_screens/lesson_content.dart';

import '../../theme/app_colors.dart';

class MaterialAllLessons extends StatelessWidget {
  const MaterialAllLessons({super.key});
  static const pageRoute = 'material_all_lessons';

  @override
  Widget build(BuildContext context) {
    final routeArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final materialName = routeArgus['materialName'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
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
        child: BlocBuilder<LessonsBloc, LessonsState>(
          builder: (context, state) {
            print(state);
            if (state is GotMaterialLessonsState) {
              final lessons = state.materialLessons;
              return Center(
                child: Column(
                  children: [
                    Text(
                      materialName!,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.red,
                          ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: lessons.length,
                      itemBuilder: (context, index) {
                        return lessonForm(
                          index,
                          context,
                          lessonName: lessons[index].name,
                          onTap: () => Navigator.of(context).pushNamed(
                            LessonContent.pageRoute,
                            arguments: {
                              'name': lessons[index].name,
                              'materialName': materialName,
                            },
                          ),
                        );
                      },
                    ),
                    const Divider(
                      thickness: 1,
                      height: 15,
                    ),
                  ],
                ),
              );
            } else if (state is GotExamLessonsState) {
              final lessons = state.examLessons;
              return Center(
                child: Column(
                  children: [
                    Text(
                      materialName!,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.red,
                          ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: lessons.length,
                      itemBuilder: (context, index) {
                        return lessonForm(
                          index,
                          context,
                          lessonName: lessons[index].name,
                          onTap: () => Navigator.of(context).pushNamed(
                            LessonContent.pageRoute,
                            arguments: {
                              'name': lessons[index].name,
                              'materialName': materialName,
                            },
                          ),
                        );
                      },
                    ),
                    const Divider(
                      thickness: 1,
                      height: 15,
                    ),
                  ],
                ),
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

  Column lessonForm(int index, BuildContext context,
      {required void Function()? onTap, required String lessonName}) {
    return Column(
      children: [
        const Divider(
          thickness: 1,
          height: 15,
        ),
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
      ],
    );
  }
}
