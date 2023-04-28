import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/logic/cubits/quiz_cubit/quiz_cubit.dart';
import 'package:studying_app/view/resources/strings/strings_manger.dart';
import 'package:studying_app/view/screens/quiz/quiz_completed_page.dart';
import 'package:studying_app/view/widgets/app_buttons/app_elevated_button.dart';

import '../../theme/app_colors.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});
  static const pageRoute = 'quiz_page';

  @override
  Widget build(BuildContext context) {
    final routeArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String materialName = routeArgus['materialName']!;
    final String lessonName = routeArgus['lessonName']!;
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        context.read<QuizCubit>().clearPreviousQuizData();
        return true;
      },
      child: Scaffold(
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
          decoration: BoxDecoration(
            gradient: AppColors.containerGradient,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              child: Column(
                children: [
                  BlocBuilder<QuizCubit, QuizState>(
                    buildWhen: (previous, current) {
                      return current is GotQuestionState ||
                          current is ViewResultState ||
                          current is QuizInitialState;
                    },
                    builder: (context, state) {
                      if (state is GotQuestionState) {
                        final question = state.question;
                        return Column(
                          children: [
                            BlocBuilder<QuizCubit, QuizState>(
                              buildWhen: (previous, current) {
                                return current is GotUserAnswerResultState ||
                                    current is GotQuestionState ||
                                    current is QuestionsEndState;
                              },
                              builder: (context, state) {
                                print('is right state is $state');
                                if (state is GotUserAnswerResultState) {
                                  return userProgressIndicator(
                                    state.isAnswersRightList,
                                  );
                                } else if (state is GotQuestionState) {
                                  return userProgressIndicator(
                                    state.isAnswersRightList,
                                  );
                                } else if (state is QuestionsEndState) {
                                  return userProgressIndicator(
                                    state.isAnswersRightList,
                                  );
                                }
                                return const Text('no thing for now');
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                              state.question.question,
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .02,
                            ),
                            ListView.builder(
                              itemCount: question.answers.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return answerForm(
                                  context,
                                  answer: question.answers[index],
                                  answerIndex: index,
                                );
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocBuilder<QuizCubit, QuizState>(
                              builder: (context, state) {
                                if (state is GotQuestionState) {
                                  return AppElevatedButton(
                                    onPressed: () {
                                      context.read<QuizCubit>().checkAnswer();
                                    },
                                    label: StringsManger.next,
                                  );
                                } else if (state is GotUserAnswerResultState) {
                                  return AppElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<QuizCubit>()
                                          .getNextQuestion();
                                    },
                                    label: StringsManger.next,
                                  );
                                } else if (state is UserChosenAnswerState) {
                                  return AppElevatedButton(
                                    onPressed: () {
                                      context.read<QuizCubit>().checkAnswer(
                                            studentAnswerIndex:
                                                state.chosenAnswerIndex,
                                          );
                                    },
                                    label: StringsManger.checkAnswer,
                                  );
                                } else if (state is QuestionsEndState) {
                                  return AppElevatedButton(
                                    onPressed: () {
                                      context.read<QuizCubit>().viewResults();
                                    },
                                    label: StringsManger.viewResult,
                                  );
                                }
                                return Container();
                              },
                            )
                          ],
                        );
                      } else if (state is ViewResultState) {
                        return QuizCompletedPage(
                          rightScore: state.rightAnswers,
                          skippedScore: state.skippedAnswers,
                          wrongScore: state.wrongAnswers,
                          questionsResultMap: state.results,
                          materialName: materialName,
                          lessonName: lessonName,
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.scaffoldGradientColors.first,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget userProgressIndicator(List<bool> progressList) {
    return Align(
      alignment: Alignment.centerRight,
      child: Wrap(
        runAlignment: WrapAlignment.center,
        children: progressList
            .map(
              (isRight) => Container(
                height: 10,
                width: 30,
                decoration: BoxDecoration(
                  color: isRight ? Colors.green : Colors.red,
                ),
                child: const Text(''),
              ),
            )
            .toList(),
      ),
    );
  }

  ElevatedButton customQuestionActionButton({
    required void Function()? onPressed,
    required String label,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        label,
      ),
    );
  }

  Widget answerForm(
    BuildContext context, {
    required String answer,
    required int answerIndex,
  }) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        BlocBuilder<QuizCubit, QuizState>(
          buildWhen: (_, current) {
            return current is GotUserAnswerResultState ||
                current is GotQuestionState ||
                current is QuestionsEndState;
          },
          builder: (context, state) {
            return InkWell(
              onTap: state is GotUserAnswerResultState ||
                      state is QuestionsEndState
                  ? null
                  : () {
                      context.read<QuizCubit>().chooseAnswer(
                            chosenAnswerIndex: answerIndex,
                          );
                    },
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<QuizCubit, QuizState>(
                          buildWhen: (_, current) {
                            return current is UserChosenAnswerState ||
                                current is GotQuestionState;
                          },
                          builder: (context, state) {
                            if (state is UserChosenAnswerState) {
                              return Radio(
                                value: state.chosenAnswerIndex == answerIndex,
                                //!This radio button is considered selected if its [value] matches the [groupValue]
                                groupValue: true,
                                onChanged: null,
                                toggleable: false,
                                fillColor: MaterialStateProperty.all(
                                  Colors.black,
                                ),
                              );
                            }
                            return Radio(
                              value: false,
                              //!This radio button is considered selected if its [value] matches the [groupValue]
                              groupValue: true,
                              onChanged: null,
                              toggleable: false,
                              fillColor: MaterialStateProperty.all(
                                Colors.black,
                              ),
                            );
                          },
                        ),
                        Text(
                          answer,
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontSize: 18,
                                  ),
                        ),
                        BlocBuilder<QuizCubit, QuizState>(
                          buildWhen: (_, current) {
                            return current is GotUserAnswerResultState ||
                                current is GotQuestionState;
                          },
                          builder: (context, state) {
                            if (state is GotUserAnswerResultState) {
                              if (answerIndex == state.userAnswerIndex) {
                                if (state.isRight) {
                                  return const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      StringsManger.rightAnswer,
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 12,
                                      ),
                                    ),
                                  );
                                } else {
                                  return const Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      StringsManger.wrongAnswer,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  );
                                }
                              }
                            }
                            return Container();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
