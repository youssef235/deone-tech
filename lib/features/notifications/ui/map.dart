import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../theme/app_colors.dart';
import '../../../utils/utils.dart';

class LocationAccess extends StatefulWidget {
  double latitude;
  double longitude;

  LocationAccess({super.key, required this.latitude ,required this.longitude });

  @override
  State<LocationAccess> createState() => _LocationAccessState();
}

class _LocationAccessState extends State<LocationAccess> {
  
  late bool? isPreview = true; // we may reuse this screen in other cases , for now we just want to preview a locaion
  double latitude = 0;
  double longitude = 0;
  GoogleMapController? _controller;
  late Position currentLocation;
  CameraPosition? _kGooglePlex;
  Set<Marker> marker = {
    const Marker(
      markerId: MarkerId("1"),
      position: LatLng(0, 0),
    )
  };
  Future<void> getPos() async {
    currentLocation =
        await Geolocator.getCurrentPosition().then((value) => value);

    latitude = currentLocation.latitude;
    longitude = currentLocation.longitude;

    print("lat : $latitude");
    print("longitude : $longitude");
    marker = {
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(latitude, longitude),
      )
    };
    _kGooglePlex = CameraPosition(
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
      zoom: 20,
    );
    setState(() {});
  }

  Future<bool> getPer() async {
    bool services;
    LocationPermission per;
    services = await Geolocator.isLocationServiceEnabled();


    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      bool userAgreed = await showDialogForRequestPermission(context);

      if (userAgreed) {
        // User agreed to the disclosure, proceed to request location permission
        per = await Geolocator.requestPermission();
      } else {
        // User disagreed to the disclosure, handle accordingly
        AppSnackbar.show(buildSnackBar(
            text: "لتجربة أفضل من فضلك اعطي التطبيق صلاحيات الموقع"));
        return false;
      }
      if (per == LocationPermission.whileInUse||per == LocationPermission.always||per == LocationPermission.unableToDetermine) {
        await getPos();
      }else {
        AppSnackbar.show(buildSnackBar(
            text: "لتجربة أفضل من فضلك اعطي التطبيق صلاحيات الموقع"));

        latitude = 24.774265;
        longitude = 46.738586;

        print("lat : $latitude");
        print("longitude : $longitude");
        marker = {
          Marker(
            markerId: MarkerId("1"),
            position: LatLng(latitude, longitude),
          )
        };
        _kGooglePlex = CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 11,
        );
        setState(() {});
      }
    } else {
      getPos();
    }

    return per == LocationPermission.whileInUse;
  }

  @override
  void initState() {
    getPer();
    super.initState();

  }

  showLocation(){
    marker = {
      Marker(
        markerId: const MarkerId("1"),
        position: LatLng(widget.latitude, widget.longitude),
      )
    };
    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(widget.latitude, widget.longitude), zoom: 15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: isPreview==true?  const Text("موقع العميل"): const Text("اختر موقعك"),
        centerTitle: true,
      ),
      body: _kGooglePlex == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: GoogleMap(
                    markers: marker,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex!,
                    gestureRecognizers: Set()
                      ..add(Factory<PanGestureRecognizer>(
                          () => PanGestureRecognizer()))
                      ..add(Factory<ScaleGestureRecognizer>(
                          () => ScaleGestureRecognizer()))
                      ..add(Factory<TapGestureRecognizer>(
                          () => TapGestureRecognizer()))
                      ..add(Factory<VerticalDragGestureRecognizer>(
                          () => VerticalDragGestureRecognizer())),
                    onCameraMove: (CameraPosition position) {
                      if(isPreview==true) return;
                      _kGooglePlex = position;
                      setState(() {
                        latitude = _kGooglePlex!.target.latitude;
                        longitude = _kGooglePlex!.target.longitude;
                        marker = {
                          Marker(
                            markerId: const MarkerId("1"),
                            position: LatLng(_kGooglePlex!.target.latitude,
                                _kGooglePlex!.target.longitude),
                          )
                        };
                      });
                    },
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                      showLocation();
                    },
                  ),
                ),
              ],
            ),
    );
  }
}


