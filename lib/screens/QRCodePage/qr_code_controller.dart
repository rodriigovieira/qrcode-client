import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qrcode_client/constants.dart';
import 'package:qrcode_client/models/seed_model.dart';

class QRCodeController extends ChangeNotifier {
  bool loading = false;
  bool hasError = false;
  String seed = "";
  int secondsLeft = 0;

  QRCodeController() {
    handleLoading();
  }

  void updateTimeLeft() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsLeft < 1) {
        timer.cancel();
        handleLoading();
        return;
      }

      secondsLeft--;
      notifyListeners();
    });
  }

  void handleLoading() async {
    loading = true;
    hasError = false;
    notifyListeners();

    var response = await http.get("$kAPIBaseUrl/seed");
    print(response.statusCode);

    if (response.statusCode == 200) {
      SeedModel data = SeedModel.fromJson(jsonDecode(response.body));

      DateTime expireDate = DateTime.parse(data.expiresAt);
      Duration timeLeft = expireDate.difference(DateTime.now());

      loading = false;
      seed = data.seed;
      secondsLeft = timeLeft.inSeconds;

      notifyListeners();

      updateTimeLeft();
    } else {
      hasError = true;
      notifyListeners();
    }
  }
}
