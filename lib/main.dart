import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_client/interfaces/http_client_interface.dart';
import 'package:qrcode_client/screens/HomePage/home_page.dart';
import 'package:qrcode_client/screens/QRCodePage/qr_code_controller.dart';
import 'package:qrcode_client/screens/QRCodePage/qr_code_page.dart';
import 'package:qrcode_client/screens/ScanPage/scan_controller.dart';
import 'package:qrcode_client/screens/ScanPage/scan_page.dart';
import 'package:qrcode_client/services/http_client.dart';

void main() {
  runApp(QRCodeApp());
}

class QRCodeApp extends StatelessWidget {
  final IClientHttp httpClient = ClientHttpService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => QRCodeController(
            httpClient: httpClient,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ScanController(
            httpClient: httpClient,
          ),
        ),
      ],
      child: MaterialApp(
        routes: {
          HomePage.pageId: (_) => HomePage(),
          ScanPage.pageId: (_) => ScanPage(),
          QRCodePage.pageId: (_) => QRCodePage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
