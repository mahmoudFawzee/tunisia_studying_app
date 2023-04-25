part of 'lessons_bloc.dart';

abstract class LessonsEvent extends Equatable {
  const LessonsEvent();

  @override
  List<Object> get props => [];
}

class GetMaterialLessonEvent extends LessonsEvent {
  final String materialName;
  const GetMaterialLessonEvent({required this.materialName});
  @override
  // TODO: implement props
  List<Object> get props => [materialName];
}

class GetLessonVideoEvent extends LessonsEvent {
  final String lessonName;
  final String materialName;
  const GetLessonVideoEvent({
    required this.lessonName,
    required this.materialName,
  });
  @override
  // TODO: implement props
  List<Object> get props => [
        lessonName,
        materialName,
      ];
}

class GetLessonSummariesEvent extends LessonsEvent {
  final LessonProperty lessonProperty;
  final String materialName;
  final String lessonName;
  const GetLessonSummariesEvent({
    required this.lessonName,
    required this.materialName,
    required this.lessonProperty,
  });
  @override
  // TODO: implement props
  List<Object> get props => [lessonName, materialName, lessonProperty];
}

class GetLessonExercisesEvent extends LessonsEvent {
  final LessonProperty lessonProperty;
  final String materialName;
  final String lessonName;
  const GetLessonExercisesEvent({
    required this.lessonName,
    required this.materialName,
    required this.lessonProperty,
  });
  @override
  // TODO: implement props
  List<Object> get props => [lessonName, materialName, lessonProperty];
}

class GetExamLessonsEvent extends LessonsEvent {
  final List<dynamic> examLessons;
  final String materialName;
  const GetExamLessonsEvent({
    required this.examLessons,
    required this.materialName,
  });
  @override
  // TODO: implement props
  List<Object> get props => [
        examLessons,
        materialName,
      ];
}
