import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:yanyuns_kitchen/globals.dart';
import 'package:yanyuns_kitchen/styles.dart';

import '../query.dart';

class OrderStatus extends StatefulWidget {
  final address;
  const OrderStatus({Key? key, required this.address}) : super(key: key);

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
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
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Image.asset(
                                    "assets/images/logos/app_logo.png",
                                    width: 120,
                                    height: 120,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Center(
                                  child: Text(
                                    "You order is being prepared",
                                    style: getTextStyle(
                                      textColor: 'black',
                                      fontFamily: 'Roboto',
                                      fontWeight: 900,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Center(
                                  child: Text(
                                    "YanYun's Kitchen Delivery",
                                    style: getTextStyle(
                                      textColor: 'accent',
                                      fontFamily: 'Roboto',
                                      fontWeight: 400,
                                      fontSize: 25,
                                      textShadow: defaultBoxShadow,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, left: 24),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: ClipRRect(
                                        clipBehavior: Clip.hardEdge,
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(
                                          "assets/images/users/driver.png",
                                          height: 48,
                                          width: 48,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Halli",
                                          style: getTextStyle(
                                            textColor: 'black',
                                            fontFamily: 'Roboto',
                                            fontWeight: 900,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          "Your driver",
                                          style: getTextStyle(
                                            textColor: 'grey130',
                                            fontFamily: 'Roboto',
                                            fontWeight: 400,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30, left: 24, right: 24),
                                child: Divider(
                                  height: 0,
                                  color: appColors['grey197'],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Address",
                                      style: getTextStyle(
                                        textColor: 'black',
                                        fontFamily: 'Roboto',
                                        fontWeight: 900,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: RichText(
                                        text: TextSpan(
                                          style: getTextStyle(
                                              textColor: 'grey130',
                                              fontFamily: 'Roboto',
                                              fontWeight: 400,
                                              fontSize: 15),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '${address.street} St.\n',
                                            ),
                                            TextSpan(
                                                text:
                                                    '${address.subLocality}, ${address.locality}'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Divider(
                                  height: 0,
                                  color: appColors['grey197'],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 24),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order Details",
                                      style: getTextStyle(
                                        textColor: 'black',
                                        fontFamily: 'Roboto',
                                        fontWeight: 900,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: cart.length,
                                            itemBuilder: (context, index) {
                                              Map<String, dynamic> item =
                                                  cart[index];

                                              return Text(
                                                "${item['qty']}x - ${item['dish']['name']}",
                                                style: getTextStyle(
                                                  textColor: 'grey130',
                                                  fontFamily: 'Roboto',
                                                  fontWeight: 500,
                                                  fontSize: 15,
                                                ),
                                              );
                                            },
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "View Receipt",
                                              style: getTextStyle(
                                                  textColor: 'accent',
                                                  fontFamily: 'Roboto',
                                                  fontWeight: 500,
                                                  fontSize: 15),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Divider(
                                  height: 0,
                                  color: appColors['grey197'],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 100, bottom: 60),
                                child: GestureDetector(
                                  onTap: () async {
                                    List<dynamic> data = await getData('users', uid: uid, field: "orderHistory");

                                    orderHistory.clear();
                                    for (var element in data) {
                                      orderHistory.add(element);
                                    }

                                    orderHistory.addAll(cart);

                                    await updateData('users', uid, orderHistory, field: "orderHistory");

                                    cart.clear();
                                    await updateData('users', uid, cart, field: "cart");


                                    if(!mounted) return;
                                    context.pushReplacement('/main');
                                  },
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
                                          "Order Received",
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
