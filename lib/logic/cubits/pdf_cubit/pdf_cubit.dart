// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:studying_app/data/providers/pdf_provider.dart';

import '../../../data/constants/enums.dart';

part 'pdf_state.dart';

class PdfCubit extends Cubit<PdfState> {
  PdfCubit() : super(const PdfLoadingState());
  final pdfProvider = PdfProvider();

  Future<void> getPdf({
    required String materialName,
    required String pdfName,
    String? lessonName,
    LessonProperty? lessonProperty,
    String? homeworkName,
    String? homeworkSectionName,
  }) async {
    emit(const PdfLoadingState());
    try {
      File? pdf = await pdfProvider.openPdf(
        materialName: materialName,
        pdfName: pdfName,
        lessonName: lessonName,
        lessonProperty: lessonProperty,
        homeworkName: homeworkName,
        homeworkSectionName: homeworkSectionName,
      );

      if (pdf != null) {
        emit(GotPdfState(pdf: pdf, lessonProperty: lessonProperty));
      } else {
        emit(const GetPdfErrorState(error: 'no pdf available'));
      }
    } on FirebaseException catch (e) {
      emit(GetPdfErrorState(error: e.code));
    } catch (e) {
      if (e.toString() == 'Bad state: No element') {
        emit(
          const GetPdfErrorState(
            error: 'no pdf available',
          ),
        );
      } else {
        emit(GetPdfErrorState(error: e.toString()));
      }
    }
  }

//   Future<void> getMaterialPdfs({required materialName}) async {
//     emit(const PdfLoadingState());
//     try {
//       List<String> materialPdfsNames =
//           await pdfProvider.getMaterialBooks(materialName: materialName);
//       if (materialPdfsNames.isEmpty) {
//         emit(const GetPdfErrorState(error: 'no thing for now'));
//       } else {
//         emit(GotAllPdfsState(pdfsNames: materialPdfsNames));
//       }
//     } on FirebaseException catch (e) {
//       emit(GetPdfErrorState(error: e.code));
//     } catch (e) {
//       emit(GetPdfErrorState(error: e.toString()));
//     }
//   }
}
