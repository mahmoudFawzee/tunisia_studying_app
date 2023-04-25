// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:studying_app/data/providers/notification_provider.dart';
import 'package:studying_app/logic/cubits/local_homework_cubit/local_homework_cubit.dart';
import 'package:intl/intl.dart';
import 'package:studying_app/logic/cubits/notifications_cubit/notifications_cubit.dart';
import '../../theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddLocalHomeworkFloatingButton extends StatelessWidget {
  const AddLocalHomeworkFloatingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.buttonsLightColor,
      onPressed: () async {
        await showDialog(
            context: context,
            builder: (c) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: BlocProvider.of<LocalHomeworkCubit>(context),
                  ),
                  BlocProvider.value(
                    value: BlocProvider.of<NotificationsCubit>(context),
                  ),
                ],
                child: AlertDialog(
                  title: Text(
                    'اضف تمرين جديد',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  content: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (title) {
                            context
                                .read<LocalHomeworkCubit>()
                                .setTitle(title: title);
                          },
                          decoration: InputDecoration(
                            hintText: 'اسم التمرين',
                            hintStyle: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextButton(
                          onPressed: () {
                            context
                                .read<LocalHomeworkCubit>()
                                .setDateTime(context);
                          },
                          child: BlocConsumer<LocalHomeworkCubit,
                              LocalHomeworkState>(
                            listener: (context, state) {
                              if (state is GetHomeworkErrorState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      state.error,
                                    ),
                                  ),
                                );
                              }
                            },
                            buildWhen: (previous, current) {
                              return current is ValidHomeworkDetailsState ||
                                  current is ValidHomeworkDateState;
                            },
                            builder: (context, state) {
                              if (state is ValidHomeworkDetailsState) {
                                String formattedDate =
                                    DateFormat.yMMMEd().format(state.dateTime);
                                return Text(formattedDate);
                              } else if (state is ValidHomeworkDateState) {
                                String formattedDate =
                                    DateFormat.yMMMEd().format(state.dateTime);
                                return Text(formattedDate);
                              }

                              return const Icon(
                                Icons.date_range,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  actionsAlignment: MainAxisAlignment.spaceAround,
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(c).pop();
                      },
                      child: const Text(
                        'الغاء',
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    BlocConsumer<LocalHomeworkCubit, LocalHomeworkState>(
                      listener: (context, state) {
                        print(state);
                        if (state is AddedHomeworkState) {
                          MyNotification notification = MyNotification(
                            name: state.addedHomework.homeworkName,
                            dateTime: state.addedHomework.homeworkTime,
                          );
                          context.read<NotificationsCubit>().addNotification(
                                notification: notification,
                                scheduleDaily: false,
                              );
                        }
                      },
                      buildWhen: (previous, current) {
                        return current is ValidHomeworkDetailsState;
                      },
                      builder: (context, state) {
                        print(state);
                        if (state is ValidHomeworkDetailsState) {
                          return TextButton(
                            onPressed: () {
                              context.read<LocalHomeworkCubit>().addHomework(
                                    name: state.title,
                                    done: false,
                                    homeworkTime: state.dateTime,
                                  );
                              Navigator.of(c).pop();
                            },
                            child: Text(
                              'اضف',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    color: Colors.blue,
                                  ),
                            ),
                          );
                        }
                        return Text(
                          'اضف',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.grey,
                                  ),
                        );
                      },
                    ),
                  ],
                ),
              );
            });
      },
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
