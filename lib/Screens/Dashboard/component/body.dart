import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:p2p/classes/language.dart';
import 'package:p2p/localization/localization_constants.dart';
import 'package:p2p/main.dart';
import 'package:p2p/routes/route_names.dart';
import '../../../constants.dart';
import './background.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  var data1 = [0.0, -2.0, 3.5, -2.0, 0.5, 0.7, 0.8, 1.0, 2.0, 3.0, 3.2];

  Material myTextItems(String title, String usaPrice, String thaiPrice) {
    Size size = MediaQuery.of(context).size;
    return Material(
      // color: Color(0xffE5E5E5),
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),

      shadowColor: Color(0x802196F3),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // verticalDirection: VerticalDirection.down,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Center(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 2, bottom: 4, left: 20, right: 20),
                          child: Text(
                            title,
                            style: TextStyle(
                                fontSize: 18.0,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
                          ))),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // // verticalDirection: VerticalDirection.up,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            margin: const EdgeInsets.only(left: 0.0),
                            child: Image.asset(
                              "assets/images/usa2.png",
                              width: size.width * 0.06,
                            )),
                        Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              usaPrice,
                              style: TextStyle(
                                  color: kOrangeColor, fontSize: 20.0),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // verticalDirection: VerticalDirection.up,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(left: 0.0),
                          child: Image.asset(
                            "assets/images/thai2.png",
                            width: size.width * 0.06,
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text(
                              thaiPrice,
                              style: TextStyle(
                                  color: kPrimaryColor, fontSize: 20.0),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Material myCircularItems(String title, String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: EdgeInsets.all(0.0),
                  //   child: AnimatedCircularChart(
                  //     size: const Size(170.0, 170.0),
                  //     initialChartData: circularData,
                  //     chartType: CircularChartType.Pie,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Material mychart1Items(String title, String priceVal, String subtitle) {
  //   return Material(
  //     color: Colors.white,
  //     elevation: 14.0,
  //     borderRadius: BorderRadius.circular(24.0),
  //     shadowColor: Color(0x802196F3),
  //     child: Center(
  //       child: Padding(
  //         padding: EdgeInsets.all(8.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: <Widget>[
  //                 Padding(
  //                   padding: EdgeInsets.all(1.0),
  //                   child: Text(
  //                     title,
  //                     style: TextStyle(
  //                       fontSize: 20.0,
  //                       color: Colors.blueAccent,
  //                     ),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.all(1.0),
  //                   child: Text(
  //                     priceVal,
  //                     style: TextStyle(
  //                       fontSize: 30.0,
  //                     ),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.all(1.0),
  //                   child: Text(
  //                     subtitle,
  //                     style: TextStyle(
  //                       fontSize: 20.0,
  //                       color: Colors.blueGrey,
  //                     ),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.all(1.0),
  //                   child: new Sparkline(
  //                     data: data,
  //                     lineColor: Color(0xffff6101),
  //                     pointsMode: PointsMode.all,
  //                     pointSize: 8.0,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Material mychart2Items(String title, String priceVal, String subtitle) {
  //   return Material(
  //     color: Colors.white,
  //     elevation: 14.0,
  //     borderRadius: BorderRadius.circular(24.0),
  //     shadowColor: Color(0x802196F3),
  //     child: Center(
  //       child: Padding(
  //         padding: EdgeInsets.all(8.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: <Widget>[
  //                 Padding(
  //                   padding: EdgeInsets.all(1.0),
  //                   child: Text(
  //                     title,
  //                     style: TextStyle(
  //                       fontSize: 20.0,
  //                       color: Colors.blueAccent,
  //                     ),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.all(1.0),
  //                   child: Text(
  //                     priceVal,
  //                     style: TextStyle(
  //                       fontSize: 30.0,
  //                     ),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.all(1.0),
  //                   child: Text(
  //                     subtitle,
  //                     style: TextStyle(
  //                       fontSize: 20.0,
  //                       color: Colors.blueGrey,
  //                     ),
  //                   ),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.all(1.0),
  //                   child: new Sparkline(
  //                     data: data1,
  //                     fillMode: FillMode.below,
  //                     fillGradient: new LinearGradient(
  //                       begin: Alignment.topCenter,
  //                       end: Alignment.bottomCenter,
  //                       colors: [Colors.amber[800], Colors.amber[200]],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.05),
        child: Column(
          children: [
            Container(
              // margin: EdgeInsets.only(top: size.height * 0.05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 30,
                    child: IconButton(
                        icon: Icon(FontAwesomeIcons.bell),
                        color: kPrimaryColor,
                        onPressed: () {
                          Navigator.pushNamed(context, notificationRoute);
                        }),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 70),
                      // color: Colors.yellow,
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/TKS_ERP.png",
                          // width: size.width * 0.9,
                          height: 70,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: DropdownButton<Language>(
                      underline: SizedBox(),
                      icon: Icon(
                        Icons.language,
                        color: Colors.pink,
                      ),
                      onChanged: (Language language) {
                        _changeLanguage(language);
                      },
                      items: Language.languageList()
                          .map<DropdownMenuItem<Language>>(
                            (e) => DropdownMenuItem<Language>(
                              value: e,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Image.asset(
                                    e.flag,
                                    height: 25,
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(e.name)),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              // margin: EdgeInsets.only(top: size.height * 0.1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: myTextItems(getTranslated(context, "BuyingRate"),
                        "9,090.00", "315.96"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: myTextItems(getTranslated(context, "SellingRate"),
                        "9,110.00", "318.34"),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 20, right: 20),
              // margin: EdgeInsets.only(top: size.height * 0.2),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _buildStatCard(
                          'PO Transactions',
                          getTranslated(context, 'TotalBudget'),
                          '1.81 M',
                          Colors.orange),
                      _buildStatCard(
                          'PO Transactions',
                          getTranslated(context, 'Outstanding'),
                          '1.81 M',
                          Colors.deepPurple),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      _buildStatCard(
                          'Non-PO Transactions',
                          getTranslated(context, 'TotalBudget'),
                          '1.81 M',
                          Colors.green),
                      _buildStatCard(
                          'Non-PO Transactions',
                          getTranslated(context, 'Expenses'),
                          '1.81 M',
                          Colors.blue),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }

  Expanded _buildStatCard(
      String title, String subtitle, String count, MaterialColor color) {
    return Expanded(
        child: Container(
            margin: const EdgeInsets.all(7.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600),
                ),
                Text(count,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold)),
              ],
            )));
  }
}
