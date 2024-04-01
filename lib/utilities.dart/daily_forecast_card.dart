import 'package:flutter/material.dart';

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
                '${maxTemperature.toInt()}°C / ${minTemperature.toInt()}°C',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 10),
              Image.network(
                "http://openweathermap.org/img/wn/$iconCode.png",
                width: 30,
                height: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}