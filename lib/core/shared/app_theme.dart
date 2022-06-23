import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme = ThemeData.light().copyWith(
  canvasColor: const Color.fromRGBO(63, 55, 201, 1),
  backgroundColor: Colors.grey.withOpacity(.2),
  hoverColor: const Color.fromRGBO(72, 149, 239, 1),
  cardColor: Colors.white,
  textTheme: textTheme,
);

TextTheme textTheme = ThemeData.light().textTheme.copyWith(
      headlineSmall: ThemeData.light().textTheme.headlineSmall!.copyWith(
            color: Colors.white60,
            fontSize: 26,
          ),
      headlineMedium: ThemeData.light().textTheme.headlineMedium!.merge(
            GoogleFonts.montserrat(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
      displaySmall: ThemeData.light().textTheme.displaySmall!.merge(
            GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
      bodyMedium: ThemeData.light().textTheme.bodySmall!.merge(
            GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
            ),
          ),
      labelLarge: ThemeData.light().textTheme.labelLarge!.merge(
            GoogleFonts.nunito(
              fontWeight: FontWeight.w700,
            ),
          ),
    );
