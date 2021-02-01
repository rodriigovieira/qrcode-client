import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qrcode_client/interfaces/http_client_interface.dart';
import 'package:qrcode_client/models/seed_model.dart';
import 'package:qrcode_client/services/http_client.dart';

class QRCodeController extends ChangeNotifier {
  bool loading = false;
  bool hasError = false;
  String seed = "";
  int secondsLeft = 0;

  final IClientHttp httpClient = GetIt.I.get<IClientHttp>();

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

  Future<void> handleLoading() async {
    loading = true;
    hasError = false;
    notifyListeners();

    try {
      var response = await httpClient.get("/seed");

      SeedModel data = SeedModel.fromJson(response);

      DateTime expireDate = DateTime.parse(data.expiresAt);
      Duration timeLeft = expireDate.difference(DateTime.now());

      loading = false;
      seed = data.seed;
      secondsLeft = timeLeft.inSeconds;

      notifyListeners();

      updateTimeLeft();
    } catch (e) {
      loading = false;
      hasError = true;
      notifyListeners();
    }
  }
}
