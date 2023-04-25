import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studying_app/logic/blocs/firebase_exam_bloc/firebase_exam_bloc.dart';
import 'package:studying_app/logic/cubits/advices_notes_cubit/advices_notes_cubit.dart';
import 'package:studying_app/logic/cubits/firebase_exam_cubit/firebase_exam_cubit.dart';
import 'package:studying_app/logic/cubits/notifications_cubit/notifications_cubit.dart';
import 'package:studying_app/view/resources/routes/app_routes.dart';
import 'package:studying_app/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:studying_app/logic/blocs/lessons_bloc/lessons_bloc.dart';
import 'package:studying_app/logic/blocs/materials_bloc/materials_bloc.dart';
import 'package:studying_app/logic/cubits/local_homework_cubit/local_homework_cubit.dart';
import 'package:studying_app/logic/cubits/pdf_cubit/pdf_cubit.dart';
import 'package:studying_app/logic/cubits/quiz_cubit/quiz_cubit.dart';
import 'package:studying_app/view/screens/start/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:studying_app/view/theme/app_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp._init();
  static const MyApp _instance = MyApp._init();
  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _authBloc = AuthBloc();
  final _materialsBloc = MaterialsBloc();
  final _pdfCubit = PdfCubit();
  final _lessonBloc = LessonsBloc();
  final _localHomeworkCubit = LocalHomeworkCubit()..openHomeworkBox();
  final _quizCubit = QuizCubit();
  final _firebaseExamCubit = FirebaseExamCubit();
  final _notificationsCubit = NotificationsCubit()..setUpNotification();
  final _advicesNotesCubit = AdvicesNotesCubit();
  final _firebaseExamContentBloc = FirebaseExamContentBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''),
      ],
      theme: appTheme,
      initialRoute: SplashScreen.pageRoute,
      routes: appRoutes(
        lessonsBloc: _lessonBloc,
        pdfCubit: _pdfCubit,
        materialsBloc: _materialsBloc,
        authBloc: _authBloc,
        localHomeworkCubit: _localHomeworkCubit,
        quizCubit: _quizCubit,
        firebaseExamCubit: _firebaseExamCubit,
        notificationsCubit: _notificationsCubit,
        advicesNotesCubit: _advicesNotesCubit,
        firebaseExamContentBloc: _firebaseExamContentBloc,
      ),
    );
  }

  @override
  void dispose() {
    _authBloc.close();
    _materialsBloc.close();
    _pdfCubit.close();
    _lessonBloc.close();
    _localHomeworkCubit.close();
    _firebaseExamCubit.close();
    _quizCubit.close();
    _notificationsCubit.close();
    _advicesNotesCubit.close();
    _firebaseExamContentBloc.close();
    super.dispose();
  }
}
