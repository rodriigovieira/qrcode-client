import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qrcode_client/interfaces/qr_code_repository_interface.dart';
import 'package:qrcode_client/models/seed_model.dart';

class QRCodeController extends ChangeNotifier {
  final IQRCodeRepository repository = GetIt.I.get<IQRCodeRepository>();

  Timer countdownTimer;

  bool loading = false;
  bool hasError = false;
  String seed = "";
  int secondsLeft = 0;

  QRCodeController() {
    handleLoading();
  }

  void updateTimeLeft() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
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
      SeedModel seedModel = await repository.getSeed();

      DateTime expireDate = DateTime.parse(seedModel.expiresAt);
      Duration timeLeft = expireDate.difference(DateTime.now());

      loading = false;
      seed = seedModel.seed;
      secondsLeft = timeLeft.inSeconds;

      notifyListeners();

      updateTimeLeft();
    } catch (e) {
      loading = false;
      hasError = true;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    countdownTimer.cancel();
    super.dispose();
  }
}
