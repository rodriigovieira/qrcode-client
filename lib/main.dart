import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:qrcode_client/interfaces/http_client_interface.dart';
import 'package:qrcode_client/screens/HomePage/home_page.dart';
import 'package:qrcode_client/screens/QRCodePage/qr_code_controller.dart';
import 'package:qrcode_client/screens/QRCodePage/qr_code_page.dart';
import 'package:qrcode_client/screens/ScanPage/scan_controller.dart';
import 'package:qrcode_client/screens/ScanPage/scan_page.dart';
import 'package:qrcode_client/services/http_client.dart';

void main() {
  GetIt getIt = GetIt.I;

  getIt.registerSingleton<IClientHttp>(ClientHttpService());
  
  runApp(QRCodeApp());
}

class QRCodeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => QRCodeController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ScanController(),
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
