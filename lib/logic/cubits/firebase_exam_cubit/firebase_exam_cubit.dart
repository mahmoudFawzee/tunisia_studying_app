import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:studying_app/data/constants/application_lists.dart';
import 'package:studying_app/data/firebase_apis/fire_base_materials_api.dart';
import 'package:studying_app/data/firebase_apis/firebase_user_data_api.dart';
import 'package:studying_app/data/models/exam.dart';
import 'package:studying_app/data/models/lesson.dart';
import 'package:studying_app/data/models/user.dart';
import 'package:studying_app/data/providers/lessons_provider.dart';
import 'package:studying_app/view/resources/strings/strings_manger.dart';

part 'firebase_exam_state.dart';

class FirebaseExamCubit extends Cubit<FirebaseExamState> {
  FirebaseExamCubit() : super(const FirebaseExamLoadingState());
  final _lessonsProvider = LessonsProvider();
  final _userDataApi = FirebaseUserDataApi();
  final _firebaseMaterialsApi = FirebaseMaterialsApi();
  DateTime? _examDate;
  String? _examTitle;
  String? _selectedMaterial;
  List<String> _allMaterials = [];
  final List<String> _allLessons = [];
  final List<String> _selectedLessons = [];
  //?this will be the map of saving the
  //?chosen homework as
  //? key : homework name
  //?value : homework sections
  final Map<String, List<String>> _connectedHomeworkMap = {};
  void clearLastExamData() {
    _examDate = null;
    _examTitle = null;
    _selectedMaterial = null;
    _allLessons.clear();
    _selectedLessons.clear();
    _allMaterials.clear();
    _connectedHomeworkMap.clear();
  }

  addExamHomework({
    required String key,
    required String value,
  }) {
    if (_connectedHomeworkMap.containsKey(key)) {
      if (!_connectedHomeworkMap[key]!.contains(value)) {
        _connectedHomeworkMap[key]!.add(value);
      }
    } else {
      Map<String, List<String>> newHomework = {
        key: [value]
      };
      _connectedHomeworkMap.addAll(newHomework);
    }
    emit(
      AddedExamHomeworkState(
        homeworkSelectedSections: _connectedHomeworkMap[key]!,
        key: key,
      ),
    );
    print(_connectedHomeworkMap);
  }

  removeHomework({required String key, required String value}) {
    if (_connectedHomeworkMap.containsKey(key)) {
      _connectedHomeworkMap[key]!.remove(value);
      emit(
        RemovedExamHomeworkState(
          homeworkSelectedSections: _connectedHomeworkMap[key]!,
          key: key,
        ),
      );
      print(_connectedHomeworkMap);
    }
  }

//todo call this only when you about to push the homework to the firestore
  _removeEmptyHomeworkFromMap() {
    for (var homework in homeworkList) {
      _removeEmptyItems(homework: homework);
    }
  }

  _removeEmptyItems({required String homework}) {
    if (!_connectedHomeworkMap.keys.contains(homework)) {
      return;
    }
    if (_connectedHomeworkMap[homework]!.isNotEmpty) {
      return;
    }
    _connectedHomeworkMap.remove(homework);
  }

  Future<List<Exam>> _getCompletedExams() async {
    MyUser userDate = await _userDataApi.getData();
    List<Exam> exams =
        await _userDataApi.getUserExams(userEmail: userDate.email);
    List<Exam> completedHomework = [];
    for (var exam in exams) {
      if (_isCompleted(dateTime: exam.examDate)) {
        completedHomework.add(exam);
      }
    }
    return completedHomework;
  }

  bool _isCompleted({required DateTime dateTime}) {
    DateTime now = DateTime.now();

    //! if dateTime in future it will return -1
    //! if dateTime in past it will return 1
    int result = now.compareTo(dateTime);
    if (result == 1) {
      return true;
    }
    return false;
  }

  //todo : create a method to get all user saved exams
  void getAllExams({
    required bool isCompleted,
  }) async {
    emit(const FirebaseExamLoadingState());
    try {
      if (isCompleted) {
        List<Exam> completedExams = await _getCompletedExams();
        emit(GotAllExamsState(exams: completedExams));
      } else {}
      MyUser userDate = await _userDataApi.getData();

      List<Exam> exams =
          await _userDataApi.getUserExams(userEmail: userDate.email);
      print('exams : ${exams.length}');
      if (exams.isNotEmpty) {
        //todo emit the state of got exams
        emit(GotAllExamsState(exams: exams));
      } else {
        //todo emit the state of error when getting exams
        //todo stringManger.notingFonNow
        emit(const GetExamsErrorState(error: StringsManger.noThingForNow));
      }
    } on FirebaseException catch (e) {
      emit(GetExamsErrorState(error: e.code));
    } catch (e) {
      if (e.toString() == 'Bad state: No element') {
        emit(const GetExamsErrorState(error: StringsManger.noThingForNow));
      } else {
        emit(GetExamsErrorState(error: e.toString()));
      }
    }
  }

  void addExam() async {
    emit(const FirebaseExamLoadingState());
    try {
      MyUser userDate = await _userDataApi.getData();
      Exam exam = Exam(
        examDate: _examDate!,
        examName: _examTitle!,
        lessons: _selectedLessons,
        materialName: _selectedMaterial!,
        examConnectedHomework: _connectedHomeworkMap,
      );

      List<Exam> exams = await _userDataApi.addExam(
        userEmail: userDate.email,
        exam: exam,
      );
      emit(ExamAddedState(addedExam: exam));
      clearLastExamData();
      emit(GotAllExamsState(exams: exams));
    } on FirebaseException catch (e) {
      emit(GetExamsErrorState(error: e.code));
    } catch (e) {
      emit(GetExamsErrorState(error: e.toString()));
    }
  }

  void deleteExam({
    required String examName,
  }) async {
    try {
      MyUser user = await _userDataApi.getData();
      _userDataApi.deleteExam(examName: examName, userEmail: user.email);
      getAllExams(isCompleted: false);
    } on FirebaseException catch (e) {
      print(e.code);
    } catch (e) {
      e.toString();
    }
  }

  void getUserMaterials() async {
    try {
      MyUser userDate = await _userDataApi.getData();
      await _firebaseMaterialsApi
          .getAllMaterials(
            studyingYear: userDate.studyingYear,
            branch: userDate.branch,
          )
          .then((value) => _allMaterials = value);
      //todo : emit the state of Got the materials
      emit(GotAllMaterialsState(materials: _allMaterials));
    } on FirebaseException catch (e) {
      emit(GetExamsErrorState(error: e.code));
    } catch (e) {
      emit(GetExamsErrorState(error: e.toString()));
    }
  }

  //!we will use it to get the material lessons to let user choose from them
  //we will call it when the user select a material
  void getMaterialLessons({required String materialName}) async {
    emit(const LessonsLoadingState());
    try {
      _allLessons.clear();
      _selectedMaterial = materialName;
      _selectedLessons.clear();
      List<Lesson> lessons = await _lessonsProvider.getMaterialLessons(
        materialName: materialName,
      );
      for (var lesson in lessons) {
        _allLessons.add(lesson.name);
      }
      if (lessons.isNotEmpty) {
        emit(
          GotMaterialAllLessonsState(
            allLessons: _allLessons,
            selectedLessons: _selectedLessons,
          ),
        );
      } else {
        emit(
          GetNoLessonsState(
            allMaterials: _allMaterials,
            selectedMaterial: materialName,
          ),
        );
      }
      emit(
        MaterialSelectedState(
          materials: _allMaterials,
          selectedMaterial: _selectedMaterial!,
        ),
      );
    } on FirebaseException catch (e) {
      emit(GetExamsErrorState(error: e.code));
    } catch (e) {
      emit(GetExamsErrorState(error: e.toString()));
    }
  }

  void addLesson({required lessonName}) {
    _selectedLessons.add(lessonName);
    emit(
      AddedLessonState(
        lessonName: lessonName,
        selectedLessons: _selectedLessons,
      ),
    );
  }

  void removeLesson({required lessonName}) {
    _selectedLessons.remove(lessonName);
    emit(
      RemovedLessonState(
        lessonName: lessonName,
        selectedLessons: _selectedLessons,
      ),
    );
  }

  void setExamDate(BuildContext context) async {
    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      //* last date will be after 10 years...
      lastDate: DateTime(DateTime.now().year + 10),
    );

    TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (dateTime == null || timeOfDay == null) {
      //todo emit the state of no date selected
      emit(const SelectedDateNotAcceptedState());
    } else {
      _examDate = DateTime(
        dateTime.year,
        dateTime.month,
        dateTime.day,
        timeOfDay.hour,
        timeOfDay.minute,
      );
      String stringDate =
          '${_examDate!.year}-${_examDate!.month}-${_examDate!.day}';
      String stringTime = '${_examDate!.hour}:${_examDate!.minute}';
      //todo emit the state of date selected, and emit date with it.

      emit(SelectedDateAcceptedState(
        selectedDate: stringDate,
        selectedTime: stringTime,
      ));
      print(_examDate);
    }
  }

  void checkExamTitle({required String title}) {
    if (title.isNotEmpty) {
      _examTitle = title;
    } else {
      _examTitle = null;
    }
  }

  _mySnackBar(
    BuildContext context, {
    required String error,
  }) {
    emit(const ValidateExamState(isValidate: false));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        error,
      ),
    ));
  }

  void validateNewExamData(BuildContext context) {
    if (_examTitle == null || _examTitle!.isEmpty) {
      _mySnackBar(context, error: StringsManger.emptyTitle);
    } else if (_examDate == null) {
      _mySnackBar(context, error: StringsManger.dateNotAccepted);
    } else if (_selectedMaterial == null) {
      _mySnackBar(context, error: StringsManger.chooseAMaterial);
    } else if (_selectedLessons.isEmpty) {
      _mySnackBar(context, error: StringsManger.chooseLesson);
    } else if (_connectedHomeworkMap.isEmpty) {
      _mySnackBar(context, error: StringsManger.chooseHomework);
    } else {
      _removeEmptyHomeworkFromMap();
      emit(const ValidateExamState(isValidate: true));
    }
  }
}
