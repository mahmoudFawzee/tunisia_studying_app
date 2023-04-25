import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  fontFamily: 'ElMessiri',
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
    textStyle: MaterialStateProperty.all(
      const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontFamily: 'ElMessiri',
        fontWeight: FontWeight.w400,
      ),
    ),
  )),
  textTheme:const TextTheme(
    button:  TextStyle(
      color: Colors.white,
      fontFamily: 'ElMessiri',
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    //headline2 color: red
    //headline3 size : 13
    //headline4 size : 15
    //headline6 size : 18
    //*it will be used in the text which in the buttons text and app bar
    headline5:  TextStyle(
      color: Colors.black,
      //fontFamily: 'ElMessiri',
      fontWeight: FontWeight.w400,
      fontSize: 20,
    ),
    // labelSmall: const TextStyle(
    //   fontWeight: FontWeight.w200,
    //   fontSize: 15,
    //   color: Colors.grey,
    // ),
    //*it will be used in the text which in the body of the scaffold
  ),
);
