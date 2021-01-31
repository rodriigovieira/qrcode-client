import 'package:flutter/material.dart';

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
