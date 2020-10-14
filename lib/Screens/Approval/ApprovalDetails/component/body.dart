import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:p2p/localization/localization_constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:p2p/components/approvalAction.dart';
import 'package:p2p/constants.dart';
import 'package:p2p/models/notiList.dart';
import './background.dart';
import 'package:p2p/Screens/Approval/HistoryPopup/history-popup.dart';

class Body extends StatefulWidget {
  String jsonUser;
  Body({Key key, this.jsonUser}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(jsonUser);
}

class _BodyState extends State<Body> {
  String jsonUser;
  void takeAction(text) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ApprovalAction(text)),
    );
  }

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  _BodyState(this.jsonUser);

  @override
  Widget build(BuildContext context) {
    String parsedJson = json.decode(jsonUser);
    Future<void> _launched;
    Map<String, dynamic> map = jsonDecode(parsedJson);
    NotiList appData = NotiList.fromJson(map);

    Size size = MediaQuery.of(context).size;

    const String toLaunch = 'http://www.africau.edu/images/default/sample.pdf';

    return Background(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Container(
            // color: Colors.pink,
            padding: const EdgeInsets.all(0.0),
            margin: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                //1stBox
                Container(
                  // padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey[350],
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  appData.title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  appData.date,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Budget Type : OPEX',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  'Total : 1,465,768',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'BU : Headquarter',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  'Currency : Kip',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //2nd Box
                Container(
                  width: size.width,
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey[350],
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Description : '),
                                Flexible(
                                  child: Text(
                                    'Title text here. Title text here. Title text here. Title text here'
                                    '${appData.desc}',
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text('Pay to : ' '${appData.desc}'),
                          ),
                          Container(
                            width: size.width,
                            padding: EdgeInsets.only(top: 6, bottom: 2),
                            child: InkWell(
                              onTap: () {
                                openHistory(context, NotiList);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    getTranslated(context, 'ApprovingHistory'),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor,
                                        decoration: TextDecoration.underline),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //Order Item text
                Container(
                  // color: Colors.pink,
                  width: size.width,
                  padding: EdgeInsets.all(5),
                  child: Text(
                    getTranslated(context, 'OrderItems'),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                //order item list
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 11.0),
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey[350],
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 100,
                              width: 6,
                              decoration: new BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0)),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Title text here.. Title text here. ',
                                    ),
                                    Text(
                                      "Price : 6000 x 2",
                                      style: new TextStyle(),
                                    ),
                                    Text(
                                      'Discount : 0%',
                                      style: new TextStyle(),
                                    ),
                                    Text(
                                      'Sub Total: 1,00,223 Kip',
                                      style: new TextStyle(),
                                    ),
                                  ],
                                ),
                                // color: Colors.amber,
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///2nd item orders:
                      Container(
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey[350],
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 100,
                              width: 6,
                              decoration: new BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    bottomLeft: Radius.circular(5.0)),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Title text here.. Title text here. Title text here. ',
                                    ),
                                    Text(
                                      "Price : 6000 x 2",
                                      style: new TextStyle(),
                                    ),
                                    Text(
                                      'Discount : 0%',
                                      style: new TextStyle(),
                                    ),
                                    Text(
                                      'Sub Total: 1,00,223 Kip',
                                      style: new TextStyle(),
                                    ),
                                  ],
                                ),
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: size.width,
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(right: 0, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(
                              Icons.credit_card,
                              color: Colors.red[700],
                              size: 19,
                            ),
                            Text(
                              getTranslated(context, 'Total'),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              ': 2,00,000',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //supporting doc text
                Container(
                  // color: Colors.pink,
                  width: size.width,
                  padding: EdgeInsets.all(5),
                  child: Text(
                    getTranslated(context, 'SupportingDocuments'),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                //Supporting docs list
                Container(
                  width: size.width,
                  padding: EdgeInsets.all(5),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey[350],
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () => setState(() {
                        _launched = _launchInBrowser(toLaunch);
                      }),
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => FileOpener()),
                      // );

                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.description, color: Colors.red[400]),
                            Text('Supporting Document.PNG')
                          ],
                        ),
                      ),
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),

                //Remark text
                Container(
                  margin: EdgeInsets.only(top: 10),
                  // color: Colors.pink,
                  width: size.width,
                  padding: EdgeInsets.all(5),
                  child: Text(
                    getTranslated(context, 'Remark'),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),

                //remark text area
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(bottom: 20),
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey[350],
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextField(
                    maxLines: 3,
                    decoration: InputDecoration.collapsed(
                        hintText: getTranslated(context, "EnterYouRemark")),
                  ),
                ),

                //buttons
                Container(
                  width: size.width * 0.8,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new RaisedButton(
                        onPressed: () {
                          takeAction("Approve");
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10.0),
                        color: Colors.green,
                        child: Text(getTranslated(context, 'Approve'),
                            style: TextStyle(fontSize: 18)),
                      ),
                      new RaisedButton(
                        child: new Text(getTranslated(context, 'Reject'),
                            style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          takeAction("Reject");
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.fromLTRB(18, 10, 18, 10.0),
                        color: Colors.red,
                      ),
                      new RaisedButton(
                        child: new Text(getTranslated(context, 'Hold'),
                            style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          takeAction("Hold");
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.fromLTRB(18, 10, 18, 10.0),
                        color: Colors.orange,
                      ),
                    ],
                  ),
                ),

                FutureBuilder<void>(future: _launched, builder: _launchStatus),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
