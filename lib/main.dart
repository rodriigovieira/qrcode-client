import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(QRCodeApp());
}

class QRCodeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      floatingActionButton: SpeedDialButtons(),
    );
  }
}

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

class FABWithAnimation extends StatelessWidget {
  const FABWithAnimation({
    Key key,
    @required this.controller,
    @required this.icon,
  }) : super(key: key);

  final AnimationController controller;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: ScaleTransition(
        scale: CurvedAnimation(
          parent: controller,
          curve: Interval(
            0.0,
            0.5,
            curve: Curves.easeOut,
          ),
        ),
        child: FloatingActionButton(
          heroTag: null,
          mini: true,
          child: Icon(icon),
          onPressed: () {},
        ),
      ),
    );
  }
}
