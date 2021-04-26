// 위치 검색 결과 데이터 처리
class PlaceSearch {
  // description, placeId 변수에 요청한 json 의 description, place_id 를 저장
  final String description;
  final String placeId;

  PlaceSearch({this.description, this.placeId});

  factory PlaceSearch.fromJson(Map<String, dynamic> json) {
    return PlaceSearch(
        description: json['description'],
        placeId: json['place_id'],
    );
  }
}
