import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yanyuns_kitchen/query.dart';
import 'package:yanyuns_kitchen/styles.dart';
import 'package:yanyuns_kitchen/utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();

  bool showPassword = false;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: WillPopScope(
        onWillPop: () async {
          context.pushReplacement('/login');
          return false;
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 22,
                        ),
                        width: deviceWidth,
                        decoration: BoxDecoration(
                          color: appColors['black'],
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () => context.pushReplacement('/login'),
                            child: Icon(
                              Icons.arrow_back,
                              color: appColors['primary'],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Center(
                          child: Text(
                            "Sign Up",
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
                          top: 54,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // First Name Input
                              Text(
                                "First Name",
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
                                  controller: firstNameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
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
                              // Last Name Input
                              Padding(
                                padding: const EdgeInsets.only(top: 18),
                                child: Text(
                                  "Last Name",
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
                                  controller: lastNameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
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
                              // Email Input
                              Padding(
                                padding: const EdgeInsets.only(top: 18),
                                child: Text(
                                  "Email",
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
                                      : passwordController.text.length < 6
                                          ? "Password length should be at least 6."
                                          : null,
                                ),
                              ),
                              // Confirm Password Input
                              Padding(
                                padding: const EdgeInsets.only(top: 18),
                                child: Text(
                                  "Confirm Password",
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
                                  controller: confirmPasswordController,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
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
                                      : confirmPasswordController.text.length <
                                              6
                                          ? "Password length should be at least 6."
                                          : confirmPasswordController.text !=
                                                  passwordController.text
                                              ? "Password do not match."
                                              : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 46,
                          right: 46,
                          top: 45,
                          bottom: 80,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              Map<String, dynamic> accountDetails = {
                                "fname": capitalizeFirstLetter(
                                    firstNameController.text),
                                "lname": capitalizeFirstLetter(
                                    lastNameController.text),
                                "email": emailController.text,
                                "password": passwordController.text,
                              };

                              bool successfulSignUp = await createAccount(accountDetails, context);

                              if(successfulSignUp)
                                {
                                  if(!mounted) return;
                                  context.go('/');
                                }
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
                                "Submit",
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
