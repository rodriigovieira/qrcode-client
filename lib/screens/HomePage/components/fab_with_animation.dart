import 'package:flutter/material.dart';

class FABWithAnimation extends StatelessWidget {
  const FABWithAnimation({
    Key key,
    @required this.controller,
    @required this.icon,
    @required this.onPressed,
    @required this.label,
  }) : super(key: key);

  final AnimationController controller;
  final IconData icon;
  final Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ScaleTransition(
          child: Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(6),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
              child: Text(label),
            ),
          ),
          scale: CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.5,
              curve: Curves.easeOut,
            ),
          ),
        ),
        SizedBox(width: 8),
        Container(
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
              onPressed: onPressed,
            ),
          ),
        ),
      ],
    );
  }
}
