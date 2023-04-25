part of 'firebase_exam_bloc.dart';

abstract class FirebaseExamEvent extends Equatable {
  const FirebaseExamEvent();

  @override
  List<Object> get props => [];
}

class ChooseSpecificExamSectionEvent extends FirebaseExamEvent {
  final String section;
  const ChooseSpecificExamSectionEvent({required this.section});
  @override
  // TODO: implement props
  List<Object> get props => [section];
}

class GetExamAdvicesEvent extends FirebaseExamEvent {
  final String materialName;
  const GetExamAdvicesEvent({required this.materialName});
  @override
  // TODO: implement props
  List<Object> get props => [materialName];
}

class GetExamLessonsEvent extends FirebaseExamEvent {
  final String materialName;
  final List<dynamic> lessonsNamesList;
  const GetExamLessonsEvent({
    required this.materialName,
    required this.lessonsNamesList,
  });
  @override
  // TODO: implement props
  List<Object> get props => [materialName, lessonsNamesList];
}

class GetExamHomeworkEvent extends FirebaseExamEvent {
  final String examName;
  const GetExamHomeworkEvent({required this.examName});
  @override
  // TODO: implement props
  List<Object> get props => [examName];
}
