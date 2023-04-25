import 'package:flutter/material.dart';

class PdfForm extends StatelessWidget {
  const PdfForm({
    super.key,
    required this.name,
    required this.onTap,
  });
  final String name;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.8),
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            name.contains('.pdf') ? name.substring(0, name.length - 4) : name,
          ),
        ),
      ),
    );
  }
}
