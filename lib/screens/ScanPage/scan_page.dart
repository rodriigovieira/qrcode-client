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
          Text(
            "Scan the QR Code to check whether it's still valid or not.",
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
          Consumer<ScanController>(builder: (
            BuildContext context,
            ScanController controller,
            Widget child,
          ) {
            return Expanded(
              flex: 1,
              child: Visibility(
                visible: controller.hasLoadedCode,
                child: Text(
                  controller.isValid
                      ? "The QR Code is valid!"
                      : "The QR Code is not valid!",
                  style: TextStyle(
                    color: controller.isValid ? Colors.green : Colors.red,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
