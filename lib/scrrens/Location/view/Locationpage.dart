import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../controler/contolerpage.dart';

class locationsacreen extends StatefulWidget {
  const locationsacreen({Key? key}) : super(key: key);

  @override
  State<locationsacreen> createState() => _locationsacreenState();
}

class _locationsacreenState extends State<locationsacreen> {
  locationcontroler Controllor = Get.put(locationcontroler(),
  );

  @override
  void initState() {
    super.initState();
    AddPermissio();
  }

  Future<void> AddPermissio() async {
    var Status = await Permission.location.status;

    if (Status.isDenied) {
      await Permission.location.request();
    }
  }

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              )),
            ),
            Expanded(
              child: Obx(
                    () => GoogleMap(
                  onMapCreated: (controller) {
                    _controller.complete(controller);
                  },
                  mapType: MapType.hybrid,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      Controllor.lat.value,
                      Controllor.lon.value,
                    ),
                    zoom: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
        // fx
      ),
    );
  }
}