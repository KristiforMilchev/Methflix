import 'package:domain/models/authenticated_server.dart';
import 'package:domain/styles.dart';
import 'package:flutter/material.dart';
import 'package:presentation/components/custom_button/custom_button.dart';

class ServerListPanel extends StatelessWidget {
  final List<AuthenticatedServer> servers;
  final int rowIndex;
  final ScrollController controller;

  const ServerListPanel({
    super.key,
    required this.servers,
    required this.rowIndex,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ThemeStyles.background200,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: rowIndex == -1
                    ? ThemeStyles.accent200
                    : ThemeStyles.accent100,
              ),
              child: CustomButton(
                widget: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Connect",
                      style: ThemeStyles.regularParagraphOv(
                        color: rowIndex == -1
                            ? ThemeStyles.accent100
                            : ThemeStyles.accent200,
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Icon(
                      Icons.connected_tv_outlined,
                      size: 24,
                      color: rowIndex == -1
                          ? ThemeStyles.accent100
                          : ThemeStyles.accent200,
                    ),
                  ],
                ),
                callback: () => {},
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: servers.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: ThemeStyles.background300,
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 12),
                          Icon(
                            Icons.connected_tv_rounded,
                            color: rowIndex == index
                                ? ThemeStyles.accent200
                                : ThemeStyles.primary300,
                            size: 80,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            servers[index].name.isEmpty
                                ? servers[index].url
                                : servers[index].name,
                            style: ThemeStyles.regularParagraphOv(
                              color: rowIndex == index
                                  ? ThemeStyles.accent200
                                  : ThemeStyles.text100,
                              size: 16,
                              weight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 5,
                        top: 5,
                        child: Icon(
                          servers[index].isOnline
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: servers[index].isOnline
                              ? ThemeStyles.accent100
                              : ThemeStyles.accent100,
                          size: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
