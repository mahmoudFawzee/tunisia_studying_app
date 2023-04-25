import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/data/models/user.dart';
import 'package:studying_app/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:studying_app/data/firebase_apis/fire_base_auth_api.dart';
import 'package:studying_app/view/screens/auth/log_in.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/widgets/app_buttons/app_elevated_button.dart';

import '../../../data/firebase_apis/firebase_user_data_api.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var firebaseAuthApi = FirebaseAuthApi();
  FirebaseUserDataApi firebaseApi = FirebaseUserDataApi();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<MyUser>(
          future: firebaseApi.getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'بروفايل الطالب',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/home_page_images/boy_image.png',
                              height: 70,
                              width: 70,
                            ),
                          ),
                          Positioned(
                            bottom: -15,
                            right: 35,
                            child: IconButton(
                              onPressed: () {
                                //todo : add the method of adding a new photo here
                              },
                              icon: const Icon(
                                Icons.add_a_photo_rounded,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    customProfileItem(
                      context,
                      userField: user!.name,
                      itemName: 'الاسم :',
                      showTrailing: false,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    customProfileItem(
                      context,
                      userField: user.studyingYear,
                      itemName: 'السنة الدراسية:',
                      showTrailing: false,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    user.branch == null
                        ? Container()
                        : customProfileItem(
                            context,
                            userField: user.branch == null ? '' : user.branch!,
                            itemName: 'الشعبة : ',
                            showTrailing: false,
                          ),
                    SizedBox(
                      height: user.branch == null ? 0 : 40,
                    ),
                    customProfileItem(
                      context,
                      userField: user.phoneNumber,
                      itemName: 'رقم الهاتف :',
                      showTrailing: true,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) {
                        // TODO: implement listener
                        if (state is SignOutErrorState) {
                          print(state.youSignOut);
                        } else if (state is SignOutState) {
                          print(state.youSignOut);
                          Navigator.of(context)
                              .pushReplacementNamed(LogIn.pageRoute);
                        }
                      },
                      child: Center(
                        child: AppElevatedButton(
                          label: 'تسجيل الخروج',
                          onPressed: () =>
                              context.read<AuthBloc>().add(SignOutEvent()),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.scaffoldGradientColors.first,
                ),
              );
            }
          }),
    );
  }

  Card customProfileItem(
    BuildContext context, {
    required String userField,
    required String itemName,
    required bool showTrailing,
  }) {
    return Card(
      color: AppColors.scaffoldGradientColors[1],
      margin: const EdgeInsets.symmetric(horizontal: 10),
      elevation: 5,
      child: ListTile(
        leading: Text(
          itemName,
          style: Theme.of(context).textTheme.headline5,
        ),
        title: Text(
          userField,
          style: Theme.of(context).textTheme.headline5,
        ),
        trailing: showTrailing
            ? InkWell(
                onTap: () {},
                child: Text(
                  'تعديل',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                ),
              )
            : null,
      ),
    );
  }
}
