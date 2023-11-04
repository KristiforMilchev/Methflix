import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  //General Color Properties
  double height;
  double borderRadius;
  Color backgroundC1;
  Color backgroundC2;
  double radialRadius;
  Color cursorColor;
  Color textColor;

  //Text Specific properties
  String textFontFamily;
  double fontSize;
  FontWeight fontWeight;
  TextAlign textAlign;
  double letterSpacing;

  //Label Specific properties
  String floatingLabel;
  Color labelColor;
  FloatingLabelAlignment labelAlignment;

  //Border Specific properties
  Color borderRegularColor;
  Color borderFocusedColor;
  Function onChange;
  bool labelCenter;
  bool isObscured;
  Widget? innerButon;
  Widget? prefixIcon;
  List<TextInputFormatter> formatters;
  String? hint;
  TextEditingController? controller;
  bool enabled;
  bool isClickable;
  TextInputType? restricted;
  FocusNode? textFocusNode;
  Function? submitted;
  CustomTextField({
    super.key,
    this.enabled = true,
    this.height = 56,
    this.borderRadius = 10,
    this.backgroundC1 = const Color.fromRGBO(0, 0, 0, 0.2),
    this.backgroundC2 = const Color.fromRGBO(0, 0, 0, 0),
    this.radialRadius = 25,
    this.cursorColor = const Color.fromRGBO(255, 255, 255, 0.2),
    this.textColor = Colors.white,
    this.textFontFamily = "Loto",
    this.fontSize = 18,
    this.letterSpacing = 1.26,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.center,
    this.labelCenter = false,
    required this.floatingLabel,
    this.labelColor = const Color.fromRGBO(255, 255, 255, 0.72),
    this.labelAlignment = FloatingLabelAlignment.center,
    this.borderRegularColor = const Color.fromRGBO(255, 255, 255, 0.5),
    this.borderFocusedColor = const Color.fromRGBO(255, 215, 214, 0.1),
    required this.onChange,
    this.isObscured = false,
    this.innerButon,
    this.formatters = const [],
    this.hint,
    this.controller,
    this.prefixIcon,
    this.restricted,
    this.isClickable = true,
    this.textFocusNode,
    this.submitted,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (!enabled)
          Center(
            child: Text(
              controller?.text ?? "",
              style: TextStyle(
                color: textColor,
                fontFamily: textFontFamily,
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        TextField(
          onSubmitted: (str) {
            submitted?.call(str);
          },
          focusNode: textFocusNode,
          keyboardType: restricted,
          controller: !enabled ? TextEditingController(text: " ") : controller,
          onChanged: (value) => onChange.call(value),
          textAlign: TextAlign.center,
          cursorColor: cursorColor,
          cursorWidth: 1,
          obscureText: isObscured,
          enabled: enabled,
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: formatters,
          style: TextStyle(
            color: textColor,
            fontFamily: textFontFamily,
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(20),
            alignLabelWithHint: true,
            floatingLabelAlignment: FloatingLabelAlignment.center,
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isClickable
                    ? ThemeStyles.accent100
                    : ThemeStyles.text200.withAlpha(60),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: hint,
            prefixIcon: prefixIcon != null && textAlign != TextAlign.center
                ? prefixIcon
                : null,
            suffixIcon: innerButon,
            filled: true,
            fillColor: backgroundC1,
            label: !isClickable
                ? Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (prefixIcon != null)
                          Row(
                            children: [
                              prefixIcon!,
                              const SizedBox(width: 12),
                            ],
                          ),
                        Text(
                          floatingLabel,
                          textAlign: textAlign,
                          style: ThemeStyles.innerHeadingOv(
                            color: isClickable
                                ? labelColor
                                : labelColor.withAlpha(60),
                            fontSize: fontSize,
                            weight: FontWeight.w400,
                            letterSpacing: letterSpacing,
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(
                    floatingLabel,
                    textAlign: textAlign,
                    style: ThemeStyles.innerHeadingOv(
                      color:
                          isClickable ? labelColor : labelColor.withAlpha(60),
                      fontSize: fontSize,
                      weight: FontWeight.w400,
                      letterSpacing: letterSpacing,
                    ),
                  ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide(
                color: borderRegularColor,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide(
                color: borderFocusedColor,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
