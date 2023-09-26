import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yanyuns_kitchen/Screens/order_status_screen.dart';
import 'package:yanyuns_kitchen/globals.dart';
import 'package:yanyuns_kitchen/styles.dart';

class OrderConfirmation extends StatefulWidget {
  final address;
  const OrderConfirmation({Key? key, required this.address}) : super(key: key);

  @override
  State<OrderConfirmation> createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  late Placemark address = widget.address;
  final messageTextController = TextEditingController();

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
                      padding: const EdgeInsets.only(top: 50),
                      child: SizedBox(
                        width: deviceWidth,
                        height: deviceHeight,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, left: 24),
                                child: Text(
                                  "YanYun's Kitchen",
                                  style: getTextStyle(
                                    textColor: 'accent',
                                    fontFamily: 'Roboto',
                                    fontWeight: 400,
                                    fontSize: 28,
                                    textShadow: defaultBoxShadow,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Divider(
                                  height: 0,
                                  color: appColors['grey197'],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 14, left: 24, right: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Address",
                                      style: getTextStyle(
                                        textColor: 'black',
                                        fontFamily: 'Roboto',
                                        fontWeight: 900,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: appColors['grey242'],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              text: TextSpan(
                                                style: getTextStyle(
                                                    textColor: 'black',
                                                    fontFamily: 'Roboto',
                                                    fontWeight: 400,
                                                    fontSize: 15),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:
                                                        '${address.street} St.\n',
                                                  ),
                                                  TextSpan(
                                                      text:
                                                          '${address.subLocality}, ${address.locality}'),
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.edit,
                                                color: appColors['black'],
                                                size: 24),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 14),
                                child: Divider(
                                  height: 0,
                                  color: appColors['grey197'],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 24),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: cart.length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> order = cart[index];

                                    return Padding(
                                      padding: EdgeInsets.only(
                                          top: index == 0 ? 0 : 10),
                                      child: SizedBox(
                                        width: deviceWidth,
                                        height: 75,
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Image.network(
                                               "${order['dish']['path']}",
                                                width: 125,
                                                height: 75,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    order['dish']['name'],
                                                    style: getTextStyle(
                                                      textColor: 'black',
                                                      fontFamily: 'Roboto',
                                                      fontWeight: 400,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "₱${order['dish']['price']}",
                                                        style: getTextStyle(
                                                          textColor: 'black',
                                                          fontFamily: 'Roboto',
                                                          fontWeight: 400,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Text(
                                                        "x${order['qty']}",
                                                        style: getTextStyle(
                                                          textColor: 'black',
                                                          fontFamily: 'Roboto',
                                                          fontWeight: 400,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Divider(
                                height: 0,
                                color: appColors['grey197'],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order Total (${cart.length} Item)",
                                      style: getTextStyle(
                                        textColor: 'black',
                                        fontFamily: 'Roboto',
                                        fontWeight: 400,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      "₱${subTotal.toInt()}",
                                      style: getTextStyle(
                                        textColor: 'accent',
                                        fontFamily: 'Roboto',
                                        fontWeight: 400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 0,
                                color: appColors['grey197'],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Message:",
                                      style: getTextStyle(
                                        textColor: 'black',
                                        fontFamily: 'Roboto',
                                        fontWeight: 400,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: TextFormField(
                                        controller: messageTextController,
                                        style: getTextStyle(
                                          textColor: 'black',
                                          fontFamily: 'Roboto',
                                          fontWeight: 400,
                                          fontSize: 12,
                                        ),
                                        maxLines: messageTextController
                                                .text.isNotEmpty
                                            ? 2
                                            : 1,
                                        maxLength: messageTextController
                                                .text.isNotEmpty
                                            ? 100
                                            : null,
                                        decoration: InputDecoration.collapsed(
                                          filled: true,
                                          fillColor: appColors['primary'],
                                          hintStyle: getTextStyle(
                                            textColor: 'grey197',
                                            fontFamily: 'Roboto',
                                            fontWeight: 400,
                                            fontSize: 12,
                                          ),
                                          hintText: "Leave message...",
                                        ),
                                        onChanged: (value) => setState(() {}),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                height: 0,
                                color: appColors['grey197'],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Payment Method",
                                      style: getTextStyle(
                                        textColor: 'black',
                                        fontFamily: 'Roboto',
                                        fontWeight: 900,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        width: deviceWidth,
                                        decoration: BoxDecoration(
                                          color: appColors['grey242'],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(
                                            "Cash On Delivery (COD)",
                                            style: getTextStyle(
                                              textColor: 'black',
                                              fontFamily: 'Roboto',
                                              fontWeight: 400,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                height: 0,
                                color: appColors['grey197'],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 24, right: 24),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Merchandise Subtotal",
                                          style: getTextStyle(
                                            textColor: 'black',
                                            fontFamily: 'Roboto',
                                            fontWeight: 200,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "₱${subTotal.toInt()}",
                                          style: getTextStyle(
                                            textColor: 'black',
                                            fontFamily: 'Roboto',
                                            fontWeight: 200,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Shipping Subtotal",
                                          style: getTextStyle(
                                            textColor: 'black',
                                            fontFamily: 'Roboto',
                                            fontWeight: 200,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "₱${deliveryFee.toInt()}",
                                          style: getTextStyle(
                                            textColor: 'black',
                                            fontFamily: 'Roboto',
                                            fontWeight: 200,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total Payment",
                                          style: getTextStyle(
                                            textColor: 'black',
                                            fontFamily: 'Roboto',
                                            fontWeight: 800,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          "₱${total.toInt()}",
                                          style: getTextStyle(
                                            textColor: 'accent',
                                            fontFamily: 'Roboto',
                                            fontWeight: 800,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 50, bottom: 60),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OrderStatus(address: address),
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                      width: 270,
                                      decoration: BoxDecoration(
                                        color: appColors['accent'],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Order",
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
                              )
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
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.arrow_back,
                                color: appColors['primary'],
                              ),
                            ),
                          ),
                          Text(
                            "Review Order",
                            style: getTextStyle(
                                textColor: 'primary',
                                fontFamily: 'Roboto',
                                fontWeight: 700,
                                fontSize: 16),
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
}
