import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_client/screens/QRCodePage/qr_code_controller.dart';

class QRCodePage extends StatelessWidget {
  static const String pageId = "/qr_code_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code"),
      ),
      body: Center(
        child: Consumer<QRCodeController>(builder: (
          BuildContext context,
          QRCodeController controller,
          Widget child,
        ) {
          if (controller.loading) {
            return CircularProgressIndicator();
          }

          if (controller.hasError) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "It was not possible to fetch the QR Code. Please check your network connection or try again later.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    onPressed: controller.handleLoading,
                    child: Text("Try again"),
                  ),
                ],
              ),
            );
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImage(
                version: QrVersions.auto,
                size: 320,
                gapless: false,
                data: controller.seed,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${controller.secondsLeft}s",
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
