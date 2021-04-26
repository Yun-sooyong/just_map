import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_map/models/place.dart';
import 'package:provider/provider.dart';

import 'package:just_map/blocs/application_bloc.dart';

class MapSample extends StatefulWidget {
  @override
  _MapSampleState createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription locationSubscription;
  StreamSubscription boundsSubscription;

  // 앱 실행시 가장 먼저 실행
  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    locationSubscription =
        applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) {
        _goToPlace(place);
      }
    });

    boundsSubscription = applicationBloc.bounds.stream.listen((bounds) async {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));
    });

    super.initState();
  }

  // dispose 는 Stream 을 사용하는 경우 StreamController 에 할당 된 메모리 해제를 위해 사용
  // initState 에서 실행한 내용을 해제
  @override
  void dispose() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.dispose();
    boundsSubscription.cancel();
    locationSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
      body: (applicationBloc.currentLocation == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '지역 검색',
                      suffixIcon: Icon(Icons.search),
                    ),
                    // 입력된 값을 applicationBloc 의 searchPlaces 에 추가
                    onChanged: (value) => applicationBloc.searchPlaces(value),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 300,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        markers: Set<Marker>.of(applicationBloc.markers),
                        myLocationEnabled: true,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                applicationBloc.currentLocation.latitude,
                                applicationBloc.currentLocation.longitude),
                            zoom: 16),
                        onMapCreated: (GoogleMapController controller) {
                          _mapController.complete(controller);
                        },
                      ),
                    ),
                    // applicationBloc.searchResults 의 내용이 null 이 아니고, applicationBloc.searchResults 의 길이가 0이 아니면 아랫부분을 실행
                    if (applicationBloc.searchResults != null &&
                        applicationBloc.searchResults.length != 0)
                      Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          backgroundBlendMode: BlendMode.darken,
                        ),
                      ),
                    if (applicationBloc.searchResults != null &&
                        applicationBloc.searchResults.length != 0)
                      Container(
                        height: 300,
                        child: ListView.builder(
                          itemCount: applicationBloc.searchResults.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                applicationBloc
                                    .searchResults[index].description,
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                applicationBloc.setSelectedLocation(
                                    applicationBloc
                                        .searchResults[index].placeId);
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Find Nearest',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8.0,
                    children: [
                      FilterChip(
                        label: Text('Library'),
                        // onSelected 의 val 은 선택 여부를 나타내는 bool 타입
                        onSelected: (val) =>
                            applicationBloc.togglePlaceType('library', val),
                        selected: applicationBloc.placeType == 'library',
                        selectedColor: Colors.blue,
                      ),
                      FilterChip(
                        label: Text('Bus Station'),
                        // onSelected 의 val 은 선택 여부를 나타내는 bool 타입
                        onSelected: (val) =>
                            applicationBloc.togglePlaceType('bus_station', val),
                        selected: applicationBloc.placeType == 'bus_station',
                        selectedColor: Colors.blue,
                      ),
                      FilterChip(
                        label: Text('ATM'),
                        // onSelected 의 val 은 선택 여부를 나타내는 bool 타입
                        onSelected: (val) =>
                            applicationBloc.togglePlaceType('atm', val),
                        selected: applicationBloc.placeType == 'atm',
                        selectedColor: Colors.blue,
                      ),
                      FilterChip(
                        label: Text('Movie Theater'),
                        // onSelected 의 val 은 선택 여부를 나타내는 bool 타입
                        onSelected: (val) =>
                            applicationBloc.togglePlaceType('movie_theater', val),
                        selected: applicationBloc.placeType == 'movie_theater',
                        selectedColor: Colors.blue,
                      ),
                      FilterChip(
                        label: Text('Pet Store'),
                        // onSelected 의 val 은 선택 여부를 나타내는 bool 타입
                        onSelected: (val) =>
                            applicationBloc.togglePlaceType('pet_store', val),
                        selected: applicationBloc.placeType == 'pet_store',
                        selectedColor: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                place.geometry.location.lat, place.geometry.location.lng),
            zoom: 16),
      ),
    );
  }
}
