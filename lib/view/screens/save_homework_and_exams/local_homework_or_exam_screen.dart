import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/logic/cubits/firebase_exam_cubit/firebase_exam_cubit.dart';
import 'package:studying_app/view/resources/strings/strings_manger.dart';
import 'package:studying_app/view/screens/save_homework_and_exams/add_exam_floating_button.dart';
import 'package:studying_app/view/screens/save_homework_and_exams/exams_page.dart';
import 'package:studying_app/view/screens/save_homework_and_exams/local_home_work_page.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import '../../../logic/cubits/local_homework_cubit/local_homework_cubit.dart';
import 'add_local_homework_action_button.dart';

class HomeworkOrExamsPage extends StatefulWidget {
  const HomeworkOrExamsPage({
    super.key,
  });
  static const pageRoute = 'local_homework_page';

  @override
  State<HomeworkOrExamsPage> createState() => _HomeworkOrExamsPageState();
}

class _HomeworkOrExamsPageState extends State<HomeworkOrExamsPage> {
  int _selectedTabIndex = 0;
  final List<Widget> _tabBarTaps = const [
    LocalHomeworkPage(),
    ExamsPage(),
  ];

  final List<Widget> _pageFloatingActionButton =const  [
    AddLocalHomeworkFloatingButton(),
    AddExamFloatingButton(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.scaffoldGradientColors.first,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            _selectedTabIndex == 0
                ? StringsManger.exercises
                : StringsManger.homework,
            style: Theme.of(context).textTheme.headline5,
          ),
          bottom: TabBar(
            indicator: const UnderlineTabIndicator(
              borderSide: BorderSide(
                color: AppColors.buttonsLightColor,
                style: BorderStyle.solid,
                width: 5,
              ),
              insets: EdgeInsets.symmetric(
                horizontal: 20,
              ),
            ),
            onTap: (value) {
              setState(() {
                _selectedTabIndex = value;
              });
              if (value == 0) {
                context.read<LocalHomeworkCubit>().getMyHomework(
                    );
              } else {
                context.read<FirebaseExamCubit>().getAllExams(isCompleted: false);
              }
            },
            tabs: [
              Tab(
                child: Text(
                  StringsManger.exercises,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Tab(
                child: Text(
                  StringsManger.homework,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: _tabBarTaps,
        ),
        floatingActionButton: _pageFloatingActionButton[_selectedTabIndex],
      ),
    );
  }
}
