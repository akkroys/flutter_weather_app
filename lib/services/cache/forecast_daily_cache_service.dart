import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/forecast_daily_data.dart';

class ForecastDailyCacheService {
  static const _dailyForecastKey = 'cached_daily_forecast_data';

  static Future<void> cacheDailyForecastData(ForecastDailyData forecastDailyData) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonForecastDailyData = jsonEncode(forecastDailyData.toJson());
    await prefs.setString(_dailyForecastKey, jsonForecastDailyData);
  }

  static Future<ForecastDailyData?> getCachedDailyForecastData() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_dailyForecastKey);
    if (cachedData != null) {
      final decodedData = jsonDecode(cachedData);
      return ForecastDailyData.fromJson(decodedData);
    }
    return null;
  }
}