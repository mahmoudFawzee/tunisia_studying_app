// ignore_for_file: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:studying_app/data/firebase_apis/firebase_user_data_api.dart';
import 'package:studying_app/data/constants/enums.dart';
import 'dart:io';

import '../models/user.dart';

class PdfProvider {
  final firebaseUserDataApi = FirebaseUserDataApi();
  // Future<File> loadNetworkPdf({
  //   required String pdfUrl,
  //   required String pdfName,
  // }) async {
  //   final url = Uri.parse(pdfUrl);
  //   final response = await http.get(url);
  //   final bytes = response.bodyBytes;
  //   return _storeFile(url: pdfUrl, pdfName: pdfName, bytes: bytes);
  // }

  Future<File> _storeFile({
    required String url,
    required List<int> bytes,
    required String pdfName,
    required String materialName,
    LessonProperty? lessonProperty,
    String? lessonName,
    String? homeworkName,
    String? homeworkSectionName,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    File file;
    if (lessonName == null) {
      if (homeworkName != null) {
        final newDir = await Directory(
                '${dir.path}/$materialName/$homeworkName/$homeworkSectionName')
            .create(recursive: true);
        file = File('${newDir.path}/$pdfName');
      } else {
        final newDir = await Directory('${dir.path}/$materialName')
            .create(recursive: true);
        file = File('${newDir.path}/$pdfName');
      }
    } else {
      //? here we will create a folder to store our pdfs
      //? for the answers we will store the pdf in answers folder we will create
      //?and its name will be the firebase exercise name
      String stringLessonProperty = lessonProperties[lessonProperty]!;
      print('lesson property : $stringLessonProperty');
      final newDir =
          await Directory('${dir.path}/$materialName/$stringLessonProperty')
              .create(
        recursive: true,
      );
      pdfName = '$pdfName.pdf';
      file = File('${newDir.path}/$pdfName');
    }
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<File?> _getEducationMaterialPdf({
    required String materialName,
    required String pdfName,
  }) async {
    final MyUser userData = await firebaseUserDataApi.getData();
    String pdfUrl = '/${userData.studyingYear}/$materialName/$pdfName';
    print(pdfUrl);
    final pdfRef = FirebaseStorage.instance.ref().child(pdfUrl);
    final bytes = await pdfRef.getData();
    return _storeFile(
        url: pdfUrl,
        bytes: bytes!,
        pdfName: pdfName,
        materialName: materialName);
  }

  Future<File?> _getMaterialHomeworkPdf({
    required String materialName,
    required String homeworkName,
    required String homeworkSectionName,
    required String pdfName,
  }) async {
    final MyUser userData = await firebaseUserDataApi.getData();
    final pdfUrl =
        '/${userData.studyingYear}/$materialName/homework/$homeworkName/$homeworkSectionName/$pdfName';
    print(pdfUrl);

    final pdfRef = FirebaseStorage.instance.ref().child(pdfUrl);
    final bytes = await pdfRef.getData();
    return _storeFile(
      url: pdfUrl,
      pdfName: pdfName,
      bytes: bytes!,
      materialName: materialName,
      homeworkName: homeworkName,
      homeworkSectionName: homeworkSectionName,
    );
  }

  Future<File?> _getLessonSummaries({
    required String materialName,
    required String pdfName,
    required String lessonName,
    required LessonProperty lessonProperty,
  }) async {
    final MyUser userData = await firebaseUserDataApi.getData();
    String lessonPropertyString = lessonProperties[lessonProperty]!;
    String pdfUrl =
        '/${userData.studyingYear}/$materialName/lessons/$lessonName/$lessonPropertyString/$pdfName';
    print(pdfUrl);
    final pdfRef = FirebaseStorage.instance.ref().child(pdfUrl);
    final bytes = await pdfRef.getData();
    //print('pdf ref = ${pdfRef.items.length}');
    return _storeFile(
      url: pdfUrl,
      pdfName: pdfName,
      bytes: bytes!,
      materialName: materialName,
      lessonName: lessonName,
      lessonProperty: lessonProperty,
    );
  }

  Future<File?> _getLessonExercise({
    required String materialName,
    required String pdfName,
    required String lessonName,
    required LessonProperty lessonProperty,
  }) async {
    final MyUser userData = await firebaseUserDataApi.getData();
    String lessonPropertyString = lessonProperties[lessonProperty]!;
    String pdfUrl =
        '/${userData.studyingYear}/$materialName/lessons/$lessonName/$lessonPropertyString/$pdfName/exercise';
    print(pdfUrl);
    final pdfRef = await FirebaseStorage.instance.ref().child(pdfUrl).listAll();
    final bytes = await pdfRef.items.first.getData();
    print('pdf ref = ${pdfRef.items.length}');
    return _storeFile(
      url: pdfUrl,
      pdfName: pdfName,
      bytes: bytes!,
      materialName: materialName,
      lessonName: lessonName,
      lessonProperty: lessonProperty,
    );
  }

  Future<File?> _getLessonExerciseAnswer({
    required String materialName,
    required String pdfName,
    required String lessonName,
    required LessonProperty lessonProperty,
  }) async {
    final MyUser userData = await firebaseUserDataApi.getData();
    //!this to get the location of the file in the firebase
    //!and we stored the file in the exercises sub folder
    //!with the exercise itself
    String firebaseDirectoryName = lessonProperties[LessonProperty.exercises]!;
    String pdfUrl =
        '/${userData.studyingYear}/$materialName/lessons/$lessonName/$firebaseDirectoryName/$pdfName/answer';
    print(pdfUrl);
    final pdfRef = await FirebaseStorage.instance.ref().child(pdfUrl).listAll();
    final bytes = await pdfRef.items.first.getData();
    return _storeFile(
      url: pdfUrl,
      pdfName: pdfName,
      bytes: bytes!,
      materialName: materialName,
      lessonName: lessonName,
      lessonProperty: lessonProperty,
    );
  }

  Future<File?> _loadFirebasePdf({
    required String materialName,
    required String pdfName,
    String? lessonName,
    LessonProperty? lessonProperty,
    String? homeworkName,
    String? homeworkSectionName,
  }) async {
    //!pdfUrl is the location of the file in the storage.
    if (lessonName != null) {
      //!if property is exercise we will will change the pdf url to
      //? '/${userData.studyingYear}/$materialName/lessons/$lessonName/$lessonPropertyString/$pdfName/exercise/file.pdf';

      if (lessonProperty == LessonProperty.exercises) {
        File? exercise = await _getLessonExercise(
          materialName: materialName,
          pdfName: pdfName,
          lessonName: lessonName,
          lessonProperty: lessonProperty!,
        );
        return exercise;
      } else if (lessonProperty == LessonProperty.answers) {
        File? exeAnswer = await _getLessonExerciseAnswer(
          materialName: materialName,
          pdfName: pdfName,
          lessonName: lessonName,
          lessonProperty: LessonProperty.answers,
        );
        return exeAnswer;
      } else {
        File? summary = await _getLessonSummaries(
          materialName: materialName,
          pdfName: pdfName,
          lessonName: lessonName,
          lessonProperty: lessonProperty!,
        );
        return summary;
      }
    } else {
      if (homeworkName != null) {
        File? homeworkPdf = await _getMaterialHomeworkPdf(
          materialName: materialName,
          homeworkName: homeworkName,
          homeworkSectionName: homeworkSectionName!,
          pdfName: pdfName,
        );
        return homeworkPdf;
      } else {
        File? educationMaterialPdf = await _getEducationMaterialPdf(
          materialName: materialName,
          pdfName: pdfName,
        );
        return educationMaterialPdf;
      }
    }
  }

  Future<File?> _openFilePdf({
    required String pdfName,
    required String materialName,
    String? lessonName,
    LessonProperty? lessonProperty,
    String? homeworkName,
    String? homeworkSectionName,
  }) async {
    String path;
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    if (lessonName == null) {
      if (homeworkName != null) {
        final newDir = Directory(
          '${appDirectory.path}/$materialName/$homeworkName/$homeworkSectionName',
        );
        path = "${newDir.path}/$pdfName";
      } else {
        final newDir = Directory('${appDirectory.path}/$materialName');
        path = "${newDir.path}/$pdfName";
      }
    } else {
      String stringLessonProperty = lessonProperties[lessonProperty!]!;
      final newDir = Directory(
        '${appDirectory.path}/$materialName/$stringLessonProperty',
      );
      pdfName = '$pdfName.pdf';
      path = "${newDir.path}/$pdfName";
    }

    //final path = '${appDirectory.path}/$pdfName';
    return File(path);
  }

  Future<bool> _pdfExists({
    required String pdfName,
    required String materialName,
    String? lessonName,
    LessonProperty? lessonProperty,
    String? homeworkName,
    String? homeworkSectionName,
  }) async {
    //app directory in the phone storage.
    final Directory appDirectory = await getApplicationDocumentsDirectory();
    String path;
    if (lessonName == null) {
      if (homeworkName != null) {
        final newDir = Directory(
          '${appDirectory.path}/$materialName/$homeworkName/$homeworkSectionName',
        );
        path = "${newDir.path}/$pdfName";
      } else {
        final newDir = Directory('${appDirectory.path}/$materialName');
        path = "${newDir.path}/$pdfName";
      }
    } else {
      String stringLessonProperty = lessonProperties[lessonProperty!]!;
      final newDir = Directory(
        '${appDirectory.path}/$materialName/$stringLessonProperty',
      );
      pdfName = '$pdfName.pdf';
      path = "${newDir.path}/$pdfName";
    }

    bool exists = await File(path).exists();
    return exists;
  }

  Future<File?> openPdf({
    required String pdfName,
    required String materialName,
    String? lessonName,
    LessonProperty? lessonProperty,
    String? homeworkName,
    String? homeworkSectionName,
  }) async {
    bool exist = await _pdfExists(
      pdfName: pdfName,
      materialName: materialName,
      lessonName: lessonName,
      lessonProperty: lessonProperty,
      homeworkName: homeworkName,
      homeworkSectionName: homeworkSectionName,
    );
    print('pdf existence : $exist');
    print('pdf name $pdfName');
    if (exist) {
      File? filePdf = await _openFilePdf(
        pdfName: pdfName,
        materialName: materialName,
        lessonName: lessonName,
        lessonProperty: lessonProperty,
        homeworkName: homeworkName,
        homeworkSectionName: homeworkSectionName,
      );
      return filePdf;
    } else {
      File? firebasePdf = await _loadFirebasePdf(
        materialName: materialName,
        pdfName: pdfName,
        lessonName: lessonName,
        lessonProperty: lessonProperty,
        homeworkName: homeworkName,
        homeworkSectionName: homeworkSectionName,
      );
      return firebasePdf;
    }
  }
}