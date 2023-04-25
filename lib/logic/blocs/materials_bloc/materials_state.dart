part of 'materials_bloc.dart';

abstract class MaterialsState extends Equatable {
  const MaterialsState();

  @override
  List<Object> get props => [];
}

class MaterialsInitial extends MaterialsState {
  const MaterialsInitial();
}

class MaterialsLoadingState extends MaterialsState {
  const MaterialsLoadingState();
  @override
  List<Object> get props => [];
}

class GotAllMaterialsState extends MaterialsState {
  final List<String> materials;
  final String studyingYear;
  const GotAllMaterialsState({
    required this.materials,
    required this.studyingYear,
  });
  @override
  List<Object> get props => [
        materials,
        studyingYear,
      ];
}

class GotMaterialLessonsState extends MaterialsState {
  final List<Lesson> materialLessons;
  const GotMaterialLessonsState({required this.materialLessons});
  @override
  List<Object> get props => [materialLessons];
}

class GotMaterialNotesState extends MaterialsState {
  final List<String> notes;
  const GotMaterialNotesState({
    required this.notes,
  });
  @override
  List<Object> get props => [notes];
}

class GotMaterialAdvicesState extends MaterialsState {
  final List<String> advices;
  const GotMaterialAdvicesState({
    required this.advices,
  });
  @override
  List<Object> get props => [advices];
}

class GotMaterialBooksState extends MaterialsState {
  final List<String> books;
  const GotMaterialBooksState({
    required this.books,
  });
  @override
  List<Object> get props => [books];
}

class GotMaterialHomeworkState extends MaterialsState {
  final List<String> homework;
  const GotMaterialHomeworkState({
    required this.homework,
  });
  @override
  List<Object> get props => [homework];
}

class GetMaterialErrorState extends MaterialsState {
  final String errorMessage;
  const GetMaterialErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
