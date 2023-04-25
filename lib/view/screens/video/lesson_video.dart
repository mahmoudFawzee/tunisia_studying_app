import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/logic/blocs/lessons_bloc/lessons_bloc.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonVideoScreen extends StatelessWidget {
  const LessonVideoScreen({
    Key? key,
  }) : super(key: key);
  static const pageRoute = 'lesson_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(
          top: 10,
        ),
        decoration: BoxDecoration(
          gradient: AppColors.containerGradient,
        ),
        child: BlocBuilder<LessonsBloc, LessonsState>(
          builder: (context, state) {
            if (state is GotVideoIdState) {
              YoutubePlayerController youtubePlayerController =
                  YoutubePlayerController(
                initialVideoId: state.videoId,
                flags: const YoutubePlayerFlags(
                  autoPlay: false,
                ),
              );
              
              return YoutubePlayer(
                controller: youtubePlayerController,
              );
            } else if (state is GetMaterialLessonsErrorState) {
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
    );
  }
}
