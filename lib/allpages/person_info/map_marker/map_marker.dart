// ignore_for_file: prefer_const_constructors

import 'package:agro_sanoat/allpages/animation_loading/loading.dart';
import 'package:agro_sanoat/allpages/person_info/map_marker/map_marker_provider.dart';
import 'package:agro_sanoat/funcsions/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapMarker extends StatefulWidget {
  const MapMarker({Key? key, required this.latlng}) : super(key: key);
  final dynamic latlng;
  @override
  State<MapMarker> createState() => _MapMarkerState();
}

class _MapMarkerState extends State<MapMarker> {
  MapMarkerProvider provider = MapMarkerProvider();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider.setMarker(widget.latlng);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Consumer<MapMarkerProvider>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: MainColors.fromHex(MainColors.colorWhite),
          appBar: AppBar(
              toolbarHeight: 40,
              backgroundColor: MainColors.fromHex(MainColors.colorGreen),
              elevation: 0,
              centerTitle: true,
              title: Text(
                "Joylashuvni o'zgartirish",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: MainColors.fromHex(MainColors.colorWhite)),
              ),
              actions: [
                Visibility(
                  visible: provider.setEnebled,
                  child: IconButton(
                      onPressed: () {
                        provider.closePage(context);
                      },
                      icon: SvgPicture.asset(
                        "assets/images/done.svg",
                        color: MainColors.fromHex(MainColors.colorWhite),
                      )),
                ),
              ]),
          body: provider.loading
              ? Loading()
              : Stack(
                  children: [
                    GoogleMap(
                        markers: provider.markers,
                        initialCameraPosition: CameraPosition(
                            target: provider.sourselocation, zoom: 10)),
                    Positioned(
                        bottom: 30,
                        left: 30,
                        child: FloatingActionButton(
                          onPressed: () {
                            provider.currentLocation();
                          },
                          child: SvgPicture.asset(
                            "assets/images/location.svg",
                            height: 25,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
        ),
      ),
    );
  }
}
