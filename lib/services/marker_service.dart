import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_map/models/place.dart';

class MarkerService {
  LatLngBounds bounds(Set<Marker> markers) {
    if (markers == null || markers.isEmpty) return null;
    return createBounds(markers.map((e) => e.position).toList());
  }

  LatLngBounds createBounds(List<LatLng> positions) {
    final southwestLat = positions.map((e) => e.latitude).reduce(
        (value, element) => value < element ? value : element); // smallest
    final southwestLng = positions
        .map((e) => e.longitude)
        .reduce((value, element) => value < element ? value : element);
    final northwestLat = positions.map((e) => e.latitude).reduce(
        (value, element) => value > element ? value : element); // biggest
    final northwestLng = positions
        .map((e) => e.longitude)
        .reduce((value, element) => value > element ? value : element);
    return LatLngBounds(
        southwest: LatLng(southwestLat, southwestLng),
        northeast: LatLng(northwestLat, northwestLng));
  }

  Marker createMarkerFromPlace(Place place) {
    var markerId = place.name;

    return Marker(
      markerId: MarkerId(markerId),
      draggable: true,
      infoWindow: InfoWindow(title: place.name, snippet: place.vicinity),
      position:
          LatLng(place.geometry.location.lat, place.geometry.location.lng),
    );
  }
}
