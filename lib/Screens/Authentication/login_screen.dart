import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:yanyuns_kitchen/Class/google_sign_in.dart';
import 'package:yanyuns_kitchen/Screens/main_menu_screen.dart';
import 'package:yanyuns_kitchen/styles.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  bool showPassword = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

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
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 57),
                        child: Center(
                          child: Text(
                            "Log in",
                            style: getTextStyle(
                              textColor: 'black',
                              fontFamily: 'Roboto',
                              fontWeight: 500,
                              fontSize: 30,
                              textShadow: defaultBoxShadow,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 53,
                          right: 53,
                          top: 88,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Email Input
                            Text(
                              "Email",
                              style: getTextStyle(
                                textColor: 'black',
                                fontFamily: 'Roboto',
                                fontWeight: 500,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              width: deviceWidth,
                              child: TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                  errorMaxLines: 3,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) => value!.isEmpty
                                    ? "This field is required"
                                    : !EmailValidator.validate(value)
                                        ? "Enter the email address in the format someone@example.com."
                                        : null,
                              ),
                            ),
                            // Password Input
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: Text(
                                "Password",
                                style: getTextStyle(
                                  textColor: 'black',
                                  fontFamily: 'Roboto',
                                  fontWeight: 500,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: deviceWidth,
                              child: TextFormField(
                                controller: passwordController,
                                obscureText: !showPassword,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () => setState(() {
                                      showPassword = !showPassword;
                                    }),
                                    child: Icon(
                                      showPassword
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: appColors['black'],
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) => value!.isEmpty
                                    ? "This field is required"
                                    : null,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 9),
                                child: Text(
                                  "Forgot Password",
                                  style: getTextStyle(
                                      textColor: 'purple',
                                      fontFamily: 'Roboto',
                                      fontWeight: 600,
                                      fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 46,
                          right: 46,
                          top: 29,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await authenticate();

                              if(!mounted) return;
                              context.go("/");
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 9),
                            decoration: BoxDecoration(
                              color: appColors['accent'],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Sign in",
                                style: getTextStyle(
                                    textColor: 'primary',
                                    fontFamily: 'Roboto',
                                    fontWeight: 500,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 46),
                        child: Center(
                          child: Text(
                            "Or continue with",
                            style: getTextStyle(
                                textColor: 'grey130',
                                fontFamily: 'Roboto',
                                fontWeight: 400,
                                fontSize: 13),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 34),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Container(
                                width: 49,
                                height: 49,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: appColors['grey238'],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset(
                                  "assets/images/logos/facebook_logo.png",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: GestureDetector(
                                onTap: () async {
                                  signInUsingGoogle();
                                },
                                child: Container(
                                  width: 49,
                                  height: 49,
                                  padding: const EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                    color: appColors['grey238'],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.asset(
                                    "assets/images/logos/google_logo.png",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 34),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Text(
                                "Don't have an account?",
                                style: getTextStyle(
                                    textColor: 'black',
                                    fontFamily: 'Roboto',
                                    fontWeight: 400,
                                    fontSize: 15),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => context.pushReplacement('/signup'),
                              child: Text(
                                "Sign up",
                                style: getTextStyle(
                                  textColor: 'purple',
                                  fontFamily: 'Roboto',
                                  fontWeight: 500,
                                  fontSize: 15,
                                ),
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

  Future<void> authenticate() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
        case "wrong-password":
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Invalid Credentials"),
              backgroundColor: appColors['accent'],
            ),
          );
      }
    }
  }

  signInUsingGoogle() {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);

    provider.googleLogin();
  }
}
