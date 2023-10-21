import 'package:domain/styles.dart';
import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ThemeStyles.adjustDistance(context, 16),
        ThemeStyles.adjustDistance(context, 32),
        ThemeStyles.adjustDistance(context, 16),
        ThemeStyles.adjustDistance(context, 32),
      ),
      child: const Divider(
        thickness: 1,
        color: Color.fromRGBO(255, 255, 255, 0.36),
      ),
    );
  }
}
