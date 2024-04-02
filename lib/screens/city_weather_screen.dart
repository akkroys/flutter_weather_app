import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/weather_data.dart';
import 'package:weather_app/generated/l10n.dart';

class CityWeatherScreen extends StatefulWidget {
  final WeatherData weatherData;

  const CityWeatherScreen(this.weatherData, {super.key});

  @override
  _CityWeatherScreenState createState() => _CityWeatherScreenState();
}

class _CityWeatherScreenState extends State<CityWeatherScreen> {
  late WeatherData _weatherData;

  @override
  void initState() {
    super.initState();
    _weatherData = widget.weatherData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _weatherData.name),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildUpdateTime(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                '${_weatherData.main.temp.toStringAsFixed(0)}°${S.of(context).temp_units}',
                style: const TextStyle(
                  fontSize: 80,
                  fontWeight: FontWeight.w200,
                ),
              ),
              _buildWeatherIcon(_weatherData.weather[0].icon),
              const SizedBox(height: 20),
              Text(
                  '${S.of(context).feels_like}${_weatherData.main.feelsLike.toStringAsFixed(0)}°${S.of(context).temp_units}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherIcon(String iconCode) {
    return Image.network(
      'http://openweathermap.org/img/wn/$iconCode@4x.png',
      width: 300,
      height: 300,
    );
  }

  Widget _buildUpdateTime() {
    DateTime? dateTime;
    String formattedTime = '';
    dateTime = DateTime.fromMillisecondsSinceEpoch(_weatherData.dt * 1000);
    formattedTime = DateFormat('HH:mm').format(dateTime);
      return Text('${S.of(context).updated}: $formattedTime');
  }
}
