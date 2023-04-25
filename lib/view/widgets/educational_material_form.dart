import 'package:flutter/material.dart';

class EducationalMaterialForm extends StatelessWidget {
  const EducationalMaterialForm({
    Key? key,
    required this.materialName,
    required this.screenHeight,
    required this.screenWidth,
    required this.onTap,
  }) : super(key: key);
  final String materialName;
  final double screenHeight;
  final double screenWidth;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: screenHeight * .0073, horizontal: screenWidth * .0121),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            12,
          )),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/book_icon.png',
            ),
            SizedBox(
              height: screenHeight * .0164,
            ),
            Text(
              materialName,
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
              textScaleFactor: .9,
            ),
          ],
        ),
      ),
    );
  }
}
