// ignore_for_file: prefer_collection_literals, prefer_const_constructors, constant_identifier_names, unused_local_variable
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:agro_sanoat/allpages/header_page/widget/bottom_sheet_person.dart';
import 'package:agro_sanoat/allpages/header_page/widget/bottomsheet.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:agro_sanoat/http_service/http_constant.dart';
import 'package:agro_sanoat/http_service/http_service.dart';
import 'package:agro_sanoat/object/universal.dart';
import 'package:agro_sanoat/route_generation/route_generation.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive_flutter/adapters.dart';

class HeaderPageProvidr extends ChangeNotifier {
  bool switchMap = false;
  bool loading = true;
  bool cluster = true;
  double zoom = 0;
  bool isLoading = false;
  late BuildContext thiscontext;
  Set<Marker> markers = Set();
  final controller = ScrollController();
  List<UniversalModel> regions = [];
  List<UniversalModel> provins = [];
  UniversalModel? selectRegion;
  UniversalModel? selectProvins;
  PageController infoController = PageController();
  PageController newsController = PageController();
  int animateindexInfo = 0;
  int animateindexNews = 0;
  LatLng sourselocation = LatLng(40.986374, 69.370742);
  List itemNews = [];
  List itemInfo = [];
  ClusterManager? manager;
  List<Place> items = [];
  Completer<GoogleMapController> mapController = Completer();

  onStart(context) async {
    thiscontext = context;
    Box box = await Hive.openBox("db");
    var infoJson = await box.get("info");
    if (infoJson != null) {
      itemInfo = json.decode(infoJson) as List;
    }
    var newsJson = await box.get("new");
    if (newsJson != null) {
      itemNews = jsonDecode(newsJson) as List;
    }
    loading = true;
    notifyListeners();
    var regionJson = await HttpService.GET(HttpConstant.viloyat);
    if (regionJson["status"] == HttpConnection.data) {
      for (var item in regionJson["data"]["rows"]) {
        items.add(Place(
            name: item["tr_name"],
            model: null,
            id: item["id"],
            latLng: LatLng(jsonDecode(item["location"])["lat"],
                jsonDecode(item["location"])["lng"])));
      }
      regions = regionFromMap(regionJson["data"]["rows"]);
    }
    zoom = 8;
    cluster = true;
    manager = initClusterManager();

    loading = false;
    notifyListeners();
  }

  mapService(value) async {
    loading = true;
    notifyListeners();
    selectRegion = value["region"] == "0" ? null : value["region"];
    selectProvins = value["provins"] == "0" ? null : value["provins"];

    if (selectProvins == null) {
      Map<String, String> param = {"regions_id": selectRegion!.id.toString()};
      var provinsJson =
          await HttpService.GET(HttpConstant.tuman, params: param);
      if (provinsJson["status"] == HttpConnection.data) {
        items.clear();
        markers.clear();
        zoom = 10;
        cluster = true;
        double? lat = selectRegion!.lat;
        double? lng = selectRegion!.lng;
        sourselocation = LatLng(lat!, lng!);
        for (var item in provinsJson["data"]["rows"]) {
          items.add(Place(
              name: item["tr_name"],
              model: selectRegion!,
              id: item["id"],
              latLng: LatLng(jsonDecode(item["location"])["lat"],
                  jsonDecode(item["location"])["lng"])));
        }
        manager = initClusterManager();
        provins = regionFromMap(provinsJson["data"]["rows"]);
      }
    } else {
      Map<String, String> param = {
        "regions_id": selectRegion!.id.toString(),
        "areas_id": selectProvins!.id.toString()
      };
      markers.clear();
      items.clear();
      zoom = 12;
      cluster = false;
      double? lat = selectProvins!.lat;
      double? lng = selectProvins!.lng;
      sourselocation = LatLng(lat!, lng!);
      await mapSetting(thiscontext, param);
      if (markers.isEmpty) {
        AwesomeDialog(
          context: thiscontext,
          animType: AnimType.scale,
          dialogType: DialogType.warning,
          body: Center(
            child: Text(
              "Bu tumanda fermerlar va dexqonlar kiritilmagan",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          title: 'This is Ignored',
          desc: 'This is also Ignored',
          btnOkOnPress: () {
            bottomsheetMap(thiscontext, regions, selectProvins, selectRegion)
                .then((value) {
              if (value != null) {
                mapService(value);
              } else {
                marEmpty(thiscontext);
              }
            });
          },
        ).show();
      }
    }

    loading = false;
    notifyListeners();
  }

  marEmpty(context) async {
    loading = true;
    notifyListeners();
    Map<String, String> param = {"regions_id": "", "areas_id": ""};
    selectProvins = null;
    selectRegion = null;
    markers.clear();
    items.clear();
    await onStart(context);
    loading = false;
    notifyListeners();
  }

  mapSetting(context, param) async {
    if (markers.isNotEmpty) {
      markers.clear();
    }
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/city.png",
    );
    var respons = await HttpService.GET(HttpConstant.dashboard, params: param);
    if (respons["status"] == HttpConnection.data) {
      for (int i = 0; i < respons["data"]["rows"].length; i++) {
        var jsonLatLng = json.decode(respons["data"]["rows"][i]["location"]);
        LatLng latLng = LatLng(jsonLatLng["lat"], jsonLatLng["lng"]);
        markers.add(
          Marker(
              markerId: MarkerId(respons["data"]["rows"][i]["id"].toString()),
              onTap: () {
                bottomsheetPerson(context, respons["data"]["rows"][i]);
              },
              position: latLng,
              icon: BitmapDescriptor.defaultMarker),
        );
      }
    }
  }

  mapSwitch(value) {
    switchMap = value;
    notifyListeners();
  }

  changeInfo(index) {
    animateindexInfo = index;
    notifyListeners();
  }

  changeNews(index) {
    animateindexNews = index;
    notifyListeners();
  }

  ontapInfo(context, item) async {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1000)
      ..backgroundColor = Colors.white
      ..indicatorColor = Colors.black
      ..maskType = EasyLoadingMaskType.black
      ..maskColor = Colors.black
      ..userInteractions = false;
    EasyLoading.show(status: 'loading...');
    Map<String, String> param = {"path": item["context_path"]};
    var response = await HttpService.GET(HttpConstant.foydalanish + "-by-path",
        params: param);
    EasyLoading.dismiss();
    Navigator.of(context)
        .pushNamed(RouteGeneration.bigviewinfo, arguments: response["data"][0]);
  }

  ontapNews(context, item) async {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1000)
      ..backgroundColor = Colors.white
      ..indicatorColor = Colors.black
      ..maskType = EasyLoadingMaskType.black
      ..maskColor = Colors.black
      ..userInteractions = false;
    EasyLoading.show(status: 'loading...');
    Map<String, String> param = {"path": item["context_path"]};
    var response = await HttpService.GET(HttpConstant.yangilaklar + "-by-path",
        params: param);
    EasyLoading.dismiss();
    Navigator.of(context)
        .pushNamed(RouteGeneration.bigviewnews, arguments: response["data"][0]);
  }

  ClusterManager initClusterManager() {
    return ClusterManager<Place>(items, updateMarkers,
        markerBuilder: _markerBuilder);
  }

  void updateMarkers(Set<Marker> markers) {
    this.markers = markers;
    notifyListeners();
  }

  mapSettingPlace(context, param) async {
    if (markers.isNotEmpty) {
      markers.clear();
    }
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      "assets/images/city.png",
    );
    var respons = await HttpService.GET(HttpConstant.dashboard, params: param);
    if (respons["status"] == HttpConnection.data) {
      for (int i = 0; i < respons["data"]["rows"].length; i++) {
        var jsonLatLng = json.decode(respons["data"]["rows"][i]["location"]);
        LatLng latLng = LatLng(jsonLatLng["lat"], jsonLatLng["lng"]);
        markers.add(
          Marker(
              markerId: MarkerId(respons["data"]["rows"][i]["id"].toString()),
              onTap: () {
                bottomsheetPerson(context, respons["data"]["rows"][i]);
              },
              position: latLng,
              icon: BitmapDescriptor.defaultMarker),
        );
      }
    }
  }

  Future<Marker> Function(Cluster<Place>) get _markerBuilder =>
      (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            print('---- $cluster');
          },
          infoWindow: InfoWindow(
              title: getName(cluster.items),
              onTap: () {
                if (cluster.items.length == 1) {
                  cluster.items.forEach((Place place) {
                    if (place.model == null) {
                      Map<String, dynamic> value = {
                        "provins": place.model,
                        "region": UniversalModel(
                            id: place.id,
                            name: place.name,
                            lat: place.location.latitude,
                            lng: place.location.longitude),
                      };
                      mapService(value);
                    } else {
                      Map<String, dynamic> value = {
                        "provins": UniversalModel(
                            id: place.id,
                            name: place.name,
                            lat: place.location.latitude,
                            lng: place.location.longitude),
                        "region": place.model,
                      };
                      mapService(value);
                    }
                  });
                } else {}
              }),
          icon: await _getMarkerBitmap(cluster.isMultiple ? 125 : 75,
              text: cluster.isMultiple ? cluster.count.toString() : null),
        );
      };

  Future<BitmapDescriptor> _getMarkerBitmap(int size, {String? text}) async {
    if (kIsWeb) size = (size / 2).floor();

    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()
      ..color = MainColors.fromHex(MainColors.colorRed);
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(
            fontSize: size / 3,
            color: Colors.white,
            fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  String getName(names) {
    String name = "";
    names.forEach((Place place) {
      name += place.name + ", ";
    });

    return name;
  }
}

class Place with ClusterItem {
  final String name;
  final UniversalModel? model;
  final int id;
  final LatLng latLng;

  Place({
    required this.name,
    required this.latLng,
    required this.id,
    required this.model,
  });

  @override
  LatLng get location => latLng;
}
