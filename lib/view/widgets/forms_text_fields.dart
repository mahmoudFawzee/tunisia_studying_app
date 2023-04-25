import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    Key? key,
    required this.hint,
    required this.keyboardType,
    required this.icon,
    required this.isPassword,
    required this.screenHeight,
    required this.showFieldContent,
    required this.onPressedIcon,
    required this.validator,
    required this.controller,
  }) : super(key: key);
  final String hint;
  final TextInputType keyboardType;
  final bool isPassword;
  final IconData? icon;
  final double screenHeight;
  final bool showFieldContent;
  final void Function()? onPressedIcon;
  final String? Function(String?)? validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    print(screenHeight * .1);
    //* this =>68
    return Material(
      elevation: 10,
      shadowColor: Colors.black,
      color: const Color(0xffEBEBEB),
      borderRadius: BorderRadius.circular(10),
      type: MaterialType.card,
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        obscureText: isPassword && !showFieldContent,
        decoration: InputDecoration(
          constraints: const BoxConstraints(
            maxHeight: 90,
            minHeight: 40,
          ),
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.headline5,
          fillColor: const Color(0xffEBEBEB),
          filled: true,
          suffixIcon: icon == null
              ? null
              : IconButton(
                  onPressed: onPressedIcon,
                  icon: Icon(
                    icon,
                    color: showFieldContent && isPassword
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
            gapPadding: 10,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
            gapPadding: 10,
          ),
        ),
      ),
    );
  }
}
