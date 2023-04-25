// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:studying_app/data/constants/hive_boxes.dart';
import 'package:studying_app/data/models/homework.dart';
import 'package:studying_app/view/resources/strings/strings_manger.dart';

part 'local_homework_state.dart';

class LocalHomeworkCubit extends Cubit<LocalHomeworkState> {
  LocalHomeworkCubit() : super(const LocalHomeworkLoadingState());
  String? _homeworkTitle;
  DateTime? _homeworkDateTime;
  Future<void> openHomeworkBox() async {
    await Hive.openBox<Homework>(homeworkBoxName);
    getMyHomework();
  }

  Box<Homework> _getHomeworkBox() => Hive.box<Homework>(homeworkBoxName);
  Future<List<Homework>> _getAllHomework() async {
    final Box<Homework> homeworkBox = _getHomeworkBox();
    List<Homework> homeworkList = homeworkBox.values.toList().cast<Homework>();
    return homeworkList;
  }

  bool isCompleted({required DateTime dateTime}) {
    DateTime now = DateTime.now();

    //! if dateTime in future it will return -1
    //! if dateTime in past it will return 1
    int result = now.compareTo(dateTime);
    if (result == 1) {
      return true;
    }
    return false;
  }

  Future<List<Homework>> _getCompletedHomework() async {
    List<Homework> homeworkList = await _getAllHomework();
    List<Homework> completedHomework = [];
    for (var homework in homeworkList) {
      if (isCompleted(dateTime: homework.homeworkTime)) {
        completedHomework.add(homework);
      }
    }
    return completedHomework;
  }

  Future<List<Homework>> _getComingHomework() async {
    List<Homework> homeworkList = await _getAllHomework();
    List<Homework> comingHomework = [];
    for (var homework in homeworkList) {
      if (!isCompleted(dateTime: homework.homeworkTime)) {
        comingHomework.add(homework);
      }
    }
    return comingHomework;
  }

  Future addHomework({
    required String name,
    required bool done,
    required DateTime homeworkTime,
  }) async {
    const LocalHomeworkLoadingState();
    try {
      Box<Homework> homeworkBox = _getHomeworkBox();
      Homework newHomework = Homework()
        ..homeworkName = name
        ..homeworkTime = homeworkTime
        ..done = done;
      int newHomeworkIndex = await homeworkBox.add(newHomework);
      Homework? addedHomework = homeworkBox.get(newHomeworkIndex);
      emit(AddedHomeworkState(addedHomework: addedHomework!));
      _clearPreHomeworkData();
      getMyHomework();
    } catch (e) {
      emit(GetHomeworkErrorState(error: e.toString()));
    }
  }

  Future getMyHomework() async {
    const LocalHomeworkLoadingState();
    try {
      List<Homework> homeworkList = await _getAllHomework();

      if (homeworkList.isNotEmpty) {
        emit(GotMyHomeworkState(homeworkList: homeworkList));
      } else {
        emit(const GetHomeworkErrorState(error: StringsManger.noNotification));
      }
    } catch (e) {
      emit(GetHomeworkErrorState(error: e.toString()));
    }
  }

  Future deleteHomework(Homework homeWork) async {
    const LocalHomeworkLoadingState();
    try {
      await homeWork.delete();     
      getMyHomework();
    } catch (e) {
      emit(GetHomeworkErrorState(error: e.toString()));
    }
  }

  void setDateTime(BuildContext context) async {
    DateTime? dateTime = await showDatePicker(      
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(
        hour: 9,
        minute: 0,
      ),
    );
    if (timeOfDay != null && dateTime != null) {
      _homeworkDateTime = DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
        timeOfDay.hour,
        timeOfDay.minute,
      );
      emit(ValidHomeworkDateState(dateTime: _homeworkDateTime!));
      _checkDetails();
    }
  }

  setTitle({required String title}) {
    if (title.isNotEmpty) {
      _homeworkTitle = title;
      _checkDetails();
    }
  }

  void _checkDetails() {
    if (_homeworkTitle != null && _homeworkDateTime != null) {
      emit(
        ValidHomeworkDetailsState(
          title: _homeworkTitle!,
          dateTime: _homeworkDateTime!,
        ),
      );
    } else {
      emit(const InvalidHomeworkDetailsState());
    }
  }

  _clearPreHomeworkData() {
    _homeworkDateTime = null;
    _homeworkTitle = null;
  }

  @override
  Future<void> close() {
    Hive.box(homeworkBoxName).close();
    return super.close();
  }
}
