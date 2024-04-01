// To parse this JSON data, do
//
//     final searchCityData = searchCityDataFromJson(jsonString);

import 'dart:convert';

List<SearchCityData> searchCityDataFromJson(String str) =>
    List<SearchCityData>.from(
        json.decode(str).map((x) => SearchCityData.fromJson(x)));

String searchCityDataToJson(List<SearchCityData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchCityData {
  String name;
  Map<String, String>? localNames;
  double lat;
  double lon;
  String country;
  String state;

  SearchCityData({
    required this.name,
    this.localNames,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  factory SearchCityData.fromJson(Map<String, dynamic> json) {
    return SearchCityData(
      name: json["name"] ?? "",
      localNames: json["local_names"] != null
          ? Map<String, String>.from(json["local_names"]!)
              .map((k, v) => MapEntry<String, String>(k, v))
          : null,
      lat: json["lat"]?.toDouble() ?? 0.0,
      lon: json["lon"]?.toDouble() ?? 0.0,
      country: json["country"] ?? "",
      state: json["state"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "local_names": Map.from(localNames!)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "lat": lat,
        "lon": lon,
        "country": country,
        "state": state,
      };
}
