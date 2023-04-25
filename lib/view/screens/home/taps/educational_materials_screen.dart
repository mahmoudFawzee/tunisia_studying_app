import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/logic/blocs/materials_bloc/materials_bloc.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/widgets/educational_material_form.dart';

import '../../material_screens/material_content.dart';

class EducationalMaterialsScreen extends StatelessWidget {
  const EducationalMaterialsScreen({Key? key}) : super(key: key);
  static const pageRoute = '/educational_materials';
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    double screenHeight = orientation == Orientation.portrait
        ? MediaQuery.of(context).size.height
        : MediaQuery.of(context).size.width;
    double screenWidth = orientation == Orientation.portrait
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;
    return BlocBuilder<MaterialsBloc, MaterialsState>(
      builder: (context, state) {
        if (state is GotAllMaterialsState) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              backgroundColor: AppColors.scaffoldGradientColors.first,
              centerTitle: true,
              title: Text(
                state.studyingYear,
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.black,
                      fontSize: 24,
                    ),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: AppColors.containerGradient,
              ),
              child: Column(
                children: [
                  const Text(
                    'المواد الدراسية',
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'ElMessiri',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    ),
                  ),
                  Expanded(
                    child: GridView(
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * .0292,
                        horizontal: screenWidth * .0486,
                      ),
                      scrollDirection: Axis.vertical,
                      //shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 110,
                        crossAxisSpacing: 30,
                        mainAxisExtent: screenHeight * .19,
                        mainAxisSpacing: 20,
                        childAspectRatio: 10 / 13,
                      ),
                      //todo if the snapshot.studying year has the studying year material.
                      children: state.materials
                          .map((item) => EducationalMaterialForm(
                                materialName: item,
                                screenHeight: screenHeight,
                                screenWidth: screenWidth,
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    MaterialContent.pageRoute,
                                    arguments: {
                                      'materialName': item,
                                    },
                                  );
                                },
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is GetMaterialErrorState) {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: AppColors.containerGradient,
              ),
              child: Center(
                child: Text(state.errorMessage),
              ),
            ),
          );
        }
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: AppColors.containerGradient,
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors.scaffoldGradientColors.first,
              ),
            ),
          ),
        );
      },
    );
  }
}
