import 'package:flutter/material.dart';
import 'package:weather_app/data/search_city_data.dart';
import 'package:weather_app/data/weather_data.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/screens/city_weather_screen.dart';
import 'package:weather_app/services/city_weather_service.dart';
import 'package:weather_app/services/search_city_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final SearchCityService _searchCityService;
  final TextEditingController _searchController = TextEditingController();
  final List<SearchCityData> _searchResults = [];

  @override
  void initState() {
    _searchCityService = SearchCityService();
    super.initState();
  }

  void _searchCity() async {
    String cityName = _searchController.text;
    try {
      List<SearchCityData> results =
          await _searchCityService.searchCity(cityName);
      setState(() {
        _searchResults.clear();
        _searchResults.addAll(results);
      });
      if (_searchResults.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${S.current.search_result_null} $cityName'),
          ),
        );
      }
    } catch (e) {
      print('Error searching city: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.search),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: S.current.enter_city_name,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _searchCity,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_searchResults[index].name),
                  subtitle: Text(
                      '${_searchResults[index].country}, ${_searchResults[index].state}'),
                  onTap: () async {
                    double latitude = _searchResults[index].lat;
                    double longitude = _searchResults[index].lon;
                    try {
                      WeatherData weatherData = await CityWeatherService()
                          .getWeather(latitude, longitude);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityWeatherScreen(weatherData),
                        ),
                      );
                    } catch (e) {
                      print('Error fetching weather data: $e');
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
