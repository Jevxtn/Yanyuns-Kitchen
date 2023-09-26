import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yanyuns_kitchen/Screens/dish_detail_screen.dart';
import 'package:yanyuns_kitchen/globals.dart';
import 'package:yanyuns_kitchen/styles.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
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
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 49),
                              child: SizedBox(
                                height: 140,
                                width: deviceWidth,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  child: Image.network(
                                      "${dishes['sizzling t-bone']['path']}",
                                      fit: BoxFit.fitWidth),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: mealsWidget(
                                  deviceWidth, 'sizzling', 'Sizzling Meals'),
                            ),
                            mealsWidget(deviceWidth, 'silog', 'Silog Meals'),
                            mealsWidget(
                                deviceWidth, 'noodles/pasta', 'Noodles/Pasta'),
                            mealsWidget(deviceWidth, 'soup', 'Soups'),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 16,
                        ),
                        height: 50,
                        width: deviceWidth,
                        decoration: BoxDecoration(
                          color: appColors['black'],
                          boxShadow: [
                            defaultBoxShadow,
                          ],
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.menu,
                                color: appColors['primary'],
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Menu List",
                                style: getTextStyle(
                                    textColor: 'primary',
                                    fontFamily: 'Roboto',
                                    fontWeight: 700,
                                    fontSize: 16),
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
}

Widget mealsWidget(deviceWidth, mealType, title) {
  List meals = [];

  dishes.forEach((key, value) {
    if (value['type'] == mealType) {
      meals.add(value);
    }
  });

  return Column(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(vertical: 2),
        width: deviceWidth,
        color: appColors['black'],
        child: Center(
          child: Text(
            title,
            style: getTextStyle(
                textColor: 'primary',
                fontFamily: 'Roboto',
                fontWeight: 700,
                fontSize: 25),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: SizedBox(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: meals.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 7,
                  mainAxisSpacing: 7,
                  mainAxisExtent: 136),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DishDetail(
                        dish: meals[index],
                      ),
                    ),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        "${meals[index]['path']}",
                        fit: BoxFit.cover,
                      ),

                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(3),
                          width: (deviceWidth - 14) / 3,
                          color: appColors['primary'],
                          child: Center(
                            child: Text(
                              "₱ ${meals[index]['price']}",
                              style: getTextStyle(
                                textColor: 'black',
                                fontFamily: 'Roboto',
                                fontWeight: 900,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    ],
  );
}
