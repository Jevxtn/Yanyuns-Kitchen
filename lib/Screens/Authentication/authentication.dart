import 'package:flutter/material.dart';
import 'package:yanyuns_kitchen/Screens/Authentication/signup_screen.dart';
import 'package:yanyuns_kitchen/Screens/Authentication/login_screen.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool haveAccount = true;


  @override
  Widget build(BuildContext context) {
    return haveAccount
        ? const Login()
        : SignUp();
  }
}
