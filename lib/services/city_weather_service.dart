import 'dart:convert';
import 'package:weather_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/weather_data.dart';
import 'package:weather_app/generated/l10n.dart';

class CityWeatherService {

  Future<WeatherData> getWeather(double latitude, double longitude) async {
    try {
      final String apiUrl = 'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$WEATHER_API_KEY&lang=${S.current.language}&units=${S.current.units}';
      final response = await http.get(Uri.parse(apiUrl));
      print('JSON Response: ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        WeatherData weather = WeatherData.fromJson(jsonResponse);
        return weather;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print("Error fetching city weather: $e");
      throw e;
    }
  }
}
