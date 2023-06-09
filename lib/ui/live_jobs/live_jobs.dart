import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:softech_hustlers/global_widgets/busy_button.dart';
import 'package:softech_hustlers/models/job_model.dart';

import '../detail/detailscreen.dart';

class LiveJobs extends StatefulWidget {
  const LiveJobs({required this.jobModel, Key? key}) : super(key: key);
  final List<JobModel> jobModel;

  @override
  State<LiveJobs> createState() => _LiveJobsState();
}

class _LiveJobsState extends State<LiveJobs> {
  GoogleMapController? _controller;
  LatLng _initialcameraposition =
      const LatLng(37.42796133580664, -122.085749655962);

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.back();
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.back();
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
  List<Marker> myListMarkers = [];
  Set<Marker> markers = Set.of([]);

  @override
  void initState() {
    // TODO: implement initState
    widget.jobModel.forEach((element) {
      myListMarkers.add(Marker(
        markerId: MarkerId(element.id),
        position: LatLng(element.lat, element.lng),

        infoWindow: InfoWindow(title: element.title,snippet: element.description,onTap: (){ Get.to(
            DetailScreen(
              element,
            ),
            transition: Transition.rightToLeft);}),
      ));
      markers= Set.of(myListMarkers);

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(5.0),
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.transparent,
            onPressed: () async {
              Position p = await _determinePosition();
              _controller!.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                      target: LatLng(p.latitude, p.longitude), zoom: 15)));
            },
            child: Container(
              height: 50.h,
              width: 50.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                Icons.location_searching_rounded,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.transparent,
              onPressed: () {
                Get.back();
              },
              child: Container(
                height: 50.h,
                width: 50.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
        body: GoogleMap(
          markers: markers,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          onCameraMove: (CameraPosition position) {


            _initialcameraposition =
                LatLng(position.target.latitude, position.target.longitude);
            setState(() {});
          },
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;

          },
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
          child: BusyButton(
            title: "Select Current Location",
            isBusy: false,
            onPressed: () async {
              List<Placemark> placemarks = await placemarkFromCoordinates(
                  _initialcameraposition.latitude,
                  _initialcameraposition.longitude);
              Map<String, dynamic> result = {
                "location": _initialcameraposition,
                "address": placemarks[0]
              };
              Get.back(result: result);
            },
          ),
        ),
      ),
    );
  }
}
