part of 'materials_bloc.dart';

abstract class MaterialsEvent extends Equatable {
  const MaterialsEvent();

  @override
  List<Object> get props => [];
}

class GetAllMaterialsEvent extends MaterialsEvent {
  const GetAllMaterialsEvent();
  @override
  List<Object> get props => [];
}

class GetMaterialLessonsEvent extends MaterialsEvent {
  final String materialName;
  //todo: if the request for branch material we will the path of the studying year and branch
  //todo: if not we will get the request using the material study and common material
  const GetMaterialLessonsEvent({
    required this.materialName,
  });
  @override
  List<Object> get props => [
        materialName,
      ];
}

class GetAdvicesEvent extends MaterialsEvent {
  final String materialName;
  const GetAdvicesEvent({
    required this.materialName,
  });
  @override
  List<Object> get props => [
        materialName,
      ];
}

class GetNotesEvent extends MaterialsEvent {
  final String materialName;
  const GetNotesEvent({required this.materialName});
  @override
  List<Object> get props => [
        materialName,
      ];
}

class GetMaterialBooksEvent extends MaterialsEvent {
  final String materialName;
  const GetMaterialBooksEvent({
    required this.materialName,
  });
  @override
  List<Object> get props => [
        materialName,
      ];
}

class GetMaterialHomeWorkEvent extends MaterialsEvent {
  final String materialName;
  final String homeworkName;
  final String homeworkSectionName;

  const GetMaterialHomeWorkEvent({
    required this.materialName,
    required this.homeworkName,
    required this.homeworkSectionName,
  });
  @override
  List<Object> get props => [
        materialName,
        homeworkName,
        homeworkSectionName,
      ];
}
