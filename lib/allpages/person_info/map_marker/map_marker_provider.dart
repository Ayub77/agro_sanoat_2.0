// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapMarkerProvider extends ChangeNotifier {
  GoogleMapController? controller;
  LatLng sourselocation = const LatLng(40.986374, 69.370742);
  Set<Marker> markers = {};
  bool setEnebled = false;
  bool loading = true;
  LatLng newLocation = const LatLng(40.986374, 69.370742);

  setMarker(LatLng latLng) {
    sourselocation = latLng;
    markers.clear();
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
    loading = false;
    notifyListeners();
  }

  closePage(context) {
    Navigator.pop(context, newLocation);
  }

  currentLocation() async {
    loading = true;
    notifyListeners();

    var response = await determinePosition();
    LatLng loc = LatLng(response.latitude, response.longitude);
    setMarker(loc);
  }

  determinePosition() async {
    // var location = Location();
    // bool _serviceEnabled;
    // PermissionStatus _permissionGranted;
    // LocationData locationData;
    // _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     return;
    //   }
    // }
    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }

    // locationData = await location.getLocation();

    // LatLng loc = LatLng(locationData.latitude!, locationData.longitude!);
    // print(loc);
    // setMarker(loc);

    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      EasyLoading.showInfo("Joylashuv xizmatlari o‘chirilgan.");
      loading = false;
      notifyListeners();
      //return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        EasyLoading.showInfo("Joylashuv xizmatlari o‘chirilgan.");
        loading = false;
        notifyListeners();
        // return Future.error('Joylashuv ruxsatlari rad etilgan');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      EasyLoading.showInfo(
          "Joylashuvga ruxsatnomalar butunlay rad etilgan, biz ruxsat so‘ra olmaymiz.");
      loading = false;
      notifyListeners();
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
