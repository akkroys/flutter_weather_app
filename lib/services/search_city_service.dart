import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/constants.dart';
import 'package:weather_app/data/search_city_data.dart';

class SearchCityService {
Future<List<SearchCityData>> searchCity(String cityName) async {
    final String apiUrl =
        'http://api.openweathermap.org/geo/1.0/direct?q=$cityName&limit=5&appid=$WEATHER_API_KEY';

    final response = await http.get(Uri.parse(apiUrl));
    print('JSON city searching Response: ${response.body}');
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      List<SearchCityData> searchResults = jsonResponse
          .map((data) => SearchCityData.fromJson(data))
          .toList();
      return searchResults;
    } else {
      throw Exception('Failed to load search results');
    }
  }
}
