part of 'pdf_cubit.dart';

abstract class PdfState extends Equatable {
  const PdfState();

  @override
  List<Object?> get props => [];
}

class PdfLoadingState extends PdfState {
  const PdfLoadingState();
}

class GotPdfState extends PdfState {
  final File? pdf;
   final LessonProperty? lessonProperty;
   const GotPdfState({
    required this.pdf,
     this.lessonProperty
  });
  @override
  // TODO: implement props
  List<Object?> get props => [pdf];
}

class GetPdfErrorState extends PdfState {
  final String error;
  const GetPdfErrorState({required this.error});
  @override
  // TODO: implement props
  List<Object> get props => [error];
}

class GotAllPdfsState extends PdfState {
  final List<String> pdfsNames;
  const GotAllPdfsState({required this.pdfsNames});
  @override
  // TODO: implement props
  List<Object?> get props => [pdfsNames];
}
