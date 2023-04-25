part of 'quiz_cubit.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class QuizInitialState extends QuizState {
  const QuizInitialState();
}

class GotUserAnswerResultState extends QuizState {
  final bool isRight;
  final int userAnswerIndex;
  final List<bool> isAnswersRightList;
  const GotUserAnswerResultState({
    required this.isRight,
    required this.userAnswerIndex,
    required this.isAnswersRightList,
  });
  @override
  // TODO: implement props
  List<Object> get props => [isRight, userAnswerIndex, isAnswersRightList];
}

class UserChosenAnswerState extends QuizState {
  final int chosenAnswerIndex;
  const UserChosenAnswerState({
    required this.chosenAnswerIndex,
  });
  @override
  List<Object> get props => [
        chosenAnswerIndex,
      ];
}

class GotQuestionState extends QuizState {
  final Question question;
  final List<bool> isAnswersRightList;
  const GotQuestionState({
    required this.question,
    required this.isAnswersRightList,
  });
  @override
  List<Object> get props => [question, isAnswersRightList];
}

class QuestionsEndState extends QuizState {
  final List<bool> isAnswersRightList;
  const QuestionsEndState({required this.isAnswersRightList,});
  @override
  // TODO: implement props
  List<Object> get props => [isAnswersRightList,];
}

class ViewResultState extends QuizState {
  final int rightAnswers;
  final int wrongAnswers;
  final int skippedAnswers;
  final Map<String, int> results;
  const ViewResultState({
    required this.rightAnswers,
    required this.wrongAnswers,
    required this.skippedAnswers,
    required this.results,
  });
  @override
  List<Object> get props => [
        rightAnswers,
        wrongAnswers,
        results,
        skippedAnswers,
      ];
}
