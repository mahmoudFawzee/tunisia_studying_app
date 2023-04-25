class Question {
  final String question;
  final List<dynamic> answers;
  final int rightAnswerIndex;
  const Question({
    required this.question,
    required this.answers,
    required this.rightAnswerIndex,
  });

  factory Question.fromFirebase(Map<String, dynamic> firebaseObj) {
    final String question = firebaseObj['question'];
    final int rightAnswerIndex = firebaseObj['rightAnswerIndex'];
    final List<dynamic> answers = firebaseObj['answers'];
    return Question(
      question: question,
      answers: answers,
      rightAnswerIndex: rightAnswerIndex,
    );
  }
  @override
  String toString() {
    // TODO: implement toString
    return '{\nquestion : $question \n answers : $answers \n rightAnswers : $rightAnswerIndex \n}';
  }
}
