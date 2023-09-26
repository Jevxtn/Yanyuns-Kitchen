import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yanyuns_kitchen/Screens/dish_detail_screen.dart';
import 'package:yanyuns_kitchen/Screens/main_menu_screen.dart';
import 'package:yanyuns_kitchen/Screens/profile_screen.dart';
import 'package:yanyuns_kitchen/Widgets/global_widgets.dart';
import 'package:yanyuns_kitchen/globals.dart';
import 'package:yanyuns_kitchen/styles.dart';

import '../query.dart';
import 'menu_screen.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  Stream<DocumentSnapshot<Map<String, dynamic>>> userDataStream =
      const Stream.empty();

  @override
  void initState() {
    uid = FirebaseAuth.instance.currentUser!.uid;

    userDataStream =
        FirebaseFirestore.instance.collection('users').doc(uid).snapshots();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return StreamBuilder(
        stream: userDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: deviceHeight,
              color: appColors['primary'],
              child: Center(
                child: CircularProgressIndicator(
                  color: appColors['accent']!,
                ),
              ),
            );
          }

          userData = snapshot.data!.data()!;

          cart.clear();
          List<dynamic> data = userData['cart'];
          for (var element in data) {
            cart.add(element);
          }

          orderHistory.clear();
          data = userData['orderHistory'];

          for (var element in data) {
            orderHistory.add(element);
          }

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
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 49),
                                  child: Container(
                                    width: deviceWidth,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: appColors['black'],
                                      boxShadow: [
                                        defaultBoxShadow,
                                      ],
                                    ),
                                    child: Center(
                                      child: Text(
                                        "YanYun's Kitchen",
                                        style: getTextStyle(
                                          textColor: 'accent',
                                          fontFamily: 'PS2P',
                                          fontWeight: 400,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Center(
                                    child: Text(
                                      "Sizzling Meals",
                                      style: getTextStyle(
                                        textColor: 'accent',
                                        fontFamily: 'Roboto',
                                        fontWeight: 700,
                                        fontSize: 18,
                                        textShadow: defaultBoxShadow,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 13),
                                    width: deviceWidth,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: appColors['accent'],
                                        boxShadow: [
                                          defaultBoxShadow,
                                        ]),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 13),
                                            child: GestureDetector(
                                              onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DishDetail(
                                                          dish: dishes[
                                                              'sizzling sisig']),
                                                ),
                                              ),
                                              child: SizedBox(
                                                width: 124,
                                                height: 114,
                                                child: Image.network(
                                                  "${dishes['sizzling sisig']['path']}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 13),
                                            child: GestureDetector(
                                              onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DishDetail(
                                                          dish: dishes[
                                                              'sizzling t-bone']),
                                                ),
                                              ),
                                              child: SizedBox(
                                                width: 124,
                                                height: 114,
                                                child: Image.network(
                                                  "${dishes['sizzling t-bone']['path']}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 13, right: 13),
                                            child: GestureDetector(
                                              onTap: () => Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DishDetail(
                                                          dish: dishes[
                                                              'sizzling pusit']),
                                                ),
                                              ),
                                              child: SizedBox(
                                                width: 124,
                                                height: 114,
                                                child: Image.network(
                                                  "${dishes['sizzling pusit']['path']}",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 66, right: 66, top: 23),
                                  child: GestureDetector(
                                    onTap: () => context.go('/menu'),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 9),
                                      decoration: BoxDecoration(
                                        color: appColors['accent'],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Menu",
                                          style: getTextStyle(
                                              textColor: 'primary',
                                              fontFamily: 'Roboto',
                                              fontWeight: 700,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Center(
                                    child: Text(
                                      "Reviews",
                                      style: getTextStyle(
                                        textColor: 'accent',
                                        fontFamily: 'Roboto',
                                        fontWeight: 700,
                                        fontSize: 18,
                                        textShadow: defaultBoxShadow,
                                      ),
                                    ),
                                  ),
                                ),
                                reviewWidget(deviceWidth, reviews)
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 5),
                            height: 50,
                            width: deviceWidth,
                            decoration: BoxDecoration(
                              color: appColors['black'],
                              boxShadow: [
                                defaultBoxShadow,
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.menu,
                                    color: appColors['primary'],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Profile(),
                                    ),
                                  ),
                                  child: Image.asset(
                                    "assets/images/users/user_1.png",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: bottomNavBar(context, deviceWidth,
                                currentScreen: "main"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
