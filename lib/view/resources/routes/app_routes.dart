import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:studying_app/logic/blocs/chat_bloc/chat_bloc.dart';
import 'package:studying_app/logic/blocs/firebase_exam_bloc/firebase_exam_bloc.dart';
import 'package:studying_app/logic/blocs/lessons_bloc/lessons_bloc.dart';
import 'package:studying_app/logic/blocs/materials_bloc/materials_bloc.dart';
import 'package:studying_app/logic/cubits/firebase_exam_cubit/firebase_exam_cubit.dart';
import 'package:studying_app/logic/cubits/local_homework_cubit/local_homework_cubit.dart';
import 'package:studying_app/logic/cubits/notifications_cubit/notifications_cubit.dart';
import 'package:studying_app/logic/cubits/pdf_cubit/pdf_cubit.dart';
import 'package:studying_app/logic/cubits/quiz_cubit/quiz_cubit.dart';
import 'package:studying_app/view/screens/exam_revision_screen/exam_revision_screen.dart';
import 'package:studying_app/view/screens/material_screens//notes_advices_page.dart';
import 'package:studying_app/view/screens/save_homework_and_exams/add_exam_page.dart';
import 'package:studying_app/view/screens/about_app_screens/our_goals_screen.dart';
import 'package:studying_app/view/screens/auth/log_in.dart';
import 'package:studying_app/view/screens/home/taps/educational_materials_screen.dart';
import 'package:studying_app/view/screens/save_homework_and_exams/local_homework_or_exam_screen.dart';
import 'package:studying_app/view/screens/material_screens/lesson_content.dart';
import 'package:studying_app/view/screens/material_screens/material_all_lessons.dart';
import 'package:studying_app/view/screens/material_screens/material_content.dart';
import 'package:studying_app/view/screens/news_details.dart';
import 'package:studying_app/view/screens/home/taps/about_app_screen.dart';
import 'package:studying_app/view/screens/about_app_screens/app_pros.dart';
import 'package:studying_app/view/screens/home/navigation.dart';
import 'package:studying_app/view/screens/about_app_screens/contact_us.dart';
import 'package:studying_app/view/screens/pdf/homework_section_pdfs.dart';
import 'package:studying_app/view/screens/material_screens//homework_sections.dart';
import 'package:studying_app/view/screens/material_screens//one_section_content.dart';
import 'package:studying_app/view/screens/pdf/lesson_pdfs.dart';
import 'package:studying_app/view/screens/pdf/material_pdfs.dart';
import 'package:studying_app/view/screens/pdf/pdf_viewer_page.dart';
import 'package:studying_app/view/screens/quiz/quiz_page.dart';
import 'package:studying_app/view/screens/start/introduction_screen.dart';
import 'package:studying_app/view/screens/auth/registration_screen.dart';
import 'package:studying_app/view/screens/start/splash_screen.dart';
import 'package:studying_app/view/screens/auth/subscribtion_complete.dart';
import 'package:studying_app/view/screens/home/taps/news.dart';
import 'package:studying_app/view/screens/video/lesson_video.dart';

import '../../../logic/cubits/advices_notes_cubit/advices_notes_cubit.dart';

class RoutesManger {
  final _pdfCubit = PdfCubit();
  final _lessonsBloc = LessonsBloc();
  final _materialsBloc = MaterialsBloc();
  final _authBloc = AuthBloc();
  final _localHomeworkCubit = LocalHomeworkCubit();
  final _quizCubit = QuizCubit();
  final _firebaseExamCubit = FirebaseExamCubit();
  final _notificationsCubit = NotificationsCubit();
  final _advicesNotesCubit = AdvicesNotesCubit();
  final _firebaseExamContentBloc = FirebaseExamContentBloc();
  final _chatBloc = ChatBloc();
  dispose() {
    _authBloc.close();
    _materialsBloc.close();
    _pdfCubit.close();
    _lessonsBloc.close();
    _localHomeworkCubit.close();
    _firebaseExamCubit.close();
    _quizCubit.close();
    _notificationsCubit.close();
    _advicesNotesCubit.close();
    _firebaseExamContentBloc.close();
    _chatBloc.close();
  }

  Map<String, Widget Function(BuildContext)> appRoutes() {
    return {
      SplashScreen.pageRoute: (context) => const SplashScreen(),
      OnBoardingScreen.pageRoute: (context) => const OnBoardingScreen(),
      Registration.pageRoute: (context) => BlocProvider.value(
            value: _authBloc,
            child: const Registration(),
          ),
      SubscriptionCompleted.pageRoute: (context) =>
          const SubscriptionCompleted(),
      LogIn.pageRoute: (context) => BlocProvider.value(
            value: _authBloc,
            child: const LogIn(),
          ),
      Navigation.pageRoute: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _materialsBloc,
              ),
              BlocProvider.value(
                value: _localHomeworkCubit,
              ),
              BlocProvider.value(
                value: _authBloc,
              ),
              BlocProvider.value(
                value: _firebaseExamCubit,
              ),
              BlocProvider.value(
                value: _notificationsCubit,
              ),
              BlocProvider.value(
                value: _chatBloc,
              ),
            ],
            child: const Navigation(),
          ),
      EducationalMaterialsScreen.pageRoute: (context) => BlocProvider.value(
            value: _materialsBloc,
            child: const EducationalMaterialsScreen(),
          ),
      AboutApp.pageRoute: (context) => const AboutApp(),
      NewsScreen.pageRoute: (context) => const NewsScreen(),      
      ContactUs.pageRoute: (context) => const ContactUs(),
      OurGoals.pageRoute: (context) => const OurGoals(),
      NewDetails.pageRoute: (context) => const NewDetails(),
      AppPros.pageRoute: (context) => AppPros(),
      MaterialContent.pageRoute: (context) => MultiBlocProvider(providers: [
            BlocProvider.value(
              value: _materialsBloc,
            ),
            BlocProvider.value(
              value: _pdfCubit,
            ),
            BlocProvider.value(
              value: _lessonsBloc,
            ),
            BlocProvider.value(
              value: _advicesNotesCubit,
            ),
          ], child: const MaterialContent()),
      MaterialAllLessons.pageRoute: (context) => BlocProvider.value(
            value: _lessonsBloc,
            child: const MaterialAllLessons(),
          ),
      PdfViewerPage.pageRoute: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _pdfCubit,
              ),
              BlocProvider.value(
                value: _lessonsBloc,
              ),
              BlocProvider.value(
                value: _materialsBloc,
              ),
            ],
            child: const PdfViewerPage(),
          ),
      MaterialPdfsScreen.pageRoute: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _materialsBloc,
              ),
              BlocProvider.value(
                value: _pdfCubit,
              ),
            ],
            child: const MaterialPdfsScreen(),
          ),
      QuizPage.pageRoute: (context) => BlocProvider.value(
            value: _quizCubit,
            child: const QuizPage(),
          ),
      LessonContent.pageRoute: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _lessonsBloc,
              ),
              BlocProvider.value(
                value: _quizCubit,
              ),
            ],
            child: const LessonContent(),
          ),
      LessonVideoScreen.pageRoute: (context) => BlocProvider.value(
            value: _lessonsBloc,
            child: const LessonVideoScreen(),
          ),
      LessonMaterialPdfsPage.pageRoute: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _lessonsBloc,
              ),
              BlocProvider.value(
                value: _pdfCubit,
              ),
            ],
            child: const LessonMaterialPdfsPage(),
          ),
      HomeworkSections.pageRoute: (context) => const HomeworkSections(),
      OneSectionContent.pageRoute: (context) => const OneSectionContent(),
      HomeworkSectionPdfs.pageRoute: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _pdfCubit,
              ),
              BlocProvider.value(
                value: _materialsBloc,
              ),
            ],
            child: const HomeworkSectionPdfs(),
          ),
      HomeworkOrExamsPage.pageRoute: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _localHomeworkCubit..getMyHomework()),
              BlocProvider.value(
                value: _firebaseExamCubit,
              ),
              BlocProvider.value(
                value: _lessonsBloc,
              ),
              BlocProvider.value(
                value: _notificationsCubit,
              ),
              BlocProvider.value(
                value: _firebaseExamContentBloc,
              ),
            ],
            child: const HomeworkOrExamsPage(),
          ),
      Routes.addExamRoute: (context) => BlocProvider.value(
            value: _firebaseExamCubit,
            child: const AddExamPage(),
          ),
      Routes.notesAdvicesRoute: (context) => BlocProvider.value(
            value: _advicesNotesCubit,
            child: const AdvicesNotesPage(),
          ),
      ExamRevisionScreen.pageRoute: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _firebaseExamContentBloc,
              ),
              BlocProvider.value(
                value: _materialsBloc,
              )
            ],
            child: const ExamRevisionScreen(),
          )
    };
  }
}

//TODO :move all routes here..
class Routes {
  static const splashRoute = '/splash_screen';
  static const onBoardingRoute = '/introduction_screen';
  static const registerRoute = '/registration_page';
  static const subscriptionCompletedRoute = '/subscription_completed_page';
  static const logInRoute = '/log_in';
  static const navigationRoute = '/navigation';
  static const materialsRoute = '/educational_materials';
  static const aboutAppRoute = '/about_app';
  static const newsRoute = '/news_page';
  static const addExamRoute = '/add_exam_page';
  static const notesAdvicesRoute = 'notes_advices_page';
}
