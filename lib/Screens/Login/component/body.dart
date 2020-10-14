import 'package:flutter/material.dart';
import 'package:p2p/components/forgetPassword.dart';
import 'package:p2p/localization/localization_constants.dart';
import 'package:p2p/routes/route_names.dart';
import './background.dart';
import 'package:p2p/components/rounded_button.dart';
import 'package:p2p/components/rounded_input_field.dart';
import 'package:p2p/components/rounded_password_field.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/logo-pa.png",
              height: size.height * 0.25,
              width: 250,
            ),
            // SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: getTranslated(context, "YourEmail"),
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            RoundedButton(
              text: getTranslated(context, "Login"),
              press: () {
                Navigator.pushReplacementNamed(context, homeRoute);
              },
            ),
            SizedBox(height: size.height * 0.02),
            ForgetPassword(
              press: () {
                Navigator.pushReplacementNamed(context, homeRoute);
              },
            ),
            // SizedBox(height: size.height * 0.01),
            Image.asset(
              "assets/images/login-bg.png",
              height: size.height * 0.40,
            ),
          ],
        ),
      ),
    );
  }
}
