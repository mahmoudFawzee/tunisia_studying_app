import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:studying_app/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:studying_app/view/screens/home/taps/about_app_screen.dart';
import 'package:studying_app/view/screens/auth/registration_screen.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:studying_app/view/widgets/app_buttons/app_elevated_button.dart';
import 'package:studying_app/view/widgets/app_buttons/app_text_button.dart';
import 'package:studying_app/view/widgets/forms_text_fields.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);
  static const pageRoute = '/log_in';

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var formKey = GlobalKey<FormState>();
  bool showFieldContent = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            image: const DecorationImage(
                scale: 1.2,
                alignment: Alignment.bottomRight,
                image: AssetImage(
                  'assets/log_in_images/login_Ellipse.png',
                )),
            gradient: LinearGradient(
              colors: AppColors.scaffoldGradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, .5],
            ),
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SvgPicture.asset(
                      'assets/log_in_images/login_image.svg',
                      height: screenHeight * .42,
                      width: screenWidth * .632,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    height: screenHeight * .035,
                    width: screenWidth * .7,
                    child: SizedBox(
                      child: Text(
                        'مرحبا ,الرجاء تسجيل الدخول الي حسابك',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FormTextField(
                    hint: 'البريد الالكتروني',
                    keyboardType: TextInputType.emailAddress,
                    isPassword: false,
                    showFieldContent: true,
                    icon: Icons.email_outlined,
                    screenHeight: screenHeight,
                    controller: emailController,
                    onPressedIcon: null,
                    validator: (value) {
                      //todo:write the bloc form validation event and validate with the bloc
                      if (value!.isEmpty) {
                        return 'لا يمكن ترك هذا الحقل فارغ';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FormTextField(
                    hint: 'كلمة المرور',
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                    showFieldContent: showFieldContent,
                    icon: Icons.remove_red_eye_outlined,
                    screenHeight: screenHeight,
                    controller: passwordController,
                    onPressedIcon: () {
                      setState(() {
                        showFieldContent = !showFieldContent;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'لا يمكن ترك هذا الحقل فارغ';
                      } else if (value.length < 6) {
                        return 'طول كلمه المرور يجب ان يجاوز سته احرف';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppTextButton(
                    label: 'انشاء حساب جديد',
                    onPressed: () {
                      //todo: here write the code of moving to the Sign in page
                      //to create new account
                      Navigator.of(context).pushNamed(Registration.pageRoute);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: BlocListener<AuthBloc, AuthState>(
                      listener: (context, state) async {
                        // TODO: implement listener

                        if (state is SignInSuccessfullyState) {
                          Navigator.of(context).pushReplacementNamed(
                              AboutApp.pageRoute,
                              arguments: {
                                'isFromHome': false,
                              });
                          emailController.clear();
                          passwordController.clear();
                        } else if (state is SignInLoadingState) {
                          setState(() {
                            isLoading = state.loading;
                          });
                        } else if (state is SignInErrorState) {
                          print(state.error);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${state.error}'),
                            ),
                          );
                          /*showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  insetPadding: const EdgeInsets.all(20),
                                  backgroundColor: const Color(0xffBA68C8),
                                  insetAnimationCurve:
                                      Curves.fastLinearToSlowEaseIn,
                                  insetAnimationDuration: const Duration(
                                    seconds: 3,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      10,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      state.error!,
                                      style: Theme.of(context).textTheme.button,
                                    ),
                                  ),
                                );
                              });*/
                          passwordController.clear();
                        }
                      },
                      child: AppElevatedButton(
                          label: 'دخول',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              //todo: here write the code of sign in with bloc
                              context.read<AuthBloc>().add(SignInEvent(
                                    email: emailController.value.text,
                                    password: passwordController.value.text,
                                  ));
                            }
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
