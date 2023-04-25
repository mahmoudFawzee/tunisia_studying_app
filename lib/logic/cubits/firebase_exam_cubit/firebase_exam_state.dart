part of 'firebase_exam_cubit.dart';

abstract class FirebaseExamState extends Equatable {
  const FirebaseExamState();

  @override
  List<Object?> get props => [];
}

class FirebaseExamLoadingState extends FirebaseExamState {
  const FirebaseExamLoadingState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GotAllExamsState extends FirebaseExamState {
  final List<Exam> exams;
  const GotAllExamsState({required this.exams});
  @override
  // TODO: implement props
  List<Object?> get props => [exams];
}

class GetExamsErrorState extends FirebaseExamState {
  final String error;
  const GetExamsErrorState({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
//************************************************************************************

class ExamAddedState extends FirebaseExamState {
  final Exam addedExam;
  const ExamAddedState({required this.addedExam});
  @override
  // TODO: implement props
  List<Object?> get props => [addedExam];
}

class GotAllMaterialsState extends FirebaseExamState {
  final List<String> materials;
  const GotAllMaterialsState({required this.materials});
  @override
  // TODO: implement props
  List<Object?> get props => [materials];
}

class MaterialSelectedState extends FirebaseExamState {
  final List<String> materials;
  final String selectedMaterial;
  const MaterialSelectedState({
    required this.materials,
    required this.selectedMaterial,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [materials, selectedMaterial];
}

class GotMaterialAllLessonsState extends FirebaseExamState {
  final List<String> allLessons;
  final List<String> selectedLessons;
  const GotMaterialAllLessonsState({
    required this.allLessons,
    required this.selectedLessons,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [allLessons, selectedLessons];
}

class SelectedLessonState extends FirebaseExamState {
  final String lessonName;
  final List<String> selectedLessons;
  const SelectedLessonState({
    required this.lessonName,
    required this.selectedLessons,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        lessonName,
        selectedLessons,
      ];
}

class AddedLessonState extends FirebaseExamState {
  final String lessonName;
  final List<String> selectedLessons;
  const AddedLessonState({
    required this.lessonName,
    required this.selectedLessons,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        lessonName,
        selectedLessons,
      ];
}

class RemovedLessonState extends FirebaseExamState {
  final String lessonName;
  final List<String> selectedLessons;
  const RemovedLessonState({
    required this.lessonName,
    required this.selectedLessons,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
        lessonName,
        selectedLessons,
      ];
}

class GetNoLessonsState extends FirebaseExamState {
  final String string = StringsManger.noThingForNow;
  final List<String> allMaterials;
  final String selectedMaterial;
  const GetNoLessonsState({
    required this.allMaterials,
    required this.selectedMaterial,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [string, allMaterials, selectedMaterial];
}

class LessonsLoadingState extends FirebaseExamState {
  const LessonsLoadingState();
}

class SelectedDateAcceptedState extends FirebaseExamState {
  final String selectedDate;
  final String selectedTime;
  const SelectedDateAcceptedState({
    required this.selectedDate,
    required this.selectedTime,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [selectedDate];
}

class SelectedDateNotAcceptedState extends FirebaseExamState {
  const SelectedDateNotAcceptedState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ValidateExamState extends FirebaseExamState {
  final bool isValidate;
  const ValidateExamState({
    required this.isValidate,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [isValidate];
}

class AddedExamHomeworkState extends FirebaseExamState {
  final List<String> homeworkSelectedSections;
  final String key;
  const AddedExamHomeworkState({required this.homeworkSelectedSections,required this.key,});
  @override
  // TODO: implement props
  List<Object?> get props => [homeworkSelectedSections,key];
}
class RemovedExamHomeworkState extends FirebaseExamState {
  final List<String> homeworkSelectedSections;
  final String key;
  const RemovedExamHomeworkState({required this.homeworkSelectedSections,required this.key,});
  @override
  // TODO: implement props
  List<Object?> get props => [homeworkSelectedSections,key];
}
