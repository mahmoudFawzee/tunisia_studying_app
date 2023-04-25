import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:studying_app/data/firebase_apis/fire_base_materials_api.dart';
import 'package:studying_app/data/firebase_apis/firebase_user_data_api.dart';
import 'package:studying_app/data/models/lesson.dart';
import 'package:studying_app/data/models/user.dart';

part 'materials_event.dart';
part 'materials_state.dart';

class MaterialsBloc extends Bloc<MaterialsEvent, MaterialsState> {
  MaterialsBloc() : super(const MaterialsInitial()) {
    FirebaseMaterialsApi firebaseMaterialsApi = FirebaseMaterialsApi();
    Future<String> getUserStudyingYear() async {
      FirebaseUserDataApi firebaseUserDataApi = FirebaseUserDataApi();
      MyUser data = await firebaseUserDataApi.getData();
      return data.studyingYear;
    }

    Future<String?> getUserBranch() async {
      FirebaseUserDataApi firebaseUserDataApi = FirebaseUserDataApi();
      MyUser data = await firebaseUserDataApi.getData();
      return data.branch;
    }

    on<GetAllMaterialsEvent>((event, emit) async {
      // TODO: implement event handler
      emit(
        const MaterialsLoadingState(),
      );
      try {
        String studyingYear = await getUserStudyingYear();
        String? branch = await getUserBranch();
        List<String> materials = await firebaseMaterialsApi.getAllMaterials(
            studyingYear: studyingYear, branch: branch);
        emit(
          GotAllMaterialsState(
            materials: materials,
            studyingYear: studyingYear,
          ),
        );
      } on FirebaseException catch (e) {
        emit(GetMaterialErrorState(errorMessage: e.code));
        print(e.code);
      } catch (e) {
        emit(GetMaterialErrorState(errorMessage: e.toString()));
      }
    });

    on<GetMaterialBooksEvent>((event, emit) async {
      emit(const MaterialsLoadingState());
      try {
        List<String> books = await firebaseMaterialsApi.getMaterialBooks(
            materialName: event.materialName);
        if (books.isNotEmpty) {
          emit(GotMaterialBooksState(books: books));
        } else {
          emit(const GetMaterialErrorState(errorMessage: 'no thing for now'));
        }
      } on FirebaseException catch (e) {
        emit(GetMaterialErrorState(errorMessage: e.code));
      } catch (e) {
        emit(GetMaterialErrorState(errorMessage: e.toString()));
      }
    });

    on<GetAdvicesEvent>((event, emit) async {
      emit(const MaterialsLoadingState());
      String studyingYear = await getUserStudyingYear();
      String materialName = event.materialName;
    });

    on<GetNotesEvent>((event, emit) async {
      emit(const MaterialsLoadingState());
      String studyingYear = await getUserStudyingYear();
      String materialName = event.materialName;
    });

    on<GetMaterialHomeWorkEvent>((event, emit) async {
      emit(const MaterialsLoadingState());
      try {
        String materialName = event.materialName;
        List<String> homework = await firebaseMaterialsApi.getMaterialHomework(
          materialName: materialName,
          homeworkName: event.homeworkName,
          homeworkSectionName: event.homeworkSectionName,
        );
        if (homework.isNotEmpty) {
          emit(GotMaterialHomeworkState(homework: homework));
        } else {
          emit(const GetMaterialErrorState(errorMessage: 'no thing for now'));
        }
      } on FirebaseException catch (e) {
        emit(GetMaterialErrorState(errorMessage: e.code));
      } catch (e) {
        emit(GetMaterialErrorState(errorMessage: e.toString()));
      }
    });
  }
}
