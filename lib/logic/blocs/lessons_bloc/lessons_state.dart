part of 'lessons_bloc.dart';

abstract class LessonsState extends Equatable {
  const LessonsState();

  @override
  List<Object> get props => [];
}

class LessonsLoadingState extends LessonsState {
  const LessonsLoadingState();
}

class GotMaterialLessonsState extends LessonsState {
  final List<Lesson> materialLessons;
  const GotMaterialLessonsState({required this.materialLessons});
  @override
  // TODO: implement props
  List<Object> get props => [materialLessons];
}

class GotVideoIdState extends LessonsState {
  final String videoId;
  const GotVideoIdState({
    required this.videoId,
  });
  @override
  // TODO: implement props
  List<Object> get props => [videoId];
}

class GetMaterialLessonsErrorState extends LessonsState {
  final String error;
  const GetMaterialLessonsErrorState({required this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];
}

class GotLessonSummariesState extends LessonsState {
  final List<String> lessonMaterialsPdfs;
  const GotLessonSummariesState({
    required this.lessonMaterialsPdfs,
  });
  @override
  // TODO: implement props
  List<Object> get props => [lessonMaterialsPdfs];
}

class GotLessonExercisesState extends LessonsState {
  final List<String> lessonExercisesPdfs;
  const GotLessonExercisesState({
    required this.lessonExercisesPdfs,
  });
  @override
  // TODO: implement props
  List<Object> get props => [lessonExercisesPdfs];
}

class GotExamLessonsState extends LessonsState {
  final List<Lesson> examLessons;
  const GotExamLessonsState({
    required this.examLessons,
  });
  @override
  // TODO: implement props
  List<Object> get props => [examLessons];
}
