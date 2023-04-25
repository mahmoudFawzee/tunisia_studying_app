part of 'advices_notes_cubit.dart';

abstract class AdvicesNotesState extends Equatable {
  const AdvicesNotesState();

  @override
  List<Object> get props => [];
}

class AdvicesNotesLoadingState extends AdvicesNotesState {
  const AdvicesNotesLoadingState();
}

class GotAdvicesState extends AdvicesNotesState {
  final List<dynamic> advices;
  const GotAdvicesState({required this.advices});
  @override
  // TODO: implement props
  List<Object> get props => [advices];
}

class GotNotesState extends AdvicesNotesState {
  final List<dynamic> notes;
  const GotNotesState({required this.notes});
  @override
  // TODO: implement props
  List<Object> get props => [notes];
}

class GetAdvicesNotesErrorState extends AdvicesNotesState {
  final String error;
  const GetAdvicesNotesErrorState({required this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
