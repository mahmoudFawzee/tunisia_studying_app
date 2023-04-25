part of 'firebase_exam_bloc.dart';

abstract class FirebaseExamContentState extends Equatable {
  const FirebaseExamContentState();

  @override
  List<Object> get props => [];
}

class FirebaseExamContentLoadingState extends FirebaseExamContentState {
  const FirebaseExamContentLoadingState();
}

class ChosenExamSpecificSectionState extends FirebaseExamContentState {
  final String section;
  const ChosenExamSpecificSectionState({required this.section});
  @override
  // TODO: implement props
  List<Object> get props => [section];
}

class GotFirebaseExamLessonsState extends FirebaseExamContentState {
  final List<Lesson> lessonsList;
  const GotFirebaseExamLessonsState({
    required this.lessonsList,
  });
  @override
  // TODO: implement props
  List<Object> get props => [lessonsList];
}

class GotFirebaseExamAdvicesState extends FirebaseExamContentState {
  final List<dynamic> advicesList;
  const GotFirebaseExamAdvicesState({
    required this.advicesList,
  });
  @override
  // TODO: implement props
  List<Object> get props => [advicesList];
}

class GotFirebaseHomeworkState extends FirebaseExamContentState {
  final Map<String,dynamic> homeworkMap;
  const GotFirebaseHomeworkState({
    required this.homeworkMap,
  });
  @override
  // TODO: implement props
  List<Object> get props => [homeworkMap];
}

class GotFirebaseExamErrorState extends FirebaseExamContentState {
  final String error;
  const GotFirebaseExamErrorState({
    required this.error,
  });
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
