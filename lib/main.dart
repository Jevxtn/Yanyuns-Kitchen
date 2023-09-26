import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:yanyuns_kitchen/Class/google_sign_in.dart';
import 'package:yanyuns_kitchen/Screens/Authentication/authentication.dart';
import 'package:yanyuns_kitchen/Screens/Authentication/login_screen.dart';
import 'package:yanyuns_kitchen/Screens/Authentication/signup_screen.dart';
import 'package:yanyuns_kitchen/Screens/cart_screen.dart';
import 'package:yanyuns_kitchen/Screens/main_menu_screen.dart';
import 'package:yanyuns_kitchen/Screens/menu_screen.dart';
import 'package:yanyuns_kitchen/Screens/profile_screen.dart';
import 'package:yanyuns_kitchen/query.dart';
import 'package:yanyuns_kitchen/styles.dart';

import 'Screens/landing_screen.dart';
import 'globals.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await getMenu();

  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return FutureBuilder(
          future: Future.delayed(const Duration(seconds: 2)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LandingScreen();
            } else {
              return StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      color: appColors['primary'],
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong!"));
                  } else if (snapshot.hasData) {
                    return const MainMenu();
                  } else {
                    return const Authentication();
                  }
                },
              );
            }
          },
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'main',
          builder: (BuildContext context, GoRouterState state) {
            return const MainMenu();
          },
        ),
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return const Login();
          },
        ),
        GoRoute(
          path: 'signup',
          builder: (BuildContext context, GoRouterState state) {
            return const SignUp();
          },
        ),
        GoRoute(
          path: 'menu',
          builder: (BuildContext context, GoRouterState state) {
            return const MenuScreen();
          },
        ),
        GoRoute(
          path: 'cart',
          builder: (BuildContext context, GoRouterState state) {
            return const Cart();
          },
        ),
        GoRoute(
          path: 'profile',
          builder: (BuildContext context, GoRouterState state) {
            return const Profile();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "YanYun's Kitchen",
        routerConfig: _router,
      ),
    );
  }
}

Future<dynamic> getMenu() async {
  List menu = await getData('menu');
  for (var item in menu) {
    dishes[item['docID']] = item;
    dishes[item['docID']].remove('docID');
  }

  return menu;
}
