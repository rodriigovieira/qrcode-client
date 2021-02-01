import 'package:flutter/material.dart';
import 'package:qrcode_client/screens/HomePage/components/fab_with_animation.dart';
import 'dart:math' as math;

import 'package:qrcode_client/screens/QRCodePage/qr_code_page.dart';
import 'package:qrcode_client/screens/ScanPage/scan_page.dart';

class SpeedDialButtons extends StatefulWidget {
  const SpeedDialButtons({
    Key key,
  }) : super(key: key);

  @override
  _SpeedDialButtonsState createState() => _SpeedDialButtonsState();
}

class _SpeedDialButtonsState extends State<SpeedDialButtons>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    super.initState();
  }

  void handleFABPress() {
    if (_controller.isDismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void goToScanPage() {
    Navigator.pushNamed(context, ScanPage.pageId);
  }

  void goToQRCodePage() {
    Navigator.pushNamed(context, QRCodePage.pageId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FABWithAnimation(
          controller: _controller,
          icon: Icons.camera_alt,
          onPressed: goToScanPage,
        ),
        FABWithAnimation(
          controller: _controller,
          icon: Icons.qr_code,
          onPressed: goToQRCodePage,
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: FloatingActionButton(
            heroTag: null,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return Transform(
                  transform:
                      Matrix4.rotationZ(_controller.value * 0.25 * math.pi),
                  alignment: FractionalOffset.center,
                  child: Icon(Icons.add, size: 28),
                );
              },
            ),
            onPressed: handleFABPress,
          ),
        ),
      ],
    );
  }
}
