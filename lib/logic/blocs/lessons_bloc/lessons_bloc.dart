import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studying_app/data/constants/enums.dart';
import 'package:studying_app/data/models/lesson.dart';
import 'package:studying_app/data/providers/firebase_exam_provider.dart';
import 'package:studying_app/data/providers/lessons_provider.dart';
import 'package:studying_app/view/resources/strings/strings_manger.dart';

part 'lessons_event.dart';
part 'lessons_state.dart';

class LessonsBloc extends Bloc<LessonsEvent, LessonsState> {
  LessonsBloc() : super(const LessonsLoadingState()) {
    final lessonsProvider = LessonsProvider();
    final firebaseExamProvider = FirebaseExamProvider();
    on<GetMaterialLessonEvent>((event, emit) async {
      emit(const LessonsLoadingState());
      try {
        List<Lesson> lessons = await lessonsProvider.getMaterialLessons(
            materialName: event.materialName);
        if (lessons.isNotEmpty) {
          emit(GotMaterialLessonsState(materialLessons: lessons));
        } else {
          emit(const GetMaterialLessonsErrorState(error: 'no thing for now'));
        }
      } on FirebaseException catch (e) {
        emit(GetMaterialLessonsErrorState(error: e.code));
      } catch (e) {
        emit(GetMaterialLessonsErrorState(error: e.toString()));
      }
    });

    on<GetLessonVideoEvent>((event, emit) async {
      emit(const LessonsLoadingState());
      try {
        String id = await lessonsProvider.getLessonVideoId(
          materialName: event.materialName,
          lessonName: event.lessonName,
        );
        if (id.isNotEmpty) {
          emit(GotVideoIdState(videoId: id));
        } else {
          emit(const GetMaterialLessonsErrorState(error: 'no available now'));
        }
      } on FirebaseException catch (e) {
        emit(GetMaterialLessonsErrorState(error: e.code));
      } catch (e) {
        emit(GetMaterialLessonsErrorState(error: e.toString()));
      }
    });

    on<GetLessonSummariesEvent>((event, emit) async {
      emit(const LessonsLoadingState());
      try {
        List<String> lessonMaterialsPdfs =
            await lessonsProvider.getLessonMaterials(
          materialName: event.materialName,
          lessonName: event.lessonName,
          lessonProperty: event.lessonProperty,
        );
        if (lessonMaterialsPdfs.isNotEmpty) {
          emit(GotLessonSummariesState(
              lessonMaterialsPdfs: lessonMaterialsPdfs));
        } else {
          emit(const GetMaterialLessonsErrorState(error: 'no thing for now'));
        }
      } on FirebaseException catch (e) {
        emit(GetMaterialLessonsErrorState(error: e.code));
      } catch (e) {
        emit(GetMaterialLessonsErrorState(error: e.toString()));
      }
    });

    on<GetLessonExercisesEvent>((event, emit) async {
      emit(const LessonsLoadingState());
      try {
        List<String> lessonExercisesPdfs =
            await lessonsProvider.getLessonMaterials(
          materialName: event.materialName,
          lessonName: event.lessonName,
          lessonProperty: event.lessonProperty,
        );
        if (lessonExercisesPdfs.isNotEmpty) {
          emit(
            GotLessonExercisesState(
              lessonExercisesPdfs: lessonExercisesPdfs,
            ),
          );
        } else {
          emit(const GetMaterialLessonsErrorState(error: 'no thing for now'));
        }
      } on FirebaseException catch (e) {
        emit(GetMaterialLessonsErrorState(error: e.code));
      } catch (e) {
        emit(GetMaterialLessonsErrorState(error: e.toString()));
      }
    });

    on<GetExamLessonsEvent>((event, emit) async {
      emit(const LessonsLoadingState());
      try {
        List<Lesson> lessons = await firebaseExamProvider.getExamLesson(
          materialName: event.materialName,
          lessonsNamesList: event.examLessons,
        );
        if (lessons.isEmpty) {
          emit(const GetMaterialLessonsErrorState(
              error: StringsManger.noThingForNow));
        } else {
          emit(GotExamLessonsState(examLessons: lessons));
        }
      } on FirebaseException catch (e) {
        emit(GetMaterialLessonsErrorState(error: e.code));
      } catch (e) {
        emit(GetMaterialLessonsErrorState(error: e.toString()));
      }
    });
  }
}
