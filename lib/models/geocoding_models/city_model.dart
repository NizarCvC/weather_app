import 'dart:convert';
import 'package:weather_app/models/geocoding_models/local_names.dart';

class CityModel {
  final String name;
  final LocalNames localNames;
  final double lat;
  final double lon;
  final String country;
  final String state;

  CityModel({
    required this.name,
    required this.localNames,
    required this.lat,
    required this.lon,
    required this.country,
    required this.state,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'localNames': localNames.toMap(),
      'lat': lat,
      'lon': lon,
      'country': country,
      'state': state,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      name: map['name'] as String,
      localNames: LocalNames.fromMap(map['localNames'] as Map<String,dynamic>),
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      country: map['country'] as String,
      state: map['state'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) => CityModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
