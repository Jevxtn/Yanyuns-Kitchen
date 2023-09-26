library global_widgets;

import 'package:flutter/material.dart';
import 'package:yanyuns_kitchen/Screens/cart_screen.dart';
import 'package:yanyuns_kitchen/Screens/profile_screen.dart';
import 'package:yanyuns_kitchen/styles.dart';

Widget bottomNavBar(context, deviceWidth, {currentScreen = ""}) => Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      width: deviceWidth,
      decoration: BoxDecoration(
        color: appColors['accent'],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              if (currentScreen == "main") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Cart(),
                  ),
                );
              } else if (currentScreen != "cart") {
                if(currentScreen == "my_reviews" || currentScreen == "order_history"){
                  Navigator.pop(context);
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Cart(),
                  ),
                );
              }
            },
            child: Container(
              width: 80,
              height: 46,
              decoration: BoxDecoration(
                color: appColors['black'],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  defaultBoxShadow,
                ],
              ),
              child: Icon(
                Icons.shopping_cart,
                color: appColors['primary'],
                size: 34,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currentScreen == "main") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Profile(),
                  ),
                );
              } else if (currentScreen == "my_reviews" || currentScreen == "order_history") {
                Navigator.pop(context);
              } else if (currentScreen != "profile") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Profile(),
                  ),
                );
              }
            },
            child: Container(
              width: 80,
              height: 46,
              decoration: BoxDecoration(
                color: appColors['black'],
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  defaultBoxShadow,
                ],
              ),
              child: Icon(
                Icons.person_rounded,
                color: appColors['primary'],
                size: 34,
              ),
            ),
          ),
        ],
      ),
    );

Widget reviewWidget(deviceWidth, reviews) => Padding(
  padding: const EdgeInsets.only(top: 8, bottom: 70),
  child: ListView.builder(
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: reviews.length,
    itemBuilder: (context, index) {
      Map<String, dynamic> review = reviews[index];

      return Padding(
        padding: EdgeInsets.only(top: index == 0 ? 0 : 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: SizedBox(
            width: deviceWidth,
            child: Column(
              children: [
                Divider(
                  color: appColors['grey174'],
                  thickness: 2,
                  height: 0,
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Align(
                        alignment: FractionalOffset.centerRight,
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: appColors['black'],
                          size: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Image.asset(
                              review['path'],
                              width: 60,
                              height: 60,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: SizedBox(
                                height: 60,
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 5),
                                          child: SizedBox(
                                            width: 100,
                                            child: Text(
                                              review['name'],
                                              style: getTextStyle(
                                                textColor: 'black',
                                                fontFamily: 'Roboto',
                                                fontWeight: 400,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 5),
                                          child: SizedBox(
                                            width: 20,
                                            child: Text(
                                              textAlign: TextAlign.right,
                                              "${review['rating']}",
                                              style: getTextStyle(
                                                textColor: 'black',
                                                fontFamily: 'Roboto',
                                                fontWeight: 700,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                        ratingWidget(review['rating']),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 8),
                                      child: Text(
                                        "${review['message']}",
                                        style: getTextStyle(
                                          textColor: 'grey130',
                                          fontFamily: 'Roboto',
                                          fontWeight: 700,
                                          fontSize: 10,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  ),
);

Widget ratingWidget(rating) {
  List<Widget> stars = [];

  for (int i = 0; i < rating.truncate(); i++) {
    stars.add(
      Icon(
        Icons.star,
        color: appColors['gold'],
        size: 13,
      ),
    );
  }

  return Row(
    children: stars,
  );
}