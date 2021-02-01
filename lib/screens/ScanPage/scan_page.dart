import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qrcode_client/constants.dart';

class ScanPage extends StatefulWidget {
  static const String pageId = "/scan_page";

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  StreamSubscription cameraStreamSubscription;
  Stream cameraStream;
  
  bool isValid = false;
  bool hasLoadedCode = false;

  void scanAgain() {
    setState(() {
      hasLoadedCode = false;
    });

    cameraStreamSubscription = cameraStream.listen((event) {
      checkIfValid(event.code);
      cameraStreamSubscription.cancel();
    });
  }

  void onQRViewCreated(QRViewController controller) async {
    cameraStream = controller.scannedDataStream.asBroadcastStream();

    cameraStreamSubscription = cameraStream.listen((event) {
      checkIfValid(event.code);
      cameraStreamSubscription.cancel();
    });
  }

  void checkIfValid(String data) async {
    var response = await get("$kAPIBaseUrl/seed/$data");

    if (response.statusCode == 200) {
      setState(() {
        isValid = response.body == "true";
        hasLoadedCode = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    cameraStreamSubscription.cancel();
  }

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
                child: Stack(
                  children: [
                    Opacity(
                      opacity: hasLoadedCode ? 0.3 : 1,
                      child: QRView(
                        onQRViewCreated: onQRViewCreated,
                        key: qrKey,
                      ),
                    ),
                    Visibility(
                      visible: hasLoadedCode,
                      child: InkWell(
                        onTap: scanAgain,
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
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Visibility(
              visible: hasLoadedCode,
              child: Text(
                isValid ? "The QR Code is valid!" : "The QR Code is not valid!",
                style: TextStyle(
                  color: isValid ? Colors.green : Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
