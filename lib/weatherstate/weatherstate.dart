import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class RealTimeClock extends StatefulWidget {
  final TextStyle? textStyle; // Optional style for customization

  const RealTimeClock({Key? key, this.textStyle}) : super(key: key);

  @override
  _RealTimeClockState createState() => _RealTimeClockState();
}

class _RealTimeClockState extends State<RealTimeClock> {
  late Timer _timer;
  String _formattedTime = '';

  @override
  void initState() {
    super.initState();
    _updateTime(); // Initial time update
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      _updateTime();
    });
  }

  void _updateTime() {
    setState(() {
      _formattedTime = DateFormat('EEEE, MMM d, HH:mm:ss').format(DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formattedTime,
      style: widget.textStyle ?? 
        TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}