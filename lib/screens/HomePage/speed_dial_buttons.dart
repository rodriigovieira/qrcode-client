import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:qrcode_client/screens/HomePage/fab_with_animation.dart';

class SpeedDialButtons extends StatefulWidget {
  const SpeedDialButtons({
    Key key,
  }) : super(key: key);

  @override
  _SpeedDialButtonsState createState() => _SpeedDialButtonsState();
}

class _SpeedDialButtonsState extends State<SpeedDialButtons>
    with TickerProviderStateMixin {
  static const List<IconData> icons = const [
    Icons.qr_code,
    Icons.camera_alt,
  ];

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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ...List.generate(icons.length, (int index) {
          return FABWithAnimation(
            controller: _controller,
            icon: icons[index],
          );
        }).toList(),
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
