import 'package:flutter/material.dart';

class MyFormDropDownButton extends StatelessWidget {
  const MyFormDropDownButton({
    Key? key,
    required this.dropItems,
    required this.hint,
    required this.value,
    required this.enable,
    required this.onChanged,
    required this.validator,
  }) : super(key: key);
  final List<String> dropItems;
  final String hint;
  final String? value;
  final bool enable;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black,
      color: const Color(0xffEBEBEB),
      child: DropdownButtonFormField<String?>(
        icon: const Icon(Icons.arrow_drop_down),
        alignment: Alignment.bottomLeft,
        iconSize: 30,
        isExpanded: true,
        focusColor: const Color(0xffEBEBEB),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        validator: validator,
        value: value,
        style: Theme.of(context).textTheme.headline5!.copyWith(
              fontSize: 18,
            ),
        hint: Text(
          hint,
          style: Theme.of(context).textTheme.headline5!.copyWith(
                fontSize: 18,
              ),
        ),
        items: dropItems
            .map(
              (value) => DropdownMenuItem<String?>(
                value: value,
                child: Text(
                  value,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontSize: 15),
                ),
              ),
            )
            .toList(),
        onChanged: enable ? onChanged : null,
      ),
    );
  }
}
