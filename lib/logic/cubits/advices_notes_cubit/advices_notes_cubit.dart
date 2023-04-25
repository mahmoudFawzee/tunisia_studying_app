import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:studying_app/data/providers/advices_and_notes_provider.dart';

part 'advices_notes_state.dart';

class AdvicesNotesCubit extends Cubit<AdvicesNotesState> {
  AdvicesNotesCubit() : super(const AdvicesNotesLoadingState());
  final _advicesAndNotesProvider = AdvicesAndNotesProvider();
  Future<void> getAdvices({required String materialName}) async {
    emit(const AdvicesNotesLoadingState());
    try {
      final advices = await _advicesAndNotesProvider.getStudyingAdvices(
          materialName: materialName);
      if (advices.isNotEmpty) {
        emit(GotAdvicesState(advices: advices));
      } else {
        emit(const GetAdvicesNotesErrorState(error: 'no thing for now'));
      }
    } on FirebaseException catch (e) {
      emit(GetAdvicesNotesErrorState(error: e.code));
    } catch (e) {
      emit(GetAdvicesNotesErrorState(error: e.toString()));
    }
  }

  Future<void> getNotes({required String materialName}) async {
    emit(const AdvicesNotesLoadingState());
    try {
      final notes = await _advicesAndNotesProvider.getMaterialNotes(
          materialName: materialName);
      if (notes.isNotEmpty) {
        emit(GotAdvicesState(advices: notes));
      } else {
        emit(const GetAdvicesNotesErrorState(error: 'no thing for now'));
      }
    } on FirebaseException catch (e) {
      emit(GetAdvicesNotesErrorState(error: e.code));
    } catch (e) {
      emit(GetAdvicesNotesErrorState(error: e.toString()));
    }
  }
}
