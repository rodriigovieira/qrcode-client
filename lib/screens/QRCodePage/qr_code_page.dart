import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_client/constants.dart';
import 'package:qrcode_client/models/seed_model.dart';

class QRCodePage extends StatefulWidget {
  static const String pageId = "/qr_code_page";

  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  bool loading = false;
  String seed = "";
  int secondsLeft = 0;

  void updateTimeLeft() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsLeft < 1) {
        timer.cancel();
        handleLoading();
        return;
      }

      setState(() {
        secondsLeft--;
      });
    });
  }

  void handleLoading() async {
    setState(() {
      loading = true;
    });

    var response = await get("$kAPIBaseUrl/seed");

    if (response.statusCode == 200) {
      SeedModel data = SeedModel.fromJson(jsonDecode(response.body));

      DateTime expireDate = DateTime.parse(data.expiresAt);
      Duration timeLeft = expireDate.difference(DateTime.now());

      setState(() {
        loading = false;
        seed = data.seed;
        secondsLeft = timeLeft.inSeconds;
      });

      updateTimeLeft();
    }
  }

  @override
  void initState() {
    handleLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(title: Text("QR Code")),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              version: QrVersions.auto,
              size: 320,
              gapless: false,
              data: seed,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$secondsLeft\s",
                style: TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
