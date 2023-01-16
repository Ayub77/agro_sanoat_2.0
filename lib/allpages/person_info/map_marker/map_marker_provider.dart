import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarkerProvider extends ChangeNotifier {
  GoogleMapController? controller;
  LatLng sourselocation = const LatLng(40.986374, 69.370742);
  Set<Marker> markers = {};
  bool setEnebled = false;
  LatLng newLocation = const LatLng(40.986374, 69.370742);

  setMarker(LatLng latLng) {
    sourselocation = latLng;
    markers.add(Marker(
        onTap: () {
          print('Tapped');
        },
        draggable: true,
        markerId: const MarkerId('Marker'),
        position: latLng,
        onDragEnd: ((newPosition) {
          newLocation = newPosition;
          setEnebled = true;
          notifyListeners();
        })));
    notifyListeners();
  }

  closePage(context) {
    Navigator.pop(context, newLocation);
  }
}
