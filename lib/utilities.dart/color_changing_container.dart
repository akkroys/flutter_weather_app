import 'package:flutter/material.dart';
import 'dart:async';

class ColorChangingContainer extends StatefulWidget {
  final double height;

  const ColorChangingContainer({
    super.key,
    required this.height,
  });

  @override
  _ColorChangingContainerState createState() => _ColorChangingContainerState();
}

class _ColorChangingContainerState extends State<ColorChangingContainer> {
  bool _isGrey = true;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(milliseconds: 700), (timer) {
      setState(() {
        _isGrey = !_isGrey;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      height: widget.height,
      decoration: BoxDecoration(
        color: _isGrey ? Colors.grey[500] : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
