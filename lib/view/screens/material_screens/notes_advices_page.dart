import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/widgets/app_background_container.dart';

import '../../../../logic/cubits/advices_notes_cubit/advices_notes_cubit.dart';

class AdvicesNotesPage extends StatelessWidget {
  const AdvicesNotesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final routeArgus =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final section = routeArgus['section'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.scaffoldGradientColors.first,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          section!,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      body: AppBackground(
        child: Align(
          alignment: Alignment.topCenter,
          child: BlocBuilder<AdvicesNotesCubit, AdvicesNotesState>(
            builder: (context, state) {
              if (state is GotAdvicesState) {
                List<dynamic> advices = state.advices;
                return ListView.builder(
                    itemCount: advices.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return advicesNotesCustomWidget(advices[index]);
                    });
              } else if (state is GotNotesState) {
                List<dynamic> notes = state.notes;
                return ListView.builder(
                    itemCount: notes.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return advicesNotesCustomWidget(notes[index]);
                    });
              } else if (state is GetAdvicesNotesErrorState) {
                return Center(
                  child: Text(state.error),
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.scaffoldGradientColors.first,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Card advicesNotesCustomWidget(
    String item,
  ) {
    return Card(
      child: ListTile(
        title: Text(
          item,
        ),
      ),
    );
  }
}
