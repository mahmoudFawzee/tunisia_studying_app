import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/data/models/homework.dart';
import 'package:studying_app/view/resources/strings/strings_manger.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/widgets/app_background_container.dart';
import 'package:studying_app/view/widgets/homework_form.dart';

import '../../../logic/cubits/local_homework_cubit/local_homework_cubit.dart';

class LocalHomeworkPage extends StatelessWidget {
  const LocalHomeworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBackground(
        child: BlocBuilder<LocalHomeworkCubit, LocalHomeworkState>(
          builder: (context, state) {
            print('local homework state : $state');
            if (state is GotMyHomeworkState) {
              final homeworkList = state.homeworkList;
              return stateWidget(stateList: homeworkList, context: context);
            } else if (state is DeletedHomeworkState) {
              final homeworkList = state.homeworkList;
              return stateWidget(stateList: homeworkList, context: context);
            } else if (state is GetHomeworkErrorState) {
              return const Center(
                child: Text(
                  StringsManger.addExercise,
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: AppColors.scaffoldGradientColors.first,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget stateWidget({
    required List<Homework> stateList,
    required BuildContext context,
  }) {
    return Column(
      children: stateList
          .map(
            (homework) => HomeworkForm(
              homework: homework,
              exam: null,
            ),
          )
          .toList(),
    );
  }
}
