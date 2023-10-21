import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class NfcMissing extends StatelessWidget {
  const NfcMissing({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RiveAnimation.asset(
          fit: BoxFit.contain,
          "packages/domain/assets/animations/attention.riv",
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              "It appears there is a problem",
              style: ThemeStyles.regularParagraphOv(
                color: ThemeStyles.acentColor,
                size: 20,
                weight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                "We are sad to inform you that Findpaw requires NFC technology for writing and scanning pet tags. Unfortunately, your current device lacks NFC compatibility, limiting this crucial feature.",
                style: ThemeStyles.regularParagraphOv(
                  color: ThemeStyles.secondAccent,
                  size: 15,
                  weight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                "Without NFC, you won't be able to write or scan pet tags, affecting your ability to manage your pet's information effectively.",
                style: ThemeStyles.regularParagraphOv(
                  color: ThemeStyles.secondAccent,
                  size: 15,
                  weight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                "For the best experience, consider upgrading to an NFC-enabled device.",
                style: ThemeStyles.regularParagraphOv(
                  color: ThemeStyles.secondAccent,
                  size: 15,
                  weight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                "If you have any questions, please contact:",
                style: ThemeStyles.regularParagraphOv(
                  color: ThemeStyles.secondAccent,
                  size: 15,
                  weight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(
                "support@findpaw.com",
                style: ThemeStyles.regularParagraphOv(
                  color: ThemeStyles.acentColor,
                  size: 15,
                  weight: FontWeight.bold,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        )
      ],
    );
  }
}
