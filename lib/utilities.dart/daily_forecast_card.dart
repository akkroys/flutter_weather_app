import 'package:flutter/material.dart';
import 'package:weather_app/generated/l10n.dart';

class DailyForecastCard extends StatelessWidget {
  final String date;
  final double minTemperature;
  final double maxTemperature;
  final String iconCode;

  const DailyForecastCard({
    super.key,
    required this.date,
    required this.minTemperature,
    required this.maxTemperature,
    required this.iconCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              Text(
                '${maxTemperature.toInt()}°${S.current.temp_units} / ${minTemperature.toInt()}°${S.current.temp_units}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 10),
              ImageIcon(
                AssetImage("assets/weather_icons/$iconCode.png"),
                size: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
