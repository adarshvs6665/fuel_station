import 'package:animate_do/animate_do.dart';
import 'package:fuel_station/screens/map.dart';
import 'package:fuel_station/screens/order_success.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:geolocator/geolocator.dart';

import '../data/app_data.dart';
import '../widget/reuseable_row_for_cart.dart';
import '../main_wrapper.dart';
import '../model/base_model.dart';
import '../utils/constants.dart';
import '../widget/reuseable_button.dart';

class ConfirmLocation extends StatefulWidget {
  const ConfirmLocation({super.key});

  @override
  State<ConfirmLocation> createState() => _ConfirmLocationState();
}
//CodeWithFlexz on Instagram

//AmirBayat0 on Github
//Programming with Flexz on Youtube

class _ConfirmLocationState extends State<ConfirmLocation> {
  Position? _currentPosition;
  GoogleMapController? _mapController;
  LatLng? _center;
  double lat = 33;
  double long = -122;

  @override
  void initState() {
    super.initState();
    _determinePosition().then((position) {
      setState(() {
        _currentPosition = position;
        print("lat long");
        _center =
            LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: _center!,
              zoom: 12.0,
            ),
          ),
        );
        print(_center!.latitude);
        print(_center!.longitude);
      });
    }).catchError((e) {
      print(e);
    });
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
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
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: SizedBox(
                  width: size.width,
                  height: size.height * 0.6,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      FadeInUp(
                        child: SizedBox(
                          height: 400,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: GoogleMap(
                                  onMapCreated:
                                      (GoogleMapController controller) {
                                    _mapController = controller;
                                  },
                                  onTap: (LatLng location) {
                                    setState(() {
                                      _center = location;
                                      print("printing tapped location");
                                      print(_center!.latitude);
                                      print(_center!.longitude);
                                    });
                                  },
                                  markers: _center != null
                                      ? {
                                          Marker(
                                            markerId: MarkerId("pin"),
                                            position: _center!,
                                          ),
                                        }
                                      : {},
                                  myLocationEnabled: true,
                                  initialCameraPosition: CameraPosition(
                                    target: _center ?? LatLng(0, 0),
                                    zoom: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      // FadeInUp(
                      //   delay: const Duration(milliseconds: 250),
                      //   child: const Text(
                      //     "Your cart is empty right now :(",
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.w400, fontSize: 16),
                      //   ),
                      // ),
                      // FadeInUp(
                      //   delay: const Duration(milliseconds: 300),
                      //   child: IconButton(
                      //     onPressed: () {
                      //       Navigator.pushReplacement(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => const MainWrapper()));
                      //     },
                      //     icon: const Icon(
                      //       Icons.shopping_bag_outlined,
                      //       color: Colors.black,
                      //     ),
                      //   ),
                      // ),
                    ],
                  )),
            ),

            /// Bottom Card
            Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: size.height * 0.36,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 1.0),
                  child: Column(
                    children: [
                      FadeInUp(
                        delay: const Duration(milliseconds: 550),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: ReuseableButton(
                              text: "Confirm Location",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OrderSuccessPage(),
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        "Confirm Location",
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            LineIcons.user,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
