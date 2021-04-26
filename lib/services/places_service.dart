import 'package:http/http.dart' as http;
import 'package:just_map/models/place.dart';
import 'dart:convert' as convert;

import 'package:just_map/models/place_search.dart';

class PlacesService {
  final key = 'AIzaSyCAPZ14yM_8vCmAlZ1IdfLwednlhLzBFmI';

  // 검색어 자동완성을 위해 주소를 통해 요청
  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&language=ko&key=$key';
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;

    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  // 검색된 위치의 구체적인 장소의 정보
  Future<Place> getPlace(String placeId) async {
    var url = 'https://maps.googleapis.com/maps/api/place/details/json?key=$key&place_id=$placeId';
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResults);
  }

  Future<List<Place>> getPlaces(double lat, double lng, String placeType) async {
    var url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?type=$placeType&location=$lat, $lng&rankby=distance&key=$key';
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}