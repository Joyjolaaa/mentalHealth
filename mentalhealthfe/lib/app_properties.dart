// ignore_for_file: unused_import

import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';

const Color green = Color.fromARGB(255, 52, 87, 147);
const Color darkGrey = Color(0xFF333333);

const LinearGradient mainButton = LinearGradient(
  colors: [
    Color.fromARGB(255, 19, 216, 242),
    Color(0xff23aa49),
    Color.fromRGBO(87, 231, 9, 1),
  ],
  begin: FractionalOffset.topCenter,
  end: FractionalOffset.bottomCenter,
);

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6),
];

double screenAwareSize(int size, BuildContext context) {
  double baseHeight = 640.0;
  return size * MediaQuery.of(context).size.height / baseHeight;
}

const Color kPrimaryColor = Color(0xFF53B175);
const Color kShadowColor = Color(0xFFA8A8A8);
const Color kBlackColor = Color(0xFF181725);
const Color kSubtitleColor = Color(0xFF7C7C7C);
const Color kSecondaryColor = Color(0xFFF2F3F2);
const Color kBorderColor = Color(0xFFE2E2E2);
const Color kAddedColor = Color(0xff23aa49);

const TextStyle kTitleStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
  color: kBlackColor,
);

const TextStyle kDescriptionStyle = TextStyle(
  color: kSubtitleColor,
  fontSize: 13,
);

class MQuery {
  static double width = 0.0;
  static double height = 0.0;

  void init(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    width = mediaQueryData.size.width;
    height = mediaQueryData.size.height;
  }
}

double baseWidth = 390;
double baseHeight = 844;
double fem = 0.0;
double ffem = 0.0;

double availableHeight = 0.0;
double responsiveHeight = 0.0;
