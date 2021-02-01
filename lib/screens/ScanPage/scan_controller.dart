import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcode_client/constants.dart';
import 'package:qrcode_client/models/verification_model.dart';

class ScanController extends ChangeNotifier {
  StreamSubscription cameraStreamSubscription;
  Stream cameraStream;

  bool isValid = false;
  bool hasLoadedCode = false;
  bool hasError = false;

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

  void checkIfValid(String data) async {
    try {
      var response = await http.get("$kAPIBaseUrl/seed/$data");

      if (response.statusCode == 200) {
        VerificationModel verification =
            VerificationModel.fromJson(jsonDecode(response.body));

        isValid = verification.isValid;
        hasLoadedCode = true;
      } else {
        hasError = true;
        hasLoadedCode = true;
      }
    } catch (_) {
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
