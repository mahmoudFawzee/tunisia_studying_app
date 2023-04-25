import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studying_app/data/models/lesson.dart';
import 'package:studying_app/data/providers/firebase_exam_provider.dart';

part 'firebase_exam_event.dart';
part 'firebase_exam_state.dart';

class FirebaseExamContentBloc
    extends Bloc<FirebaseExamEvent, FirebaseExamContentState> {
  FirebaseExamContentBloc() : super(const FirebaseExamContentLoadingState()) {
    final firebaseExamProvider = FirebaseExamProvider();

    on<ChooseSpecificExamSectionEvent>((event, emit) {
      // TODO: implement event handler
      emit(ChosenExamSpecificSectionState(section: event.section));
    });

    on<GetExamAdvicesEvent>((event, emit) async {
      emit(const FirebaseExamContentLoadingState());
      try {
        List<dynamic> notesList = await firebaseExamProvider.getExamNotes(
            materialName: event.materialName);
        emit(GotFirebaseExamAdvicesState(advicesList: notesList));
      } on FirebaseException catch (e) {
        emit(GotFirebaseExamErrorState(error: e.code));
      } catch (e) {
        emit(GotFirebaseExamErrorState(error: e.toString()));
      }
    });
   
    on<GetExamLessonsEvent>((event, emit) async {
      emit(const FirebaseExamContentLoadingState());
      try {
        List<Lesson> lessonsList = await firebaseExamProvider.getExamLesson(
            materialName: event.materialName,
            lessonsNamesList: event.lessonsNamesList);
        emit(GotFirebaseExamLessonsState(lessonsList: lessonsList));
      } on FirebaseException catch (e) {
        emit(GotFirebaseExamErrorState(error: e.code));
      } catch (e) {
        emit(GotFirebaseExamErrorState(error: e.toString()));
      }
    });

    on<GetExamHomeworkEvent>((event, emit) async {
      emit(const FirebaseExamContentLoadingState());
      try {
        Map<String,dynamic> homeworkMap =
            await firebaseExamProvider.getExamHomeworkMap(
          examName: event.examName,
        );
        emit(GotFirebaseHomeworkState(homeworkMap: homeworkMap));
      } on FirebaseException catch (e) {
        emit(GotFirebaseExamErrorState(error: e.code));
      } catch (e) {
        emit(GotFirebaseExamErrorState(error: e.toString()));
      }
    });
  }
}
