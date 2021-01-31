import 'package:flutter/material.dart';
import 'package:qrcode_client/screens/HomePage/home_page.dart';

void main() {
  runApp(QRCodeApp());
}

class QRCodeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
