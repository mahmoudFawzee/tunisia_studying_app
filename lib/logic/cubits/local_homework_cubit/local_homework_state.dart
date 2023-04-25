part of 'local_homework_cubit.dart';

abstract class LocalHomeworkState extends Equatable {
  const LocalHomeworkState();

  @override
  List<Object> get props => [];
}

class LocalHomeworkLoadingState extends LocalHomeworkState {
  const LocalHomeworkLoadingState();
}

class DeletedHomeworkState extends LocalHomeworkState {
  final List<Homework> homeworkList;
  const DeletedHomeworkState({required this.homeworkList});
  @override
  List<Object> get props => [homeworkList];
}

class AddedHomeworkState extends LocalHomeworkState {
  final Homework addedHomework;
  const AddedHomeworkState({required this.addedHomework});
  @override
  List<Object> get props => [addedHomework];
}

class GotMyHomeworkState extends LocalHomeworkState {
  final List<Homework> homeworkList;
  const GotMyHomeworkState({required this.homeworkList});
  @override
  List<Object> get props => [homeworkList];
}

class GetHomeworkErrorState extends LocalHomeworkState {
  final String error;
  const GetHomeworkErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class ValidHomeworkDateState extends LocalHomeworkState {
  final DateTime dateTime;
  const ValidHomeworkDateState({
    required this.dateTime,
  });
  @override
  // TODO: implement props
  List<Object> get props => [
        dateTime,
      ];
}

class ValidHomeworkDetailsState extends LocalHomeworkState {
  final DateTime dateTime;
  final String title;
  const ValidHomeworkDetailsState({
    required this.dateTime,
    required this.title,
  });
  @override
  // TODO: implement props
  List<Object> get props => [
        dateTime,
        title,
      ];
}

class InvalidHomeworkDetailsState extends LocalHomeworkState {
  const InvalidHomeworkDetailsState();
}
