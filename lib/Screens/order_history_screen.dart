import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:yanyuns_kitchen/Screens/landing_screen.dart';
import 'package:yanyuns_kitchen/Screens/location_setup_screen.dart';
import 'package:yanyuns_kitchen/Widgets/global_widgets.dart';
import 'package:yanyuns_kitchen/globals.dart';
import 'package:yanyuns_kitchen/query.dart';
import 'package:yanyuns_kitchen/styles.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
        builder: (context, snapshot) {
          return Container(
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
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: appColors['primary'],
                                  ),
                                ),
                              ),
                              Text(
                                "Order History",
                                style: getTextStyle(
                                    textColor: 'primary',
                                    fontFamily: 'Roboto',
                                    fontWeight: 700,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 50,
                            bottom: 57,
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: FractionalOffset.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 32),

                                      child: GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            orderHistory.clear();
                                          });

                                          await updateData('users', uid, orderHistory, field: "orderHistory");
                                        },
                                        child: Text(
                                          "Clear history",
                                          style: getTextStyle(
                                            textColor: 'grey130',
                                            fontFamily: 'Roboto',
                                            fontWeight: 400,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    itemCount: orderHistory.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> item =
                                      orderHistory[index];

                                      return Padding(
                                        padding: EdgeInsets.only(
                                            top: index == 0 ? 35 : 24),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 70,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        right: 10),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(2),
                                                      clipBehavior: Clip.hardEdge,
                                                      child: Image.network(
                                                        "${item['dish']['path']}",
                                                        width: 70,
                                                        height: 70,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        item['dish']['name'],
                                                        style: getTextStyle(
                                                          textColor: 'black',
                                                          fontFamily: 'Roboto',
                                                          fontWeight: 500,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            top: 13),
                                                        child: Text(
                                                          "₱${item['dish']['price'] * item['qty']}",
                                                          style: getTextStyle(
                                                            textColor: 'black',
                                                            fontFamily: 'Roboto',
                                                            fontWeight: 900,
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      setState(() {
                                                        orderHistory.removeAt(index);
                                                      });

                                                      await updateData('users', uid, orderHistory, field: "orderHistory");
                                                    },
                                                    child: Icon(
                                                      Icons.delete_outline,
                                                      color: appColors['accent'],
                                                      size: 40,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.only(top: 25),
                                              child: Divider(
                                                height: 0,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: bottomNavBar(context, deviceWidth,
                              currentScreen: "order_history"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
