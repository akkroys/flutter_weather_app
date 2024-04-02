import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/data/forecast_daily_data.dart' as daily;
import 'package:weather_app/data/weather_data.dart';
import 'package:weather_app/data/forecast_hourly_data.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/screens/search_screen.dart';
import 'package:weather_app/services/cache/forecast_daily_cache_service.dart';
import 'package:weather_app/services/cache/forecast_hourly_cache_service.dart';
import 'package:weather_app/services/cache/weather_cache_service.dart';
import 'package:weather_app/services/forecast_daily_service.dart';
import 'package:weather_app/services/forecast_hourly_service.dart';
import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/utilities.dart/color_changing_container.dart';
import 'package:weather_app/utilities.dart/daily_forecast_card.dart';
import 'package:weather_app/utilities.dart/hourly_forecast_card.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final LocationService _locationService;
  late final WeatherService _weatherService;
  late final ForecastHourlyService _forecastHourlyService;
  late final ForecastDailyService _forecastDailyService;
  String? _currentCity;
  WeatherData? _currentWeather;
  ForecastHourlyData? forecastHourlyData;
  daily.ForecastDailyData? forecastDailyData;
  String lastUpdatedMessage = '';
  bool _checkInternet = true;

  @override
  void initState() {
    super.initState();
    _locationService = LocationService();
    _weatherService = WeatherService(_locationService);
    _forecastHourlyService = ForecastHourlyService(_locationService);
    _forecastDailyService = ForecastDailyService(_locationService);
    _checkLocationPermission();
  }

  Future<bool> _checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _checkInternet = true;
        return true;
      }
    } on SocketException catch (_) {
      _checkInternet = false;
      return false;
    }
    _checkInternet = false;

    return false;
  }

  _checkLocationPermission() async {
    bool hasPermission = await _locationService.checkPermission();
    if (hasPermission) {
      _getCurrentLocation();
    } else {
      _requestLocationPermission();
    }
  }

  _getCurrentLocation() {
    _checkInternetConnection().then((hasInternet) {
      if (hasInternet) {
        _locationService.getLocation().then((Position position) {
          setState(() {
            _getAddressFromPosition(position);
            _getCurrentWeather(position.latitude, position.longitude);
            _getHourlyForecast(position.latitude, position.longitude);
            _getDailyForecast(position.latitude, position.longitude);
          });
        }).catchError((error) {
          print(error);
        });
      } else {
        _loadCachedData();
      }
    });
  }

  _loadCachedData() {
    WeatherCacheService.getCachedWeatherData().then((cachedWeather) {
      if (cachedWeather != null) {
        setState(() {
          _currentWeather = cachedWeather;
          _currentCity = cachedWeather.name;
          DateTime lastUpdatedTime =
              DateTime.fromMillisecondsSinceEpoch(cachedWeather.dt * 1000);
          Duration difference = DateTime.now().difference(lastUpdatedTime);
          if (difference.inDays > 1) {
            lastUpdatedMessage = '> 1 ${S.of(context).days}';
          } else if (difference.inMinutes > 59) {
            lastUpdatedMessage = '${difference.inHours} ${S.of(context).hours}';
          } else {
            lastUpdatedMessage =
                '${difference.inMinutes} ${S.of(context).minutes}';
          }
        });
      }
    });

    ForecastHourlyCacheService.getCachedHourlyForecastData()
        .then((cachedForecast) {
      if (cachedForecast != null) {
        setState(() {
          forecastHourlyData = cachedForecast;
        });
      }
    });

    ForecastDailyCacheService.getCachedDailyForecastData()
        .then((cachedForecast) {
      if (cachedForecast != null) {
        setState(() {
          forecastDailyData = cachedForecast;
        });
      }
    });
  }

  _getAddressFromPosition(Position position) async {
    String address = await _locationService.getAddressFromPosition(position);
    setState(() {
      _currentCity = address;
    });
  }

  _requestLocationPermission() async {
    bool granted = await _locationService.requestPermission();
    if (granted) {
      _getCurrentLocation();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(S.current.location_permission_denied),
            content: Text(S.current.location_permission_denied_content),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  _getCurrentWeather(double latitude, double longitude) {
    _weatherService.getWeather().then((weather) {
      setState(() {
        _currentWeather = weather;
      });
      WeatherCacheService.cacheWeatherData(weather);
    }).catchError((error) {
      print(error);
    });
  }

  _getHourlyForecast(double latitude, double longitude) {
    _forecastHourlyService.getWeather().then((weather) {
      setState(() {
        forecastHourlyData = weather;
      });
      ForecastHourlyCacheService.cacheHourlyForecastData(weather);
    }).catchError((error) {
      print(error);
    });
  }

  _getDailyForecast(double latitude, double longitude) {
    _forecastDailyService.getWeather().then((weather) {
      setState(() {
        forecastDailyData = weather;
      });
      ForecastDailyCacheService.cacheDailyForecastData(weather);
    }).catchError((error) {
      print(error);
    });
  }

  Future<void> refreshData() async {
    await _getCurrentLocation();
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input.substring(0, 1).toUpperCase() + input.substring(1);
  }

  Widget _weatherIcon() {
    return _currentWeather != null && _currentWeather!.weather.isNotEmpty
        ? Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/weather_icons/${_currentWeather!.weather[0].icon}.png",
                ),
              ),
            ),
          )
        : const CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    DateTime? dateTime;
    String formattedTime = '';
    if (_currentWeather != null) {
      dateTime =
          DateTime.fromMillisecondsSinceEpoch(_currentWeather!.dt * 1000);
      formattedTime = DateFormat('HH:mm').format(dateTime);
    }

    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SearchScreen(),
              ),
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.search,
                color: Colors.black,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: _currentCity != null
                    ? Text(
                        _currentCity!,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )
                    : const ColorChangingContainer(height: 20),
              ),
              const Icon(
                Icons.location_on_outlined,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                if (!_checkInternet)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${S.of(context).internet_connection_error} $lastUpdatedMessage',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.red,
                      ),
                    ),
                  ),
                _currentWeather != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        height: 210,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _weatherIcon(),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(capitalizeFirstLetter(
                                    _currentWeather!.weather[0].description)),
                              ],
                            ),
                            Text(
                              formattedTime,
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10),
                            ),
                            Text(
                              '${_currentWeather?.main.temp.toStringAsFixed((0)) ?? ""}°${S.of(context).temp_units}',
                              style: const TextStyle(
                                fontSize: 70,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                            Text(
                              '${S.of(context).feels_like} ${_currentWeather?.main.feelsLike.toStringAsFixed((0)) ?? ""}°${S.of(context).temp_units}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                    : const ColorChangingContainer(height: 210),
                const SizedBox(height: 10),
                forecastHourlyData != null
                    ? Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (BuildContext context, int index) {
                            DateTime now = DateTime.now();
                            int currentHour = now.hour;
                            int nextHourIndex = -1;

                            for (int i = 0;
                                i < forecastHourlyData!.list.length;
                                i++) {
                              DateTime forecastDateTime =
                                  forecastHourlyData!.list[i].dtTxt.toLocal();
                              int forecastHour = forecastDateTime.hour;

                              if (forecastHour > currentHour) {
                                nextHourIndex = i;
                                break;
                              }
                            }

                            if (nextHourIndex != -1) {
                              ListElement nextHourWeather = forecastHourlyData!
                                  .list[nextHourIndex + index];
                              DateTime forecastDateTime =
                                  nextHourWeather.dtTxt.toLocal();
                              int forecastHour = forecastDateTime.hour;

                              String time =
                                  "${forecastHour.toString().padLeft(2, '0')}:00";
                              String iconCode = nextHourWeather.weather[0].icon;
                              num temperature =
                                  nextHourWeather.main.temp.toInt();

                              return HourlyForecastCard(
                                time: time,
                                iconCode: iconCode,
                                temperature: temperature,
                              );
                            } else {
                              return Container();
                            }
                          },
                        ))
                    : const ColorChangingContainer(height: 100),
                const SizedBox(height: 10),
                forecastDailyData != null
                    ? SizedBox(
                        height: 420,
                        child: ListView.builder(
                          itemCount: forecastDailyData!.list.length,
                          itemBuilder: (context, index) {
                            final daily.ListElement forecast =
                                forecastDailyData!.list[index];
                            final forecastDate =
                                DateTime.fromMillisecondsSinceEpoch(
                              forecast.dt * 1000,
                            );
                            final monthNames = [
                              '',
                              (S.of(context).jan),
                              (S.of(context).feb),
                              (S.of(context).mar),
                              (S.of(context).apr),
                              (S.of(context).may),
                              (S.of(context).jun),
                              (S.of(context).jul),
                              (S.of(context).aug),
                              (S.of(context).sep),
                              (S.of(context).oct),
                              (S.of(context).nov),
                              (S.of(context).dec),
                            ];
                            return DailyForecastCard(
                              date:
                                  '${monthNames[forecastDate.month]} ${forecastDate.day}',
                              maxTemperature: forecast.temp.max,
                              minTemperature: forecast.temp.min,
                              iconCode: forecast.weather[0].icon,
                            );
                          },
                        ),
                      )
                    : const ColorChangingContainer(height: 400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
