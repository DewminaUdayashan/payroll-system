import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const seedColor = Color.fromRGBO(43, 45, 66, 1);
const secondaryColor = Color.fromRGBO(141, 153, 174, 1);
const triteryColor = Color.fromRGBO(217, 4, 41, 1);

const loadingColors = [
  Color.fromRGBO(41, 50, 65, 1),
  Color.fromRGBO(61, 90, 128, 1),
  Color.fromRGBO(152, 193, 217, 1),
];

ThemeData appTheme = ThemeData.light().copyWith(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: seedColor,
    secondary: secondaryColor,
    tertiary: triteryColor,
  ),
  textTheme: textTheme,
);

TextTheme textTheme = ThemeData.light().textTheme.copyWith(
      headlineLarge: ThemeData.light().textTheme.headlineLarge!.copyWith(
            color: Colors.black87,
          ),
      headlineSmall: ThemeData.light().textTheme.headlineSmall!.copyWith(),
      headlineMedium: ThemeData.light().textTheme.headlineMedium!.merge(
            GoogleFonts.montserrat(),
          ),
      displaySmall: ThemeData.light().textTheme.displaySmall!.merge(
            GoogleFonts.montserrat(),
          ),
      bodyMedium: ThemeData.light().textTheme.bodySmall!.merge(
            GoogleFonts.montserrat(),
          ),
      labelLarge: ThemeData.light().textTheme.labelLarge!.merge(
            GoogleFonts.nunito(),
          ),
    );
