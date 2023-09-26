import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yanyuns_kitchen/Screens/landing_screen.dart';
import 'package:yanyuns_kitchen/Screens/location_setup_screen.dart';
import 'package:yanyuns_kitchen/Widgets/global_widgets.dart';
import 'package:yanyuns_kitchen/globals.dart';
import 'package:yanyuns_kitchen/query.dart';
import 'package:yanyuns_kitchen/styles.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    getSubtotal();
    getTotal();

    return WillPopScope(
      onWillPop: () async {
        context.pop();
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
                child: cart.isNotEmpty
                    ? StreamBuilder<Object>(
                      stream: FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
                      builder: (context, snapshot) {
                        return SizedBox(
                            height: deviceHeight,
                            child: Stack(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 16),
                                  height: 50,
                                  width: deviceWidth,
                                  decoration: BoxDecoration(
                                    color: appColors['black'],
                                    boxShadow: [
                                      defaultBoxShadow,
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          context.pop();
                                        },
                                        child: Icon(
                                          Icons.arrow_back,
                                          color: appColors['primary'],
                                        ),
                                      ),
                                      Text(
                                        "Cart",
                                        style: getTextStyle(
                                            textColor: 'primary',
                                            fontFamily: 'Roboto',
                                            fontWeight: 700,
                                            fontSize: 16),
                                      ),
                                      Icon(
                                        Icons.menu,
                                        color: appColors['primary'],
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
                                    child: Column(
                                      children: [
                                        // ORDERS
                                        Padding(
                                          padding: const EdgeInsets.only(top: 28),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: cart.length,
                                            itemBuilder: (context, index) {
                                              Map<String, dynamic> dish =
                                                  cart[index]['dish'];
                                              int qty = cart[index]['qty'];
                                              int price =
                                                  cart[index]['dish']['price'];
                                              double itemTotal =
                                                  (price * qty).toDouble();

                                              return Padding(
                                                padding: EdgeInsets.only(
                                                  top: index == 0 ? 0 : 10,
                                                  right: 8,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 6),
                                                      child: SizedBox(
                                                        width: 190,
                                                        height: 200,
                                                        child: ClipRRect(
                                                          clipBehavior:
                                                              Clip.hardEdge,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topRight:
                                                                Radius.circular(20),
                                                            bottomRight:
                                                                Radius.circular(20),
                                                          ),
                                                          child: Image.network(
                                                            "${dish['path']}",
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: SizedBox(
                                                        height: 200,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              dish['name'],
                                                              style: getTextStyle(
                                                                textColor: 'black',
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight: 700,
                                                                fontSize: 18,
                                                                textShadow:
                                                                    defaultBoxShadow,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(top: 9),
                                                              child: Text(
                                                                dish['description'],
                                                                maxLines: 9,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign: TextAlign
                                                                    .justify,
                                                                style: getTextStyle(
                                                                  textColor:
                                                                      'black',
                                                                  fontFamily:
                                                                      'Roboto',
                                                                  fontWeight: 400,
                                                                  fontSize: 10,
                                                                ),
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  width: 40,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: appColors[
                                                                        'primary'],
                                                                    border:
                                                                        Border.all(
                                                                      color: appColors[
                                                                          'grey210']!,
                                                                    ),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "$qty",
                                                                      style:
                                                                          getTextStyle(
                                                                        textColor:
                                                                            'accent',
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontWeight:
                                                                            400,
                                                                        fontSize:
                                                                            13,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        setState(
                                                                            () {
                                                                          cart[index]
                                                                              [
                                                                              'qty'] += 1;
                                                                        });

                                                                        await updateData(
                                                                            'users',
                                                                            uid,
                                                                            cart,
                                                                            field:
                                                                                "cart");
                                                                      },
                                                                      child: Icon(
                                                                        Icons
                                                                            .arrow_drop_up_sharp,
                                                                        color: appColors[
                                                                            'black'],
                                                                        size: 20,
                                                                      ),
                                                                    ),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () async {
                                                                        setState(
                                                                            () {
                                                                          cart[index]
                                                                              [
                                                                              'qty'] -= 1;
                                                                          if (cart[index]
                                                                                  [
                                                                                  'qty'] ==
                                                                              0) {
                                                                            cart.removeAt(
                                                                                index);
                                                                          }
                                                                        });

                                                                        await updateData(
                                                                            'users',
                                                                            uid,
                                                                            cart,
                                                                            field:
                                                                                "cart");

                                                                        if (!mounted)
                                                                          return;

                                                                        if (cart
                                                                            .isEmpty) {
                                                                          Navigator.pop(
                                                                              context);
                                                                        }
                                                                      },
                                                                      child: Icon(
                                                                        Icons
                                                                            .arrow_drop_down_sharp,
                                                                        color: appColors[
                                                                            'black'],
                                                                        size: 20,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const Spacer(),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          right: 8),
                                                                  child: Text(
                                                                      "₱${itemTotal.toStringAsFixed(2)}"),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        // SUMMARY
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 70, left: 28, right: 28),
                                          child: SizedBox(
                                            width: deviceWidth,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Summary",
                                                  style: getTextStyle(
                                                      textColor: 'black',
                                                      fontFamily: 'Roboto',
                                                      fontWeight: 900,
                                                      fontSize: 20),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(top: 2),
                                                  child: Container(
                                                    height: 3,
                                                    width: 87,
                                                    decoration: BoxDecoration(
                                                        color: appColors['accent'],
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                50)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Subtotal",
                                                        style: getTextStyle(
                                                            textColor: 'grey130',
                                                            fontFamily: 'Roboto',
                                                            fontWeight: 400,
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                        "₱${subTotal.toStringAsFixed(2)}",
                                                        style: getTextStyle(
                                                            textColor: 'grey130',
                                                            fontFamily: 'Roboto',
                                                            fontWeight: 400,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const Divider(),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Delivery Fee",
                                                      style: getTextStyle(
                                                          textColor: 'grey130',
                                                          fontFamily: 'Roboto',
                                                          fontWeight: 400,
                                                          fontSize: 15),
                                                    ),
                                                    Text(
                                                      "₱${deliveryFee.toStringAsFixed(2)}",
                                                      style: getTextStyle(
                                                          textColor: 'grey130',
                                                          fontFamily: 'Roboto',
                                                          fontWeight: 400,
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                                const Divider(),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 40),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Total",
                                                        style: getTextStyle(
                                                            textColor: 'black',
                                                            fontFamily: 'Roboto',
                                                            fontWeight: 900,
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        "₱${total.toStringAsFixed(2)}",
                                                        style: getTextStyle(
                                                            textColor: 'black',
                                                            fontFamily: 'Roboto',
                                                            fontWeight: 900,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        // CHECKOUT BUTTON
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 45, bottom: 60),
                                          child: GestureDetector(
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const LocationSetup(),
                                              ),
                                            ),
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 16,
                                              ),
                                              width: 270,
                                              decoration: BoxDecoration(
                                                color: appColors['accent'],
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Checkout",
                                                  style: getTextStyle(
                                                      textColor: 'primary',
                                                      fontFamily: 'Roboto',
                                                      fontWeight: 700,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: bottomNavBar(context, deviceWidth,
                                      currentScreen: "cart"),
                                )
                              ],
                            ),
                          );
                      }
                    )
                    : SizedBox(
                        height: deviceHeight,
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              height: 50,
                              width: deviceWidth,
                              decoration: BoxDecoration(
                                color: appColors['black'],
                                boxShadow: [
                                  defaultBoxShadow,
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: appColors['primary'],
                                    ),
                                  ),
                                  Text(
                                    "Cart",
                                    style: getTextStyle(
                                        textColor: 'primary',
                                        fontFamily: 'Roboto',
                                        fontWeight: 700,
                                        fontSize: 16),
                                  ),
                                  Icon(
                                    Icons.menu,
                                    color: appColors['primary'],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    color: appColors['grey210'],
                                    size: 48,
                                  ),
                                  Text(
                                    "Cart is empty",
                                    style: getTextStyle(
                                      textColor: 'grey210',
                                      fontFamily: 'Roboto',
                                      fontWeight: 700,
                                      fontSize: 28,
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
      ),
    );
  }

  void getSubtotal() {
    subTotal = 0;

    for (var item in cart) {
      int itemPrice = item['dish']['price'];
      int qty = item['qty'];

      subTotal += (qty * itemPrice).toDouble();
    }
  }

  void getTotal() {
    total = 0;

    total = subTotal + deliveryFee;
  }
}
