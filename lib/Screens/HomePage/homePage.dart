import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p2p/Screens/Account/account.dart';
import 'package:p2p/Screens/Approval/approval.dart';
import 'package:p2p/Screens/CashFlow/cashFlow.dart';
import 'package:p2p/Screens/Dashboard/dashboard-page.dart';
import 'package:p2p/Screens/Login/component/loginResponse.dart';
import 'package:p2p/classes/MyConnectivity.dart';
import 'package:p2p/constants.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:p2p/constants/AppConstant.dart';
import 'package:p2p/constants/Network.dart';
import 'package:p2p/constants/Services.dart';
import 'package:p2p/localization/localization_constants.dart';
import 'package:p2p/main.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Map _source = {ConnectivityResult.none: false};
  // MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    // _connectivity.initialise();
    // _connectivity.myStream.listen((source) {
    //   setState(() => _source = source);
    // });
  }

  @override
  Widget build(BuildContext context) {
    String string;
    // switch (_source.keys.toList()[0]) {
    //   case ConnectivityResult.none:
    //     string = "Offline";
    //     break;
    //   case ConnectivityResult.mobile:
    //     string = "Mobile: Online";
    //     break;
    //   case ConnectivityResult.wifi:
    //     string = "WiFi: Online";
    // }

    return Align(
        alignment: Alignment.bottomLeft, // and bottomLeft
        child: SafeArea(
            bottom: true,
            top: false,
            child: DefaultTabController(
              length: 4,
              child: Scaffold(
                bottomNavigationBar: TabBar(
                  tabs: [
                    Tab(
                      icon: new Icon(Icons.home),
                      text: getTranslated(context, 'Home'),
                    ),
                    Tab(
                      icon: new Icon(Icons.check_circle),
                      text: getTranslated(context, 'Approval'),
                    ),
                    Tab(
                      icon: new Icon(FontAwesomeIcons.chartLine),
                      text: getTranslated(context, 'CashFlow'),
                    ),
                    Tab(
                      icon: new Icon(Icons.person),
                      text: getTranslated(context, 'Account'),
                    )
                  ],
                  labelColor: kPrimaryColor,
                  labelPadding: EdgeInsets.only(left: 3, right: 3),
                  unselectedLabelColor: kGreyLightColor,
                ),
                body: DoubleBackToCloseApp(
                  snackBar: SnackBar(
                    content:
                        Text(getTranslated(context, 'Tapbackagaintoleave')),
                  ),
                  child: TabBarView(
                    children: [Dashboard(), Approval(), CashFlow(), Account()],
                  ),
                ),
              ),
            )));
  }

  @override
  void dispose() {
    // _connectivity.disposeStream();
    super.dispose();
  }
}

class GetToken {
  // SharedPreferences sharedPreferences;
  Future<void> getToken() async {
    Network().check().then((intenet) async {
      if (intenet != null && intenet) {
        String username =
            globalMyLocalPrefes.getString(AppConstant.LoginGmailID);
        String password = globalMyLocalPrefes.getString(AppConstant.PASSWORD);

        try {
          final uri = Services.LOGIN;
          Map body = {
            "PassKey": "a486f489-76c0-4c49-8ff0-d0fdec0a162b",
            "UserName": username,
            "UserPassword": password
          };

          http.post(Uri.parse(uri), body: body).then((response) async {
            if (response.statusCode == 200) {
              var jsonResponse = jsonDecode(response.body);
              if (jsonResponse["StatusCode"] == 200) {
                ResultObject login =
                    new ResultObject.fromJson(jsonResponse["ResultObject"][0]);

                print("login.tokenKey: ${login.tokenKey}");
                print("userId---3 : ${login.userId}");

                await globalMyLocalPrefes.setInt(
                    AppConstant.USER_ID.toString(), login.userId);

                await globalMyLocalPrefes.setString(
                    AppConstant.ACCESS_TOKEN, login.tokenKey);
                await globalMyLocalPrefes.setString(
                    AppConstant.USERNAME, login.firstName);
                await globalMyLocalPrefes.setString(AppConstant.IMAGE,
                    login.photoPath == null ? "null" : login.photoPath);
                await globalMyLocalPrefes.setString(AppConstant.PHONENO,
                    login.mobile == null ? "null" : login.mobile);
                await globalMyLocalPrefes.setString(
                    AppConstant.EMAIL, login.email);
                return login.tokenKey;
              } else {
                return "Something wnet wrong.. Please try again later.";
              }
            } else {
              print("response.statusCode.." + response.statusCode.toString());

              return "Something wnet wrong.. Please try again later.";
            }
          });
        } catch (e) {
          print("Error: $e");
          return (e);
        }
      } else {
        return "Please check internet connection";
      }
    });
  }
}
