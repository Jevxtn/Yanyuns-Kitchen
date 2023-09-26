import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:yanyuns_kitchen/Screens/cart_screen.dart';
import 'package:yanyuns_kitchen/Widgets/global_widgets.dart';
import 'package:yanyuns_kitchen/globals.dart';
import 'package:yanyuns_kitchen/query.dart';
import 'package:yanyuns_kitchen/styles.dart';

class DishDetail extends StatefulWidget {
  final dish;
  const DishDetail({Key? key, required this.dish}) : super(key: key);

  @override
  State<DishDetail> createState() => _DishDetailState();
}

class _DishDetailState extends State<DishDetail> {
  Map<String, dynamic> dish = {};
  /* String addition = additions.first;*/
  int qty = 1;

  @override
  void initState() {
    dish = widget.dish;
    super.initState();
  }

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
                    SizedBox(
                      height: deviceHeight * .8,
                      width: deviceWidth,
                      child: Image.network(
                        "${dish['path']}",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: appColors['primary'],
                                ),
                              ),
                              Icon(
                                Icons.menu,
                                color: appColors['primary'],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          width: deviceWidth,
                          decoration:
                              BoxDecoration(color: appColors['white.12']),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                dish['name'],
                                style: getTextStyle(
                                  textColor: 'primary',
                                  fontFamily: 'Roboto',
                                  fontWeight: 700,
                                  fontSize: 22,
                                  textShadow: defaultBoxShadow,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      child: Column(
                        children: [
                          Container(
                            width: deviceWidth,
                            decoration: BoxDecoration(
                              color: appColors['primary'],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // DESCRIPTION
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18, right: 18, top: 18),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Description",
                                        style: getTextStyle(
                                          textColor: 'black',
                                          fontFamily: 'Roboto',
                                          fontWeight: 700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Text(
                                          dish['description'],
                                          style: getTextStyle(
                                            textColor: 'black',
                                            fontFamily: 'Roboto',
                                            fontWeight: 400,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Divider(
                                          color: appColors['grey89'],
                                          height: 0,
                                        ),
                                      ),
                                      /*// ADDITIONS
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2),
                                        child: Text(
                                          "Additions",
                                          style: getTextStyle(
                                            textColor: 'black',
                                            fontFamily: 'Roboto',
                                            fontWeight: 500,
                                            fontSize: 18,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 6),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color: appColors['accent']!,
                                            ),
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              value: addition,
                                              isDense: true,
                                              isExpanded: true,
                                              icon: Icon(
                                                Icons.keyboard_arrow_down,
                                                color: appColors['accent'],
                                              ),
                                              items: additions.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: getTextStyle(
                                                        textColor: 'black',
                                                        fontFamily: 'Roboto',
                                                        fontWeight: 400,
                                                        fontSize: 10),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (value) =>
                                                  setState(() {
                                                addition = value!;
                                              }),
                                            ),
                                          ),
                                        ),
                                      ),*/
                                      // QTY
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Container(
                                          width: deviceWidth,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                            color: appColors['black'],
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            border: Border.all(
                                              color: appColors['primary']!,
                                            ),
                                            boxShadow: [
                                              defaultBoxShadow,
                                            ],
                                          ),
                                          child: Center(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 15),
                                              decoration: BoxDecoration(
                                                color: appColors['black'],
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                  color: appColors['primary']!,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () => setState(() {
                                                      if (qty > 1) {
                                                        qty -= 1;
                                                      }
                                                    }),
                                                    child: Icon(
                                                      Icons.remove,
                                                      color:
                                                          appColors['accent'],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
                                                    child: SizedBox(
                                                      width: 50,
                                                      child: Center(
                                                        child: Text(
                                                          "$qty",
                                                          style: getTextStyle(
                                                            textColor:
                                                                'primary',
                                                            fontFamily:
                                                                'Roboto',
                                                            fontWeight: 900,
                                                            fontSize: 21,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () => setState(() {
                                                      qty += 1;
                                                    }),
                                                    child: Icon(
                                                      Icons.add,
                                                      color:
                                                          appColors['accent'],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 29, right: 29, bottom: 7),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 13),
                                          child: GestureDetector(
                                            onTap: () async {
                                              await addToCart();
                                            },
                                            child: Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: appColors['primary'],
                                                border: Border.all(
                                                  color: appColors['black']!,
                                                  width: 2,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Add to Cart",
                                                  style: getTextStyle(
                                                      textColor: 'black',
                                                      fontFamily: 'Roboto',
                                                      fontWeight: 700,
                                                      fontSize: 18),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 13),
                                          child: GestureDetector(
                                            onTap: () async {
                                              await addToCart();

                                              if (!mounted) return;
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Cart(),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: appColors['accent'],
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Order",
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
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          bottomNavBar(context, deviceWidth),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addToCart() async {
    cart.clear();

    Map<String, dynamic> order = {
      "dish": dish,
      "qty": qty,
    };

    List<dynamic> data = await getData('users', uid: uid, field: "cart");

    for (var element in data) {
      cart.add(element);
    }

    for (int i = 0; i < cart.length; i++) {
      if (cart[i]['dish']['name'] == order['dish']['name']) {
        cart[i]['qty'] += order['qty'];
        await updateData('users', uid, cart, field: "cart");
        break;
      } else if (i == cart.length - 1) {
        cart.add(order);
        await updateData('users', uid, cart, field: "cart");
        break;
      }
    }

    if (cart.isEmpty) {
      cart.add(order);
      await updateData('users', uid, cart, field: "cart");
    }
  }
}
