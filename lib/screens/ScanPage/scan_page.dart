import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanPage extends StatefulWidget {
  static const String pageId = "/scan_page";

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  void onQRViewCreated(QRViewController controller) async {
    controller.scannedDataStream.listen((Barcode event) {
      print(event.code);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("ae");
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan"),
      ),
      body: Column(
        children: [
          Text(
            "Scan the QR Code to check whether it's still valid or not.",
          ),
          Expanded(
            child: Center(
              child: Container(
                height: 300,
                width: 300,
                child: QRView(
                  onQRViewCreated: onQRViewCreated,
                  key: qrKey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
