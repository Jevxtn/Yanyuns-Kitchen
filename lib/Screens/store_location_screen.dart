import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:yanyuns_kitchen/styles.dart';

class StoreLocation extends StatefulWidget {
  const StoreLocation({Key? key}) : super(key: key);

  @override
  State<StoreLocation> createState() => _StoreLocationState();
}

List<String> socials = ["facebook", "instagram", "email", "youtube"];

class _StoreLocationState extends State<StoreLocation> {
  final _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: appColors['primary'],
      body: SizedBox(
        width: deviceWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 390,
              width: deviceWidth,
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: LatLng(14.6782857, 121.034861),
                  zoom: 18,
                  maxZoom: 18,
                  minZoom: 17,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(14.678205219370088, 121.03493459416654),
                        rotate: false,
                        builder: (context) => Align(
                          alignment: const FractionalOffset(-0.5, 0),
                          child: Icon(
                            Icons.location_on_sharp,
                            color: appColors['accent'],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "YANYUN'S KITCHEN",
                style: getTextStyle(
                    textColor: 'black',
                    fontFamily: 'Roboto',
                    fontWeight: 800,
                    fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 9),
              child: Text(
                "30 Banlat Rd, Tandang Sora, Quezon City, Metro Manila",
                style: getTextStyle(
                    textColor: 'black',
                    fontFamily: 'Roboto',
                    fontWeight: 400,
                    fontSize: 13),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 11),
              child: Text(
                "CONTACT US",
                style: getTextStyle(
                    textColor: 'black',
                    fontFamily: 'Roboto',
                    fontWeight: 500,
                    fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                "0977 643 8024",
                style: getTextStyle(
                    textColor: 'accent',
                    fontFamily: 'Roboto',
                    fontWeight: 400,
                    fontSize: 13),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 63, vertical: 8),
              child: Divider(
                height: 0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                "Working Hours\n8:00am - 10:00pm",
                textAlign: TextAlign.center,
                style: getTextStyle(
                    textColor: 'black',
                    fontFamily: 'Roboto',
                    fontWeight: 400,
                    fontSize: 12),
              ),
            ),
            SizedBox(
              width: 270,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 17,
                  mainAxisExtent: 31,
                  crossAxisSpacing: 50,
                ),
                itemCount: socials.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: appColors['accent'],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: SizedBox(
                            width: 21,
                            child: Image.asset(
                              "assets/images/icons/${socials[index]}_icon.png",
                              height: 21,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 70,
                          child: Center(
                            child: Text(
                              socials[index].toUpperCase(),
                              style: getTextStyle(
                                  textColor: 'primary',
                                  fontFamily: 'Lato',
                                  fontWeight: 700,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: GestureDetector(
                onTap: () => context.pushReplacement('/main'),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 56),
                  child: Container(
                    height: 40,
                    width: deviceWidth,
                    decoration: BoxDecoration(
                      color: appColors['accent'],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        defaultBoxShadow,
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Main Menu",
                        style: getTextStyle(
                            textColor: 'primary',
                            fontFamily: 'Roboto',
                            fontWeight: 700,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
