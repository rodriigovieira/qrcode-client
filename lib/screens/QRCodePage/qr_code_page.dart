import 'package:flutter/material.dart';

class QRCodePage extends StatelessWidget {
  static const String pageId = "/qr_code_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code"),
      ),
    );
  }
}
