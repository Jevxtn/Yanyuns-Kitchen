import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yanyuns_kitchen/Screens/order_confirmation.dart';
import 'package:yanyuns_kitchen/styles.dart';

class LocationSetup extends StatefulWidget {
  const LocationSetup({Key? key}) : super(key: key);

  @override
  State<LocationSetup> createState() => _LocationSetupState();
}

class _LocationSetupState extends State<LocationSetup> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        color: appColors['black'],
        child: SafeArea(
          child: Scaffold(
            backgroundColor: appColors['primary'],
            body: Container(
              width: deviceWidth,
              color: appColors['black'],
              child: SizedBox(
                height: deviceHeight,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: SizedBox(
                        width: deviceWidth,
                        height: deviceHeight,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: deviceHeight * .2),
                              child: Text(
                                "YANYUN'S KITCHEN",
                                style: getTextStyle(
                                  textColor: 'accent',
                                  fontFamily: 'PS2P',
                                  fontWeight: 400,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                "Find your location",
                                style: getTextStyle(
                                  textColor: 'primary.6',
                                  fontFamily: 'Roboto',
                                  fontWeight: 600,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "SELECT LOCATION",
                              style: getTextStyle(
                                textColor: 'primary.6',
                                fontFamily: 'Roboto',
                                fontWeight: 800,
                                fontSize: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 38, right: 38, bottom: 90, top: 30),
                              child: GestureDetector(
                                onTap: () async {
                                  Placemark address = await getAddress();

                                  if (!mounted) return;

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OrderConfirmation(
                                              address: address),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 23, vertical: 15),
                                  width: deviceWidth,
                                  decoration: BoxDecoration(
                                    color: appColors['primary'],
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 14),
                                        child: Image.asset(
                                          "assets/images/icons/location_icon.png",
                                          width: 20,
                                          height: 37,
                                        ),
                                      ),
                                      Text(
                                        "Provide Delivery Location",
                                        style: getTextStyle(
                                          textColor: 'accent',
                                          fontFamily: 'Roboto',
                                          fontWeight: 600,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 50,
                      width: deviceWidth,
                      decoration: BoxDecoration(
                        color: appColors['black'],
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back,
                              color: appColors['primary'],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Position> getCurrentLocation() async {
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

  Future<Placemark> getAddress() async {
    Position coordinates = await getCurrentLocation();
    print(coordinates);

    List<Placemark> placemarks = await placemarkFromCoordinates(
        coordinates.latitude, coordinates.longitude);

    print(placemarks.first);
    return placemarks.first;
  }
}
