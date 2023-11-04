import 'package:flutter/material.dart';

class ThemeStyles {
  static double? width;
  static double? height;
  // Primary Colors
  static Color primary100 = Color(0xFF1A237E);
  static Color primary200 = Color(0xFF534bae);
  static Color primary300 = Color(0xFFb8a6ff);

  // Accent Colors
  static Color accent100 = Color(0xFFFF4081);
  static Color accent200 = Color(0xFFFFE4FF);

  // Text Colors
  static Color text100 = Color(0xFFFFFFFF);
  static Color text200 = Color(0xFFE0E0E0);

  // Background Colors
  static Color background100 = Color(0xFF0F1C3F);
  static Color background200 = Color(0xFF212B50);
  static Color background300 = Color(0xFF3B426A);

  static TextStyle regularHeading = TextStyle(
    color: text200,
    letterSpacing: 2,
    fontSize: width != null ? 20 : 18,
    fontFamily: "Loto",
    fontWeight: FontWeight.w500,
  );

  static TextStyle regularParagraph = TextStyle(
    color: text200,
    fontSize: width != null ? 14 : 12,
    letterSpacing: 2,
    fontFamily: "Loto",
    fontWeight: FontWeight.w400,
  );

  static TextStyle whiteParagraph = TextStyle(
    color: text200,
    fontSize: width != null ? 14 : 12,
    letterSpacing: 2,
    fontFamily: "Loto",
    fontWeight: FontWeight.w400,
  );

  static TextStyle regularInnerHeading = TextStyle(
    color: text200,
    fontSize: 18,
    letterSpacing: 2,
    fontFamily: "Loto",
    fontWeight: FontWeight.w500,
  );

  static var darkBtnSolid = Color(0xFF151515);

  // Overrides
  static TextStyle regularParagraphOv({
    Color color = const Color(0xFFE0E0E0),
    double? lineSpacing,
    double? size,
    FontWeight? weight,
    TextDecoration? decoration,
    double scaleFactor = 2,
    bool scaleOnFactor = false,
  }) {
    if (width != null && width! <= 360) {
      switch (scaleOnFactor) {
        case true:
          return TextStyle(
            color: color,
            fontSize: size != null ? size / scaleFactor : 10,
            height: lineSpacing,
            letterSpacing: 2,
            fontFamily: "Loto",
            fontWeight: weight ?? FontWeight.w400,
            decoration: decoration,
            decorationColor: color,
          );

        case false:
          return TextStyle(
            color: color,
            fontSize: size != null ? size - 2 : 10,
            height: lineSpacing,
            letterSpacing: 2,
            fontFamily: "Loto",
            fontWeight: weight ?? FontWeight.w400,
            decoration: decoration,
            decorationColor: color,
          );
      }
    } else {
      return TextStyle(
        color: color,
        fontSize: size ?? 12,
        height: lineSpacing,
        letterSpacing: 2,
        fontFamily: "Loto",
        fontWeight: weight ?? FontWeight.w400,
        decoration: decoration,
        decorationColor: color,
      );
    }
  }

  static TextStyle innerHeadingOv({
    Color color = const Color(0xFFFFFFFF),
    double? lineSpacing,
    double? letterSpacing,
    FontWeight? weight,
    double? fontSize,
  }) {
    if (width != null && width! <= 360) {
      return TextStyle(
        color: color,
        fontSize: fontSize != null ? fontSize - 2 : 16,
        height: lineSpacing,
        letterSpacing: letterSpacing ?? 2,
        fontFamily: "Loto",
        fontWeight: weight ?? FontWeight.w400,
      );
    } else {
      return TextStyle(
        color: color,
        fontSize: fontSize ?? 18,
        height: lineSpacing,
        letterSpacing: letterSpacing ?? 2,
        fontFamily: "Loto",
        fontWeight: weight ?? FontWeight.w400,
      );
    }
  }

  static double adjustDistanceReverse(
      BuildContext context, double scaleFactor) {
    return MediaQuery.of(context).size.width <= 360 ? 3.5 : scaleFactor;
  }

  static double adjustDistance(BuildContext context, double scaleFactor) {
    return MediaQuery.of(context).size.width <= 360
        ? scaleFactor / 2
        : scaleFactor;
  }

  static double adjustDistanceHeight(BuildContext context, double scaleFactor) {
    var height = MediaQuery.of(context).size.height <= 900
        ? scaleFactor / 4
        : scaleFactor;

    return height;
  }
}
