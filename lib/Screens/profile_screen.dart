import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:yanyuns_kitchen/Class/google_sign_in.dart';
import 'package:yanyuns_kitchen/Screens/cart_screen.dart';
import 'package:yanyuns_kitchen/Screens/my_reviews_screen.dart';
import 'package:yanyuns_kitchen/Screens/order_history_screen.dart';
import 'package:yanyuns_kitchen/Screens/store_location_screen.dart';
import 'package:yanyuns_kitchen/Widgets/global_widgets.dart';
import 'package:yanyuns_kitchen/globals.dart';
import 'package:yanyuns_kitchen/query.dart';
import 'package:yanyuns_kitchen/styles.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        context.pushReplacement('/main');
        return false;
      },
      child: GestureDetector(
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
                        padding: const EdgeInsets.only(top: 50),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SizedBox(
                            width: deviceWidth,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 60),
                              child: Column(
                                children: [
                                  Container(
                                    width: 73,
                                    height: 73,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        defaultBoxShadow,
                                      ],
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                          "assets/images/users/user_1.png"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: Text(
                                      "${userData['displayName']}",
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
                                    padding: const EdgeInsets.only(
                                        top: 30, left: 7, right: 7),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () =>
                                              context.pushReplacement("/main"),
                                          child: Container(
                                            height: 40,
                                            width: deviceWidth,
                                            decoration: BoxDecoration(
                                              color: appColors['accent'],
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: GestureDetector(
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const StoreLocation(),
                                                  )),
                                              child: Container(
                                                height: 40,
                                                width: deviceWidth,
                                                decoration: BoxDecoration(
                                                  color: appColors['accent'],
                                                  boxShadow: [
                                                    defaultBoxShadow,
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Store Location",
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: GestureDetector(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const Cart(),
                                              ),
                                            ),
                                            child: Container(
                                              height: 40,
                                              width: deviceWidth,
                                              decoration: BoxDecoration(
                                                color: appColors['accent'],
                                                boxShadow: [
                                                  defaultBoxShadow,
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Cart",
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: GestureDetector(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const MyReviews(),
                                              ),
                                            ),
                                            child: Container(
                                              height: 40,
                                              width: deviceWidth,
                                              decoration: BoxDecoration(
                                                color: appColors['accent'],
                                                boxShadow: [
                                                  defaultBoxShadow,
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Review",
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: GestureDetector(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const OrderHistory(),
                                              ),
                                            ),
                                            child: Container(
                                              height: 40,
                                              width: deviceWidth,
                                              decoration: BoxDecoration(
                                                color: appColors['accent'],
                                                boxShadow: [
                                                  defaultBoxShadow,
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Order History",
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 80),
                                          child: GestureDetector(
                                            onTap: () async {
                                              if (FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .providerData
                                                      .first
                                                      .providerId ==
                                                  "google.com") {
                                                final provider = Provider.of<
                                                        GoogleSignInProvider>(
                                                    context,
                                                    listen: false);

                                                await provider.googleLogout();
                                              } else {
                                                await FirebaseAuth.instance
                                                    .signOut();
                                              }

                                              if (!mounted) return;
                                              context.pushReplacement('/');
                                            },
                                            child: Container(
                                              height: 40,
                                              width: deviceWidth,
                                              decoration: BoxDecoration(
                                                color: appColors['accent'],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  defaultBoxShadow,
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Log out",
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
                                      ],
                                    ),
                                  )
                                ],
                              ),
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
                            currentScreen: "profile"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
