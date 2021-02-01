import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcode_client/screens/ScanPage/scan_controller.dart';

class QRCodeWithRefresh extends StatelessWidget {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (
        BuildContext context,
        ScanController controller,
        Widget child,
      ) {
        return Stack(
          children: [
            Opacity(
              opacity: controller.hasLoadedCode ? 0.3 : 1,
              child: QRView(
                onQRViewCreated: controller.onQRViewCreated,
                key: qrKey,
              ),
            ),
            Visibility(
              visible: controller.hasLoadedCode,
              child: InkWell(
                onTap: controller.scanAgain,
                child: Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.refresh, size: 28),
                        SizedBox(height: 5),
                        Text("Scan again?"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
