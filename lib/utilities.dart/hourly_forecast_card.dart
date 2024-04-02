import 'package:flutter/material.dart';

class HourlyForecastCard extends StatelessWidget {
  final String time;
  final String iconCode;
  final num temperature;

  HourlyForecastCard({
    required this.time,
    required this.iconCode,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            time,
            style: TextStyle(fontSize: 10),
          ),
          SizedBox(height: 5),
          ImageIcon(
            AssetImage("assets/weather_icons/$iconCode.png"),
            size: 30,
          ),
          SizedBox(height: 5),
          Text(
            '$temperature°C',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
