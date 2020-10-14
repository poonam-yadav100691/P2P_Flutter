import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:p2p/Screens/Approval/ApprovalDetails/approval-details.dart';
import 'package:p2p/models/notiList.dart';
import '../../../constants.dart';

import './background.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<NotiList> notiLists1 = [
    NotiList(
        title: 'PROOHQS10167',
        profileImg: 'img/pic-1.png',
        desc: "Software Developer dummy text here ",
        date: '20/02/20'),
    NotiList(
        title: 'PROOHQS10160',
        profileImg: 'img/pic-2.png',
        desc: "UI Designer",
        date: '20/02/20'),
    NotiList(
        title: 'PROO',
        profileImg: 'img/pic-3.png',
        desc: "Software Tester dummy textdummy",
        date: '20/02/20'),
    NotiList(
        title: 'PROOHQS10160',
        profileImg: 'img/pic-2.png',
        desc: "UI Designer",
        date: '20/02/20'),
    NotiList(
        title: 'PROOHQS10167',
        profileImg: 'img/pic-2.png',
        desc: "UI Designer dummy text heredummy",
        date: '20/02/20'),
    NotiList(
        title: 'PROOHQS10167',
        profileImg: 'img/pic-2.png',
        desc: "UI Designer dummy text heredummy",
        date: '20/02/20'),
    NotiList(
        title: 'PROOHQS10160',
        profileImg: 'img/pic-2.png',
        desc: "UI Designer dummy text heredummy",
        date: '20/02/20'),
  ];

  void _goToDetails(BuildContext context1, approveData) {
    // final body = json.decode(approveData);

    // List results;
    // setState(() {
    //   var resBody = json.decode(approveData);
    //   print('Response body: $resBody');
    //   results = resBody;
    // });

    String jsonUser = jsonEncode(approveData);
    print(jsonUser);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ApprovalDetails(
            appData: jsonUser,
          ),
        ));
    // context,
    // MaterialPageRoute(
    //   builder: (context) {
    //     var approvalDetails =
    //         ApprovalDetails(notiLists1: NotiList);
    //     return approvalDetails;
    //   },
    // ),
  }

  Widget notiDetailCard(NotiList) {
    return Container(
      padding: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
      child: new Card(
        child: new InkWell(
          onTap: () {
            _goToDetails(context, NotiList);
          },
          child: Row(
            children: <Widget>[
              Container(
                height: 100,
                width: 10,
                decoration: new BoxDecoration(
                  color: NotiList.title == "PROOHQS10167"
                      ? Colors.grey
                      : Colors.orange,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      bottomLeft: Radius.circular(5.0)),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        NotiList.title,
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        NotiList.desc,
                        style: new TextStyle(),
                      ),
                      Text(
                        'BU: Headquarter',
                        style: new TextStyle(),
                      ),
                      Text(
                        'Total: 100223 Kip',
                        style: new TextStyle(),
                      ),
                    ],
                  ),
                  // color: Colors.amber,
                  width: 100,
                  height: 100,
                ),
              ),
              Container(
                height: 100,
                // width: 100,
                // color: Colors.blue,
                child: Container(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 8),
                        child: Text(
                          NotiList.date,
                          style: new TextStyle(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 8),
                        child: NotiList.title == "PROOHQS10167"
                            ? Text(
                                'Pending',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kGreyLightColor),
                              )
                            : Text(
                                'On Hold',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kOrangeColor),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: SizedBox(
                          width: 90,
                          height: 30.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: BorderSide(color: Colors.green)),
                            onPressed: () {
                              _goToDetails(context, NotiList);
                            },
                            padding: const EdgeInsets.all(0),
                            color: Colors.green,
                            textColor: Colors.white,
                            child: Text("Action".toUpperCase(),
                                style: TextStyle(fontSize: 14)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: notiLists1.map((p) {
                return notiDetailCard(p);
              }).toList()
              // SizedBox(height: size.height * 0.03),

              ),
        ],
      ),
    );
  }
}
