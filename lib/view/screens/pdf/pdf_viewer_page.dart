// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:studying_app/data/constants/enums.dart';
import 'package:studying_app/logic/blocs/lessons_bloc/lessons_bloc.dart';
import 'package:studying_app/logic/blocs/materials_bloc/materials_bloc.dart';
import 'package:studying_app/logic/cubits/pdf_cubit/pdf_cubit.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/theme/screens_orientations.dart';

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({
    super.key,
  });
  static const pageRoute = 'pdf_viewer_page';

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enableOrientation();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final materialName = routeArgus['materialName'];
    LessonProperty? lessonProperty = routeArgus['lessonProperty'];
    String? pdfName = routeArgus['pdfName'];
    String? lessonName = routeArgus['lessonName'];
    String? homeworkSectionName = routeArgus['homeworkSectionName'];
    String? homeworkName = routeArgus['homeworkName'];
    return WillPopScope(
      onWillPop: () async {
        if (lessonName != null) {
          context.read<LessonsBloc>().add(
                GetLessonExercisesEvent(
                  lessonName: lessonName,
                  materialName: materialName,
                  lessonProperty: lessonProperty!,
                ),
              );
          return true;
        } else if (homeworkSectionName != null) {
          context.read<MaterialsBloc>().add(
                GetMaterialHomeWorkEvent(
                  materialName: materialName,
                  homeworkName: homeworkName!,
                  homeworkSectionName: homeworkSectionName,
                ),
              );
          return true;
        } else {
          context.read<MaterialsBloc>().add(
                GetMaterialBooksEvent(
                  materialName: materialName,
                ),
              );
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            onPressed: () {
              if (lessonName != null) {
                context.read<LessonsBloc>().add(
                      GetLessonExercisesEvent(
                        lessonName: lessonName,
                        materialName: materialName,
                        lessonProperty: lessonProperty!,
                      ),
                    );
              } else if (homeworkSectionName != null) {
                context.read<MaterialsBloc>().add(
                      GetMaterialHomeWorkEvent(
                        materialName: materialName,
                        homeworkName: homeworkName!,
                        homeworkSectionName: homeworkSectionName,
                      ),
                    );
              } else {
                context.read<MaterialsBloc>().add(
                      GetMaterialBooksEvent(
                        materialName: materialName,
                      ),
                    );
              }
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          backgroundColor: AppColors.scaffoldGradientColors.first,
          title: Text(
            pdfName!.contains('.pdf')
                ? pdfName.substring(
                    0,
                    pdfName.length - 5,
                  )
                : pdfName,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(
            top: 10,
          ),
          decoration: BoxDecoration(
            gradient: AppColors.containerGradient,
          ),
          child: BlocBuilder<PdfCubit, PdfState>(
            builder: (context, state) {
              print('pdf state : $state');
              if (state is GotPdfState) {
                //!the state will change the lessonProperty to answers and we can't show
                //!the storage answers as a gridView so we make it exercises instead
                //!which we can show it as a gridView...
                //!but for any another property we can show it .
                lessonProperty = state.lessonProperty == LessonProperty.answers
                    ? LessonProperty.exercises
                    : state.lessonProperty;
                return PDFView(
                  filePath: state.pdf!.path,
                  enableSwipe: true,
                  swipeHorizontal: true,
                );
              } else if (state is GetPdfErrorState) {
                return Center(
                  child: Text(
                    state.error,
                  ),
                );
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: AppColors.scaffoldGradientColors.first,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('we are preparing the pdf for you...')
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: BlocBuilder<PdfCubit, PdfState>(
          builder: (context, state) {
            if (state is GotPdfState) {
              if (state.lessonProperty == LessonProperty.exercises) {
                return FloatingActionButton(
                  backgroundColor: AppColors.buttonsLightColor,
                  onPressed: () {
                    //todo get the exercise answers and open it
                    //todo call open answers event
                    context.read<PdfCubit>().getPdf(
                          materialName: materialName,
                          pdfName: pdfName,
                          lessonName: lessonName,
                          lessonProperty: LessonProperty.answers,
                        );
                  },
                  child: Text(
                    'الاجابات',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 10,
                          color: Colors.black,
                        ),
                  ),
                );
              } else {
                return Container();
              }
            }
            return Container();
          },
        ),
      ),
    );
  }
}
