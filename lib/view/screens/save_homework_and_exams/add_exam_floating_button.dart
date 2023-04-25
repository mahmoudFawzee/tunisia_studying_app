import 'package:flutter/material.dart';
import 'package:studying_app/logic/cubits/firebase_exam_cubit/firebase_exam_cubit.dart';
import 'package:studying_app/view/resources/routes/app_routes.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExamFloatingButton extends StatelessWidget {
  const AddExamFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.buttonsLightColor,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () {
        context.read<FirebaseExamCubit>().getUserMaterials();
        Navigator.of(context).pushNamed(
          Routes.addExamRoute,
        );
        
      },
    );
  }
}
