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

  void scanAgain() {
    hasLoadedCode = false;
    notifyListeners();

    cameraStreamSubscription = cameraStream.listen((event) {
      checkIfValid(event.code);
      cameraStreamSubscription.cancel();
    });
  }

  void onQRViewCreated(QRViewController controller) async {
    cameraStream = controller.scannedDataStream.asBroadcastStream();

    cameraStreamSubscription = cameraStream.listen((event) {
      checkIfValid(event.code);
      cameraStreamSubscription.cancel();
    });
  }

  void checkIfValid(String data) async {
    var response = await http.get("$kAPIBaseUrl/seed/$data");

    if (response.statusCode == 200) {
      VerificationModel verification =
          VerificationModel.fromJson(jsonDecode(response.body));

      isValid = verification.isValid;
      hasLoadedCode = true;

      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    cameraStreamSubscription.cancel();
  }
}
