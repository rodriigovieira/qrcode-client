import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodePage extends StatelessWidget {
  static const String pageId = "/qr_code_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code"),
      ),
      body: Center(
        child: QrImage(
          version: QrVersions.auto,
          size: 320,
          gapless: false,
          data: "test",
        ),
      ),
    );
  }
}
