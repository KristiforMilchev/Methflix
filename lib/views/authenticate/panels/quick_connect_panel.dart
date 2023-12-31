import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QuickConnectPanel extends StatelessWidget {
  const QuickConnectPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ThemeStyles.background200,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: ThemeStyles.background300,
              ),
              child: QrImageView(
                data: "test",
                size: ThemeStyles.height! / 2.4,
                eyeStyle: QrEyeStyle(
                  color: ThemeStyles.accent200,
                  eyeShape: QrEyeShape.square,
                ),
                foregroundColor: ThemeStyles.accent200,
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: ThemeStyles.background300,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 12),
                          Icon(
                            Icons.phone_android,
                            color: ThemeStyles.primary300,
                            size: 80,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Open the Metflix Mobile App",
                            style: ThemeStyles.regularParagraphOv(
                              color: ThemeStyles.text100,
                              size: 16,
                              weight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              "If you haven't installed the Metflix mobile app on your smartphone or tablet yet, download it from your device's app store.",
                              style: ThemeStyles.regularParagraphOv(
                                color: ThemeStyles.text200,
                                size: 12,
                                weight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: ThemeStyles.background300,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 12),
                          Icon(
                            Icons.wifi_password_rounded,
                            color: ThemeStyles.primary300,
                            size: 80,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Press to Authenticate",
                            style: ThemeStyles.regularParagraphOv(
                              color: ThemeStyles.text100,
                              size: 16,
                              weight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              "Look for the central button in the bottom navigation bar of the Metflix mobile app. Tap on it to activate to authenticate",
                              style: ThemeStyles.regularParagraphOv(
                                color: ThemeStyles.text200,
                                size: 12,
                                weight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: ThemeStyles.background300,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 12),
                          Icon(
                            Icons.qr_code_scanner_rounded,
                            color: ThemeStyles.primary300,
                            size: 80,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Scan and Authenticate",
                            style: ThemeStyles.regularParagraphOv(
                              color: ThemeStyles.text100,
                              size: 16,
                              weight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              "Hold your mobile device steady, and align the camera with the QR code displayed on your TV screen.",
                              style: ThemeStyles.regularParagraphOv(
                                color: ThemeStyles.text200,
                                size: 12,
                                weight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
