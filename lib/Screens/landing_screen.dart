import 'package:flutter/material.dart';
import 'package:yanyuns_kitchen/styles.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: appColors['accent'],
      body: SizedBox(
        width: deviceWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 180),
              child: Image.asset("assets/images/logos/app_logo.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 55),
              child: Text(
                "YANYUN'S KITCHEN",
                style: getTextStyle(
                    textColor: 'primary',
                    fontFamily: 'PS2P',
                    fontWeight: 400,
                    fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
