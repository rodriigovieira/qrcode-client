import 'package:flutter/material.dart';
import 'package:qrcode_client/screens/HomePage/components/speed_dial_buttons.dart';


class HomePage extends StatefulWidget {
  static const String pageId = "/";
  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      floatingActionButton: SpeedDialButtons(),
    );
  }
}
