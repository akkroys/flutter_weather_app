import 'dart:convert';
import 'package:weather_app/constants.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/forecast_daily_data.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/services/location_service.dart';

class ForecastDailyService {
  final LocationService locationService;

  ForecastDailyService(this.locationService);

  Future<ForecastDailyData> getWeather() async {
    try {
      final position = await locationService.getLocation();
      final String apiUrl = 'https://pro.openweathermap.org/data/2.5/forecast/daily?lat=${position.latitude}&lon=${position.longitude}&appid=${WEATHER_API_KEY}&lang=${S.current.language}&units=${S.current.units}';
      final response = await http.get(Uri.parse(apiUrl));
      print('JSON daily Response: ${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        ForecastDailyData weather = ForecastDailyData.fromJson(jsonResponse);
        return weather;
      } else {
        throw Exception('Failed to load daily forecast data');
      }
    } catch (e) {
      print("Error fetching daily forecast: $e");
      throw e;
    }
  }
}