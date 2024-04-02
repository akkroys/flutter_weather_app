import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/forecast_hourly_data.dart';

class ForecastHourlyCacheService {
  static const _hourlyForecastKey = 'cached_hourly_forecast_data';

  static Future<void> cacheHourlyForecastData(ForecastHourlyData forecastHourlyData) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonForecastHourlyData = jsonEncode(forecastHourlyData.toJson());
    await prefs.setString(_hourlyForecastKey, jsonForecastHourlyData);
  }

  static Future<ForecastHourlyData?> getCachedHourlyForecastData() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_hourlyForecastKey);
    if (cachedData != null) {
      final decodedData = jsonDecode(cachedData);
      return ForecastHourlyData.fromJson(decodedData);
    }
    return null;
  }
}