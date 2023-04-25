import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications_platform_interface/src/types.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studying_app/logic/cubits/notifications_cubit/notifications_cubit.dart';
import 'package:studying_app/view/resources/assets/assets_manger.dart';
import 'package:studying_app/view/resources/strings/strings_manger.dart';
import 'package:studying_app/view/theme/app_colors.dart';

class AppNotification extends StatelessWidget {
  const AppNotification({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider.value(
        value: BlocProvider.of<NotificationsCubit>(context)
          ..getAllNotifications(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0, right: 15, left: 15),
              child: SizedBox(
                height: 85,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.loose,
                  clipBehavior: Clip.none,
                  children: [
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Material(
                        color: const Color.fromARGB(192, 240, 153, 122),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: (MediaQuery.of(context).size.width / 2) -
                          (31 * (3 / 2)),
                      child: Material(
                        shadowColor: Colors.black,
                        elevation: 5,
                        shape: const CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 31,
                          child: SvgPicture.asset(
                            ImageManger.notificationImageSmallRing,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                if (state is GotNotificationsState) {
                  List<ActiveNotification> notifications = state.notifications;
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    itemCount: notifications.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(notifications[index].body!),
                        ),
                      );
                    },
                  );
                } else if (state is GotNoNotificationsState) {
                  return noNotifications(context,
                      label: StringsManger.noNotification);
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.scaffoldGradientColors.first,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 150,
            ),
          ],
        ),
      ),
    );
  }

  Column noNotifications(
    BuildContext context, {
    required String label,
  }) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * (5 / 78),
        ),
        Center(
          child: SvgPicture.asset(
            ImageManger.notificationImageCenterRing,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * (3 / 78),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.headline5,
        ),
      ],
    );
  }
}
