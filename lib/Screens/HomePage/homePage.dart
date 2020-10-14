import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p2p/Screens/Account/account.dart';
import 'package:p2p/Screens/Approval/approval.dart';
import 'package:p2p/Screens/CashFlow/cashFlow.dart';
import 'package:p2p/Screens/Dashboard/dashboard-page.dart';
import 'package:p2p/classes/MyConnectivity.dart';
import 'package:p2p/constants.dart';

import 'package:connectivity/connectivity.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:p2p/localization/localization_constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
  Widget build(BuildContext context) {
    String string;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        string = "Offline";
        break;
      case ConnectivityResult.mobile:
        string = "Mobile: Online";
        break;
      case ConnectivityResult.wifi:
        string = "WiFi: Online";
    }

    return new DefaultTabController(
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
            content: Text(getTranslated(context, 'Tapbackagaintoleave')),
          ),
          child: TabBarView(
            children: [Dashboard(), Approval(), CashFlow(), Account()],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }
}
