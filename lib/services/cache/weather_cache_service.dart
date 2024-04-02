import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/weather_data.dart';

class WeatherCacheService {
  static const _weatherKey = 'cached_weather_data';

  static Future<void> cacheWeatherData(WeatherData weatherData) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonWeatherData = jsonEncode(weatherData.toJson());
    await prefs.setString(_weatherKey, jsonWeatherData);
  }

  static Future<WeatherData?> getCachedWeatherData() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_weatherKey);
    if (cachedData != null) {
      final decodedData = jsonDecode(cachedData);
      return WeatherData.fromJson(decodedData);
    }
    return null;
  }

    static Future<void> cacheWeatherIcons(List<String> iconUrls) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('cached_weather_icons', iconUrls);
  }

  static Future<List<String>?> getCachedWeatherIcons() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('cached_weather_icons');
  }
}