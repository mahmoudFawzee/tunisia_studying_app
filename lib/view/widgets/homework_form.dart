import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/data/models/exam.dart';
import 'package:studying_app/logic/cubits/firebase_exam_cubit/firebase_exam_cubit.dart';

import '../../data/models/homework.dart';
import '../../logic/cubits/local_homework_cubit/local_homework_cubit.dart';

class HomeworkForm extends StatelessWidget {
  const HomeworkForm({
    Key? key,
    required this.homework,
    required this.exam,
  }) : super(key: key);
  final Homework? homework;
  final Exam? exam;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        title: Text(
          homework != null ? homework!.homeworkName : exam!.examName,
        ),
        subtitle: Text(
          homework != null ? homework!.dateTimeString() : exam!.formatDate(),
        ),
        trailing: Checkbox(
          onChanged: (_) {
            if (homework != null) {
              context.read<LocalHomeworkCubit>().deleteHomework(
                    homework!,
                  );
            } else {
              //todo do the part of delete the exam
              context.read<FirebaseExamCubit>().deleteExam(
                    examName: exam!.examName,
                  );
            }
          },
          value: false,
        ),
      ),
    );
  }
}
