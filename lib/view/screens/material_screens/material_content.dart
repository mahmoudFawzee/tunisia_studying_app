import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/logic/blocs/lessons_bloc/lessons_bloc.dart';
import 'package:studying_app/logic/blocs/materials_bloc/materials_bloc.dart';
import 'package:studying_app/logic/cubits/advices_notes_cubit/advices_notes_cubit.dart';
import 'package:studying_app/view/resources/assets/assets_manger.dart';
import 'package:studying_app/view/resources/routes/app_routes.dart';
import 'package:studying_app/view/screens/material_screens/material_all_lessons.dart';
import 'package:studying_app/view/screens/material_screens//homework_sections.dart';
import 'package:studying_app/view/screens/pdf/material_pdfs.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/theme/screens_orientations.dart';

import '../../widgets/app_drawer.dart';

class MaterialContent extends StatefulWidget {
  const MaterialContent({Key? key}) : super(key: key);
  static const pageRoute = 'materialDetails';

  @override
  State<MaterialContent> createState() => _MaterialContentState();
}

class _MaterialContentState extends State<MaterialContent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    enableOrientation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    disableOrientation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    double screenHeight = orientation == Orientation.portrait
        ? MediaQuery.of(context).size.height
        : MediaQuery.of(context).size.width;
    final routeArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>?;
    final materialName = routeArgus!['materialName'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldGradientColors.first,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          materialName!,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      drawer: const AppDrawer(),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(
          top: 10,
        ),
        decoration: BoxDecoration(
          gradient: AppColors.containerGradient,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    customItem(
                      context: context,
                      materialName: 'ملخصات المادة',
                      imagePath: MaterialImagesManger.books,
                      onTap: () {
                        context.read<MaterialsBloc>().add(
                              GetMaterialBooksEvent(
                                materialName: materialName,
                              ),
                            );
                        Navigator.of(context).pushNamed(
                          MaterialPdfsScreen.pageRoute,
                          arguments: {
                            'materialName': materialName,
                          },
                        );
                        disableOrientation();
                      },
                    ),
                    customItem(
                        context: context,
                        materialName: 'الفروض',
                        imagePath: MaterialImagesManger.exams,
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            HomeworkSections.pageRoute,
                            arguments: {
                              'materialName': materialName,
                            },
                          );
                          disableOrientation();
                        }),
                  ],
                ),
                SizedBox(
                  height: screenHeight * .1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    customItem(
                      context: context,
                      materialName: 'ملاحظات',
                      imagePath: MaterialImagesManger.notes,
                      onTap: () {
                        context.read<AdvicesNotesCubit>().getNotes(
                              materialName: materialName,
                            );
                        Navigator.of(context)
                            .pushNamed(Routes.notesAdvicesRoute, arguments: {
                          'section': 'ملاحظات',
                        });
                        disableOrientation();
                      },
                    ),
                    customItem(
                      context: context,
                      materialName: 'نصائح للمراجعة',
                      imagePath: MaterialImagesManger.advices,
                      onTap: () {
                        context.read<AdvicesNotesCubit>().getAdvices(
                              materialName: materialName,
                            );
                        Navigator.of(context)
                            .pushNamed(Routes.notesAdvicesRoute, arguments: {
                          'section': 'نصائح للمراجعة',
                        });
                        disableOrientation();
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * .1,
                ),
                customItem(
                    context: context,
                    materialName: 'الدروس',
                    imagePath: MaterialImagesManger.lessons,
                    onTap: () {
                      context.read<LessonsBloc>().add(
                            GetMaterialLessonEvent(
                              materialName: materialName,
                            ),
                          );
                      Navigator.of(context)
                          .pushNamed(MaterialAllLessons.pageRoute, arguments: {
                        'materialName': materialName,
                      });
                      disableOrientation();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox customItem({
    required BuildContext context,
    required String materialName,
    required String imagePath,
    required void Function()? onTap,
  }) {
    return SizedBox(
      height: 175,
      width: 145,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            ClipRRect(child: Image.asset(imagePath)),
            Text(
              materialName,
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
      ),
    );
  }
}
