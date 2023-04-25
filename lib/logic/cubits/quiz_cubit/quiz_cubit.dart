import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:studying_app/data/providers/quiz_api.dart';
import 'package:studying_app/data/models/question.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(const QuizInitialState());
  final QuizApi quizApi = QuizApi();
  List<Question> questionsList = [];
  //todo: using this index we can get the current question and answers and right answer
  int currentQuestionIndex = 0;
  int rightAnswers = 0;
  int wrongAnswers = 0;
  int skippedAnswers = 0;
  List<bool> isUserAnswersRightList = [];
  Map<String, int> resultsMap = {};

  void clearPreviousQuizData() {
    questionsList.clear();
    //todo: using this index we can get the current question and answers and right answer
    currentQuestionIndex = 0;
    wrongAnswers = 0;
    skippedAnswers = 0;
    rightAnswers = 0;
    isUserAnswersRightList.clear();
    resultsMap.clear();
  }

  Future<void> getQuiz({
    required String materialName,
    required String lessonName,
  }) async {
    emit(const QuizInitialState());
    try {
      questionsList = await quizApi.getQuiz(
        materialName: materialName,
        lessonName: lessonName,
      );
      print(questionsList);
      emit(GotQuestionState(
          question: questionsList.first,
          isAnswersRightList: isUserAnswersRightList));
    } on FirebaseException catch (_) {
      null;
    } catch (e) {
      null;
    }
  }

  Future<void> restartQuiz({
    required String materialName,
    required String lessonName,
  }) async {
    clearPreviousQuizData();
    await getQuiz(
      materialName: materialName,
      lessonName: lessonName,
    );
  }

  void getNextQuestion() {
    currentQuestionIndex++;
    if (currentQuestionIndex < questionsList.length) {
      Question currentQuestion = questionsList[currentQuestionIndex];
      emit(GotQuestionState(
          question: currentQuestion, isAnswersRightList: isUserAnswersRightList));
    } else {
      emit(
         QuestionsEndState(isAnswersRightList: isUserAnswersRightList),
      );
    }
  }

  void viewResults() {
    emit(
      ViewResultState(
        rightAnswers: rightAnswers,
        wrongAnswers: wrongAnswers,
        skippedAnswers: skippedAnswers,
        results: resultsMap,
      ),
    );
  }

  void checkAnswer({
    int? studentAnswerIndex,
  }) {
    int rightAnswerIndex = questionsList[currentQuestionIndex].rightAnswerIndex;
    if (studentAnswerIndex != null) {
      if (studentAnswerIndex == rightAnswerIndex) {
        rightAnswers++;
        isUserAnswersRightList.add(true);
        print(isUserAnswersRightList.length);
        resultsMap.addAll({
          questionsList[currentQuestionIndex].question: 1,
        });
        emit(GotUserAnswerResultState(
          isRight: studentAnswerIndex == rightAnswerIndex,
          userAnswerIndex: studentAnswerIndex,
          isAnswersRightList: isUserAnswersRightList,
        ));
      } else {
        wrongAnswers++;
        isUserAnswersRightList.add(false);
        resultsMap.addAll({
          questionsList[currentQuestionIndex].question: -1,
        });
        emit(GotUserAnswerResultState(
          isRight: studentAnswerIndex == rightAnswerIndex,
          userAnswerIndex: studentAnswerIndex,
          isAnswersRightList: isUserAnswersRightList,
        ));
      }
    } else {
      skippedAnswers++;
      isUserAnswersRightList.add(false);
      resultsMap.addAll({
        questionsList[currentQuestionIndex].question: 0,
      });
      getNextQuestion();
    }
  }

  void chooseAnswer({required int chosenAnswerIndex}) {
    emit(UserChosenAnswerState(chosenAnswerIndex: chosenAnswerIndex));
  }
}
