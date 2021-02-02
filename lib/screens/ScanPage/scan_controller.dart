import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcode_client/interfaces/scan_repository_interface.dart';
import 'package:qrcode_client/models/verification_model.dart';

class ScanController extends ChangeNotifier {
  StreamSubscription cameraStreamSubscription;
  Stream cameraStream;

  bool isValid = false;
  bool hasLoadedCode = false;
  bool hasError = false;

  final IScanRepository repository = GetIt.I.get<IScanRepository>();

  void scanAgain() {
    // The stream is recreated whenever
    // the uses tap on the "scan again" button.
    hasLoadedCode = false;
    hasError = false;
    notifyListeners();

    // The stream is destroyed and recreated
    // so that when it's scanned again,
    // the last value found isn't kept,
    // thus starting from scratch.
    cameraStreamSubscription = cameraStream.listen(handleStreamListener);
  }

  void handleStreamListener(event) {
    checkIfValid(event.code);

    // The stream is canceled when a value is detected
    // to avoid multiple API calls.
    cameraStreamSubscription.cancel();
  }

  void onQRViewCreated(QRViewController controller) async {
    cameraStream = controller.scannedDataStream.asBroadcastStream();

    cameraStreamSubscription = cameraStream.listen(handleStreamListener);
  }

  Future<void> checkIfValid(String data) async {
    try {
      VerificationModel verificationModel =
          await repository.validateQRCode(data);

      isValid = verificationModel.isValid;
      hasLoadedCode = true;
    } catch (e) {
      // If for some reason the API call wasn't successful,
      // a message will be displayed to the user indicating so.
      hasError = true;
      hasLoadedCode = true;
    }

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    cameraStreamSubscription.cancel();
  }
}
