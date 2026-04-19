import 'dart:convert';

class GeocodingQueryParams {
  final String q;
  final String appid;
  final int limit;
  GeocodingQueryParams({
    required this.q,
    required this.appid,
    this.limit = 1,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'q': q,
      'appid': appid,
      'limit': limit,
    };
  }

  factory GeocodingQueryParams.fromMap(Map<String, dynamic> map) {
    return GeocodingQueryParams(
      q: map['q'] as String,
      appid: map['appid'] as String,
      limit: map['limit'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory GeocodingQueryParams.fromJson(String source) => GeocodingQueryParams.fromMap(json.decode(source) as Map<String, dynamic>);
}
