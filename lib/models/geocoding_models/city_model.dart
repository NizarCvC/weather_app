import 'dart:convert';
import 'package:weather_app/models/geocoding_models/local_names.dart';

class CityModel {
  final String name;
  final LocalNames? localNames;
  final double lat;
  final double lon;
  final String country;
  final String? state; 

  CityModel({
    required this.name,
    this.localNames, 
    required this.lat,
    required this.lon,
    required this.country,
    this.state, 
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'localNames': localNames?.toMap(), 
      'lat': lat,
      'lon': lon,
      'country': country,
      'state': state,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      name: map['name'] ?? 'Unknown',
      
      localNames: map['local_names'] != null 
          ? LocalNames.fromMap(map['local_names'] as Map<String, dynamic>)
          : null,
          
      lat: (map['lat'] as num).toDouble(),
      lon: (map['lon'] as num).toDouble(),
      
      country: map['country'] ?? 'Unknown',
      
      state: map['state'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) => 
      CityModel.fromMap(json.decode(source) as Map<String, dynamic>);
}