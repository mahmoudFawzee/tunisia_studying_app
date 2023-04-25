import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:studying_app/data/constants/application_lists.dart';
import 'package:studying_app/data/models/user.dart';
import 'package:studying_app/logic/blocs/auth_bloc/auth_bloc.dart';
import 'package:studying_app/view/screens/auth/log_in.dart';
import 'package:studying_app/view/theme/app_colors.dart';
import 'package:studying_app/view/widgets/app_buttons/app_elevated_button.dart';
import 'package:studying_app/view/widgets/drop_down_widget.dart';
import 'package:studying_app/view/widgets/forms_text_fields.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);
  static const pageRoute = '/registration_page';

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  String? gender;
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool showFieldContent = false;
  bool acceptance = false;
  bool showGenderVisibleError = false;
  String? selectedStage;
  String? studyingYear;
  String? selectedBranch;
  String? subscriptionType;
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: const DecorationImage(
              alignment: Alignment.bottomRight,
              image: AssetImage(
                'assets/registration_images/regstration_eclpse.png',
              ),
            ),
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
              padding: const EdgeInsets.all(
                20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'تسجيل حساب جديد',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 15,
                        ),
                  ),
                  SvgPicture.asset(
                    'assets/registration_images/registration_image.svg',
                    height: screenHeight * .18,
                    width: screenWidth * .27,
                  ),
                  Text(
                    'هل انت',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 15,
                        ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      genderSelection(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        selected: gender == 'ذكر',
                        onTap: () {
                          setState(() {
                            gender = 'ذكر';
                            showGenderVisibleError = false;
                          });
                        },
                        image: 'assets/registration_images/male.png',
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      genderSelection(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        selected: gender == 'انثي',
                        onTap: () {
                          setState(() {
                            gender = 'انثي';
                            showGenderVisibleError = false;
                          });
                        },
                        image: 'assets/registration_images/female.png',
                      ),
                    ],
                  ),
                  Visibility(
                    visible: showGenderVisibleError,
                    child: const Text(
                      'الرجاء اختيار النوع',
                      style: TextStyle(
                          color: Colors.red,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormTextField(
                    hint: "الاسم",
                    keyboardType: TextInputType.name,
                    icon: null,
                    isPassword: false,
                    screenHeight: screenHeight,
                    showFieldContent: true,
                    onPressedIcon: () {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء ملئ هذا الحقل';
                      }
                      return null;
                    },
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //todo: create the list which the user select his stage and study year form it
                  MyFormDropDownButton(
                    dropItems: educationStagesDropItems,
                    hint: 'المرحلة التعليمية',
                    value: selectedStage,
                    enable: true,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        selectedStage = value;
                        studyingYear = null;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'الرجاء اختيار عنصر';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyFormDropDownButton(
                    dropItems: selectedStage == 'مرحلة التعليم الاساسي'
                        ? yearsOfEducationDropItems.sublist(0, 3)
                        : yearsOfEducationDropItems.sublist(3, 7),
                    value: studyingYear,
                    hint: ' القسم',
                    enable: selectedStage != null,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        studyingYear = value;
                        selectedBranch = null;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'الرجاء اختيار عنصر';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    //todo make it visible only if the user select second or third year of the
                    //secondary stage and make items which he can select from with the list
                    //of dept
                    visible: studyingYear == 'السنة الثانية' ||
                        studyingYear == 'السنة الثالثة' ||
                        studyingYear == 'الباكلوريا',
                    child: MyFormDropDownButton(
                      dropItems: studyingYear == 'السنة الثانية'
                          ? secondSecondaryEducationDeptDropItems
                          : studyingYear == 'الباكلوريا'
                              ? bacaloriaEducationDeptDropItems
                              : thirdSecondaryEducationDeptDropItems,
                      value: selectedBranch,
                      hint: 'الشعبة',
                      enable: studyingYear != null,
                      onChanged: (value) {
                        print(value);
                        setState(() {
                          selectedBranch = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'الرجاء اختيار عنصر';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Visibility(
                    visible: studyingYear == 'السنة الثانية' ||
                        studyingYear == 'السنة الثالثة' ||
                        studyingYear == 'الباكلوريا',
                    child: const SizedBox(
                      height: 20,
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  FormTextField(
                    hint: "الهاتف ",
                    keyboardType: TextInputType.phone,
                    icon: null,
                    isPassword: false,
                    screenHeight: screenHeight,
                    showFieldContent: true,
                    onPressedIcon: null,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'الرجاء ملئ هذا الحقل';
                      }
                      return null;
                    },
                    controller: phoneNumberController,
                  ),
                  const SizedBox(
                    height: 20,
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
                      } else if (!value.endsWith('@gmail.com')) {
                        return 'الرجاء ادخال بريد صالح';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
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
                    height: 20,
                  ),
                  FormTextField(
                    hint: ' تأكيد كلمة المرور',
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                    showFieldContent: showFieldContent,
                    icon: Icons.remove_red_eye_outlined,
                    screenHeight: screenHeight,
                    controller: confirmPasswordController,
                    onPressedIcon: () {
                      setState(() {
                        showFieldContent = !showFieldContent;
                      });
                    },
                    validator: (value) {
                      //todo:write the code which make the two passes equal
                      if (passwordController.value.text !=
                          confirmPasswordController.value.text) {
                        return 'كلمة المرور غير متشابهة';
                      }
                      return null;
                    },
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: CheckboxListTile(
                      contentPadding: const EdgeInsets.all(8),
                      activeColor: const Color(0xffBA68C8),
                      checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                        5,
                      )),
                      title: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          textAlign: TextAlign.center,
                          'من خلال المتابعة فأنك توافق علي شروط الاستخدام',
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    fontSize: 18,
                                  ),
                        ),
                      ),
                      value: acceptance,
                      onChanged: (value) {
                        setState(() {
                          acceptance = value!;
                        });
                      },
                    ),
                  ),
                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is RegisterLoadingState) {
                        //todo use modal progress hud to make circular progress indicator
                        setState(() {
                          loading = state.loading;
                        });
                      } else if (state is RegisterErrorState) {
                        print(state.error);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return errorMessageDialog(state, context);
                            });
                      } else if (state is RegisterSuccessfullyState) {
                        Navigator.of(context).pushNamed(
                          LogIn.pageRoute,
                        );
                      }
                      emailController.clear();
                      passwordController.clear();
                      confirmPasswordController.clear();
                      //nameController.clear();
                      //phoneNumberController.clear();
                    },
                    child: AppElevatedButton(
                      label: 'تسجيل',
                      //*if user accept the usage conditions
                      //the button will work else it won't
                      onPressed: acceptance
                          ? () {
                              if (formKey.currentState!.validate() &&
                                  gender != null) {
                                //todo: write Registration bloc code here
                                final MyUser newUser = MyUser(
                                  gender: gender!,
                                  name: nameController.value.text,
                                  educationalStage: selectedStage!,
                                  studyingYear: studyingYear!,
                                  branch: selectedBranch,
                                  phoneNumber: phoneNumberController.value.text,
                                  email: emailController.value.text,
                                  password: passwordController.value.text,
                                );
                                context
                                    .read<AuthBloc>()
                                    .add(RegistrationEvent(newUser: newUser));
                              } else if (gender == null) {
                                setState(() {
                                  showGenderVisibleError = true;
                                });
                              }
                            }
                          : null,
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

  Dialog errorMessageDialog(RegisterErrorState state, BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      backgroundColor: const Color(0xffBA68C8),
      insetAnimationCurve: Curves.fastOutSlowIn,
      insetAnimationDuration: const Duration(
        seconds: 2,
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
  }

  InkWell genderSelection({
    required double screenHeight,
    required double screenWidth,
    required void Function()? onTap,
    required String image,
    required bool? selected,
  }) {
    return InkWell(
      onTap: onTap,
      child: Image.asset(
        fit: BoxFit.cover,
        image,
        height: selected == true ? screenHeight * .093 : screenHeight * .08,
        width: selected == true ? screenWidth * .17 : screenWidth * .1,
      ),
    );
  }
}
