// // 요청한 데이터에서 geometry ( location ( lat, lng) ) ) 부분에서 location 부분 처리

import 'package:just_map/models/location.dart';

class Geometry {
  final Location location;

  Geometry({this.location});

  factory Geometry.fromJson(Map<dynamic,dynamic> parsedJson) {
    return Geometry(
      location: Location.fromJson(parsedJson['location'])
    );
  }
}