import 'package:flutter/material.dart';
import 'package:studying_app/logic/cubits/quiz_cubit/quiz_cubit.dart';
import 'package:studying_app/view/resources/strings/strings_manger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/view/screens/material_screens/lesson_content.dart';

import '../../theme/app_colors.dart';

class QuizCompletedPage extends StatelessWidget {
  const QuizCompletedPage({
    super.key,
    required this.rightScore,
    required this.skippedScore,
    required this.wrongScore,
    required this.materialName,
    required this.lessonName,
    required this.questionsResultMap,
  });
  final int skippedScore;
  final int rightScore;
  final int wrongScore;
  final String materialName;
  final String lessonName;
  final Map<String, int> questionsResultMap;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              answerType(
                  answerTypeInt: 1,
                  label: StringsManger.right,
                  score: rightScore),
              answerType(
                  answerTypeInt: -1,
                  label: StringsManger.wrong,
                  score: wrongScore),
              answerType(
                  answerTypeInt: 0,
                  label: StringsManger.skipped,
                  score: skippedScore),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
            itemCount: questionsResultMap.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              List<int> answers = questionsResultMap.values.toList();
              List<String> questions = questionsResultMap.keys.toList();
              return ListTile(
                leading: questionLeading(answers[index]),
                title: Text(
                  questions[index],
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: myElevatedButton(
                  context,
                  filled: true,
                  label: StringsManger.retry,
                  height: height,
                  width: width,
                  onPressed: () {
                    context.read<QuizCubit>().restartQuiz(
                          materialName: materialName,
                          lessonName: lessonName,
                        );
                  },
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: myElevatedButton(
                  context,
                  filled: false,
                  label: StringsManger.goBack,
                  height: height,
                  width: width,
                  onPressed: () {
                    context.read<QuizCubit>().clearPreviousQuizData(
                        );
                    Navigator.of(context).popUntil(
                      ModalRoute.withName(
                        LessonContent.pageRoute,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container answerType({
    required int answerTypeInt,
    required int score,
    required String label,
  }) {
    return Container(
      height: 120,
      width: 100,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black,
        ),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //put the sign of true or false or skipped
          questionLeading(answerTypeInt),
          Text(
            '$score',
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget questionLeading(int answer) {
    if (answer == 1) {
      return const CircleAvatar(
        radius: 13,
        backgroundColor: Colors.green,
        child: Text(
          '✔',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } else if (answer == 0) {
      return const CircleAvatar(
        radius: 13,
        backgroundColor: Colors.amber,
        child: Icon(
          Icons.skip_next,
          color: Colors.white,
        ),
      );
    }
    return const CircleAvatar(
      radius: 13,
      backgroundColor: Colors.red,
      child: Text(
        '✘',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget myElevatedButton(
    BuildContext context, {
    required bool filled,
    required String label,
    required double height,
    required double width,
    required void Function()? onPressed,
  }) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        backgroundColor: MaterialStateProperty.all(
          filled ? AppColors.buttonsLightColor : Colors.white.withOpacity(0),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              5,
            ),
            side: BorderSide(
              color: filled ? Colors.black.withOpacity(0) : Colors.black,
              width: 1,
            ),
          ),
        ),
        fixedSize: MaterialStateProperty.all(Size(width * .8, height * .078)),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: Theme.of(context).textTheme.button!.copyWith(
              color: filled ? Colors.white : Colors.black,
            ),
      ),
    );
  }
}
