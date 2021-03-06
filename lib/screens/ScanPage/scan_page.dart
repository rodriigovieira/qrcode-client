import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_client/screens/ScanPage/components/qr_code_with_refresh.dart';
import 'package:qrcode_client/screens/ScanPage/scan_controller.dart';

class ScanPage extends StatelessWidget {
  static const String pageId = "/scan_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Scan the QR Code to check whether it's still valid or not.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 4,
            child: Center(
              child: Container(
                height: 300,
                width: 300,
                child: QRCodeWithRefresh(),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Consumer<ScanController>(builder: (
              BuildContext context,
              ScanController controller,
              Widget child,
            ) {
              if (controller.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "The call to the server failed. Please try again later or check your network connection.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.red),
                  ),
                );
              }
              
              return Visibility(
                visible: controller.hasLoadedCode,
                child: Text(
                  controller.isValid
                      ? "The QR Code is valid!"
                      : "The QR Code is not valid!",
                  style: TextStyle(
                    color: controller.isValid ? Colors.green : Colors.red,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
