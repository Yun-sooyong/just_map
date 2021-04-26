// 지도에 표시되는 구체적인 정보에 대한 처리
// 위치 좌표, 운영시간, 주소, 사진 등 정보가 있음
// 요청한 데이터에서 geometry ( location ( lat, lng) ) ) 부분의 lat, lng 부분 처리

class Location {
  final double lat;
  final double lng;

  Location({this.lat, this.lng});

  factory Location.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Location(
      lat: parsedJson['lat'],
      lng: parsedJson['lng'],
    );
  }
}