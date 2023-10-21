import 'package:another_flushbar/flushbar.dart';
import 'package:domain/exceptions/base_exception.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/interfaces/iexception_manager.dart';
import 'package:logging/logging.dart';

class ExceptionManager implements IExceptionManager {
  Flushbar? _activeBar;
  final log = Logger('Airzen_Application_Errors');

  @override
  logException(BaseException exception) {
    log.severe(exception.message);
  }

  @override
  Future raisePopup(BaseException exception) async {
    logException(exception);

    if (_activeBar != null) {
      await dismissBar();
    }

    _activeBar ??= Flushbar(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      onStatusChanged: (status) => barStatusChanged(status),
      padding: const EdgeInsets.all(0),
      messageText: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Colors.black,
          ),
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(0),
          child: Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(192, 192, 192, 0.3),
                  Color.fromRGBO(192, 192, 192, 0),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  exception.title ?? "",
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    letterSpacing: 2,
                    fontSize: 20,
                    fontFamily: "Loto",
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Text(
                  exception.message ?? "",
                  style: const TextStyle(
                    color: Color.fromRGBO(255, 255, 255, 0.72),
                    fontSize: 14,
                    letterSpacing: 2,
                    fontFamily: "Loto",
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );

    await _activeBar!.show(exception.context);
  }

  barStatusChanged(FlushbarStatus? status) {
    if (status!.name == "DISMISSED") {
      _activeBar = null;
    }
  }

  dismissBar() async {
    if (_activeBar != null) {
      await _activeBar!.dismiss();
    }
  }
}
