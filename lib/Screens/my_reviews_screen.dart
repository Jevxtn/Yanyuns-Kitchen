import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:yanyuns_kitchen/Screens/main_menu_screen.dart';
import 'package:yanyuns_kitchen/Widgets/global_widgets.dart';
import 'package:yanyuns_kitchen/globals.dart';
import 'package:yanyuns_kitchen/styles.dart';

class MyReviews extends StatefulWidget {
  const MyReviews({Key? key}) : super(key: key);

  @override
  State<MyReviews> createState() => _MyReviewsState();
}

class _MyReviewsState extends State<MyReviews> {
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
              color: appColors['primary'],
              child: SizedBox(
                height: deviceHeight,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 49),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          width: deviceWidth,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 180,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                      top: 0,
                                      child: Image.asset(
                                        "assets/images/reviews_header.png",
                                        height: 140,
                                        width: deviceWidth,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        width: 73,
                                        height: 73,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            defaultBoxShadow,
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.asset(
                                              "assets/images/users/user_1.png"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 14),
                                    child: Text(
                                      "Jméno Příjmení",
                                      style: getTextStyle(
                                        textColor: 'black',
                                        fontFamily: 'Roboto',
                                        fontWeight: 700,
                                        fontSize: 16,
                                        textShadow: defaultBoxShadow,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 14),
                                    child: Center(
                                      child: Text(
                                        "Create a Review",
                                        style: getTextStyle(
                                          textColor: 'accent',
                                          fontFamily: 'Roboto',
                                          fontWeight: 700,
                                          fontSize: 25,
                                          textShadow: defaultBoxShadow,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.star_border_sharp,
                                          color: Colors.black,
                                          size: 44,
                                        ),
                                        Icon(
                                          Icons.star_border_sharp,
                                          color: Colors.black,
                                          size: 44,
                                        ),
                                        Icon(
                                          Icons.star_border_sharp,
                                          color: Colors.black,
                                          size: 44,
                                        ),
                                        Icon(
                                          Icons.star_border_sharp,
                                          color: Colors.black,
                                          size: 44,
                                        ),
                                        Icon(
                                          Icons.star_border_sharp,
                                          color: Colors.black,
                                          size: 44,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 13, left: 19, right: 19),
                                    child: Container(
                                      height: 90,
                                      width: deviceWidth,
                                      decoration: BoxDecoration(boxShadow: [
                                        defaultBoxShadow,
                                      ]),
                                      child: TextFormField(
                                        expands: true,
                                        minLines: null,
                                        maxLines: null,
                                        style: getTextStyle(
                                          textColor: 'black',
                                          fontFamily: 'Roboto',
                                          fontWeight: 400,
                                          fontSize: 15,
                                        ),
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.zero,
                                              borderSide: BorderSide(
                                                color: appColors['black']!,
                                              ),
                                            ),
                                            filled: true,
                                            fillColor: appColors['primary'],
                                            hintStyle: getTextStyle(
                                              textColor: 'grey210',
                                              fontFamily: 'Roboto',
                                              fontWeight: 400,
                                              fontSize: 15,
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(15),
                                            hintText: "Write your review..."),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 41, left: 78, right: 78),
                                    child: Container(
                                      height: 37,
                                      width: deviceWidth,
                                      decoration: BoxDecoration(
                                        color: appColors['accent'],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Submit",
                                          style: getTextStyle(
                                            textColor: 'primary',
                                            fontFamily: 'Roboto',
                                            fontWeight: 500,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Center(
                                      child: Text(
                                        "My Reviews",
                                        style: getTextStyle(
                                          textColor: 'accent',
                                          fontFamily: 'Roboto',
                                          fontWeight: 700,
                                          fontSize: 25,
                                          textShadow: defaultBoxShadow,
                                        ),
                                      ),
                                    ),
                                  ),
                                  reviewWidget(deviceWidth, myReviews),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 50,
                      width: deviceWidth,
                      decoration: BoxDecoration(
                        color: appColors['black'],
                        boxShadow: [
                          defaultBoxShadow,
                        ],
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
                    Positioned(
                      bottom: 0,
                      child: bottomNavBar(context, deviceWidth,
                          currentScreen: "my_reviews"),
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
}
