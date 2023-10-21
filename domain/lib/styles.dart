import 'package:flutter/material.dart';

class ThemeStyles {
  static double? width;
  static double? height;

  static Color faintWhite = const Color.fromRGBO(
    255,
    255,
    255,
    0.54,
  );

  static Color mainColor = const Color.fromRGBO(14, 41, 84, 1);
  static Color secondaryColor = const Color.fromRGBO(31, 110, 140, 1);
  static Color acentColor = const Color.fromRGBO(46, 138, 153, 1);
  static Color secondAccent = const Color.fromRGBO(132, 167, 161, 1);

  static TextStyle regularHeading = TextStyle(
    color: const Color.fromRGBO(255, 255, 255, 1),
    letterSpacing: 2,
    fontSize: width != null ? 20 : 18,
    fontFamily: "Loto",
    fontWeight: FontWeight.w500,
  );

  static TextStyle regularParagraph = TextStyle(
    color: const Color.fromRGBO(255, 255, 255, 0.72),
    fontSize: width != null ? 14 : 12,
    letterSpacing: 2,
    fontFamily: "Loto",
    fontWeight: FontWeight.w400,
  );

  static TextStyle whiteParagraph = TextStyle(
    color: const Color.fromRGBO(255, 255, 255, 1),
    fontSize: width != null ? 14 : 12,
    letterSpacing: 2,
    fontFamily: "Loto",
    fontWeight: FontWeight.w400,
  );

  static TextStyle regularInnerHeading = const TextStyle(
    color: Color.fromRGBO(255, 255, 255, 1),
    fontSize: 18,
    letterSpacing: 2,
    fontFamily: "Loto",
    fontWeight: FontWeight.w500,
  );

  static var darkBtnSolid = const Color.fromRGBO(21, 21, 21, 1);

  static BoxDecoration getDesktopGradient(Alignment start, Alignment end,
      {Color c1 = const Color.fromRGBO(21, 155, 222, 0.24),
      Color c2 = const Color.fromRGBO(21, 155, 222, 0.00),
      List<double> stops = const [0.1, 0.9]}) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          c1,
          c2,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        tileMode: TileMode.clamp,
      ),
    );
  }

  //Ovverides
  static TextStyle regularParagraphOv({
    Color color = Colors.white,
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

          break;
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

          break;
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
    Color color = Colors.white,
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
