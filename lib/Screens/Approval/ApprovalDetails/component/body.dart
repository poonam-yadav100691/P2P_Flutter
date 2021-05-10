import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:p2p/Screens/Approval/ApprovalDetails/component/approveDetailsPODO.dart';
import 'package:p2p/Screens/Approval/ApprovalDetails/component/aprovHistoryPODO.dart';
import 'package:p2p/Screens/Approval/component/approvalPODO.dart';
import 'package:p2p/Screens/HomePage/homePage.dart';
import 'package:p2p/constants/AppConstant.dart';
import 'package:p2p/constants/Network.dart';
import 'package:p2p/constants/Services.dart';
import 'package:p2p/localization/localization_constants.dart';
import 'package:p2p/main.dart';
import 'package:p2p/utils/UIhelper.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:p2p/components/approvalAction.dart';
import 'package:p2p/constants.dart';
import './background.dart';
import 'package:p2p/Screens/Approval/HistoryPopup/history-popup.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  String jsonUser;
  Body({Key key, this.jsonUser}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(jsonUser);
}

class _BodyState extends State<Body> {
  String jsonUser;
  TextEditingController resoneController = TextEditingController();
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<HistResultObject> approvalHistList = new List();
  List<ResultObjectAprvDetls> approvalDetailsRst = new List();

  // int userID;

  @override
  void initState() {
    String parsedJson = json.decode(jsonUser);
    Map<String, dynamic> map = jsonDecode(parsedJson);
    ResultObject appData = ResultObject.fromJson(map);

    _getApproveDetails(appData);
    super.initState();
  }

  void takeAction(actionText, data) {
    Map actionData = {
      "AppType": data.appType.toString(),
      "AppId": data.appID.toString(),
      "UserId": globalMyLocalPrefes.get(AppConstant.USER_ID).toString(),
      "ApproveType": actionText,
      "Remarks": resoneController.text ?? " ",
      "TokenKey": globalMyLocalPrefes.get(AppConstant.ACCESS_TOKEN)
    };
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ApprovalAction(
                actionData: actionData,
                actionText: actionText)));
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
    ResultObject appData = ResultObject.fromJson(map);

    Size size = MediaQuery.of(context).size;

    const String toLaunch = 'http://www.africau.edu/images/default/sample.pdf';
    print("approvalDetailsRst.length");

    print(approvalDetailsRst.length);
    return (!isLoading)
        ? Background(
            child: (approvalDetailsRst != null && approvalDetailsRst.length > 0)
                ? ListView(
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              appData.appNo,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              appData.appDate,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Budget Type : ' +
                                                  approvalDetailsRst[0]
                                                      .budgetType,
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              'Total : ${appData.totalAmount}',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'BU : ${appData.businessUnitName}',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            Text(
                                              'Currency : ${appData.currencyName}',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.normal),
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
                              padding:
                                  const EdgeInsets.only(top: 10.0, bottom: 10),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 8.0,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Description : '),
                                            Flexible(
                                              child: Text(
                                                '${approvalDetailsRst[0].description}',
                                                overflow: TextOverflow.visible,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Text(
                                            'Pay to : ${approvalDetailsRst[0].payTo}'),
                                      ),
                                      Container(
                                        width: size.width,
                                        padding:
                                            EdgeInsets.only(top: 6, bottom: 2),
                                        child: InkWell(
                                          onTap: () {
                                            // openHistory(context, appData);
                                            _getApproveHistList(appData);
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                getTranslated(context,
                                                    'ApprovingHistory'),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: kPrimaryColor,
                                                    decoration: TextDecoration
                                                        .underline),
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            approvalDetailsRst[0].orderItems.length > 0
                                ? Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 130,
                                          child: ListView.builder(
                                            itemCount: approvalDetailsRst[0]
                                                .orderItems
                                                .length,
                                            itemBuilder: (context, position) {
                                              return Card(
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      height: 100,
                                                      width: 6,
                                                      decoration:
                                                          new BoxDecoration(
                                                        color: Colors.grey[700],
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        4.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        4.0)),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Title: ${approvalDetailsRst[0].orderItems[position].title}',
                                                            ),
                                                            Text(
                                                              "Price : ${approvalDetailsRst[0].orderItems[position].price} ${approvalDetailsRst[0].currencyName}",
                                                              style:
                                                                  new TextStyle(),
                                                            ),
                                                            Text(
                                                              'Discount : ${approvalDetailsRst[0].orderItems[position].discount} %',
                                                              style:
                                                                  new TextStyle(),
                                                            ),
                                                            Text(
                                                              'Sub Total: ${approvalDetailsRst[0].orderItems[position].subTotal} ${approvalDetailsRst[0].currencyName}',
                                                              style:
                                                                  new TextStyle(),
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
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    width: size.width,
                                    margin: const EdgeInsets.only(bottom: 11.0),
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.grey[350],
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("No Order Items To Show!!"),
                                    )),

                            //supporting doc text
                            Container(
                              width: size.width,
                              padding: EdgeInsets.all(5),
                              child: Text(
                                getTranslated(context, 'SupportingDocuments'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            approvalDetailsRst[0].attacheFile.length > 0
                                ? Container(
                                    height: MediaQuery.of(context).size.width *
                                        0.15,
                                    // color: Colors.pink,
                                    child: Column(children: <Widget>[
                                      new Expanded(
                                        child: ListView.builder(
                                            itemCount: approvalDetailsRst[0]
                                                .attacheFile
                                                .length,
                                            itemBuilder: (context, position) {
                                              return Card(
                                                child: Row(children: <Widget>[
                                                  Container(
                                                    width: size.width * 0.7,
                                                    padding: EdgeInsets.all(5),
                                                    decoration:
                                                        new BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () => setState(() {
                                                        _launched =
                                                            _launchInBrowser(
                                                                toLaunch);
                                                      }),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                                Icons
                                                                    .description,
                                                                color: Colors
                                                                    .red[400]),
                                                            Text(
                                                                'Supporting Document.PNG')
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ]),
                                              );
                                            }),
                                      ),
                                    ]),
                                  )
                                : Container(
                                    width: size.width,
                                    margin: const EdgeInsets.only(bottom: 11.0),
                                    decoration: new BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.grey[350],
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("No Documents To Show."),
                                    )),

                            //Remark text
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              // color: Colors.pink,
                              width: size.width,
                              padding: EdgeInsets.all(5),
                              child: Text(
                                getTranslated(context, 'Remark'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
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
                                controller: resoneController,
                                decoration: InputDecoration.collapsed(
                                    hintText: getTranslated(
                                        context, "EnterYouRemark")),
                              ),
                            ),

                            //buttons
                            Container(
                              width: size.width * 0.8,
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new RaisedButton(
                                    onPressed: () {
                                      if (resoneController.text != "") {
                                        takeAction("Approve", appData);
                                      } else {
                                        Toast.show(
                                            "Please enter remark..", context,
                                            duration: Toast.LENGTH_LONG,
                                            gravity: Toast.BOTTOM);
                                      }
                                    },
                                    textColor: Colors.white,
                                    padding: const EdgeInsets.fromLTRB(
                                        12, 10, 12, 10.0),
                                    color: Colors.green,
                                    child: Text(
                                        getTranslated(context, 'Approve'),
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                  new RaisedButton(
                                    child: new Text(
                                        getTranslated(context, 'Reject'),
                                        style: TextStyle(fontSize: 18)),
                                    onPressed: () {
                                      if (resoneController.text != "") {
                                        takeAction("Reject", appData);
                                      } else {
                                        Toast.show(
                                            "Please enter remark..", context,
                                            duration: Toast.LENGTH_LONG,
                                            gravity: Toast.BOTTOM);
                                      }
                                    },
                                    textColor: Colors.white,
                                    padding: const EdgeInsets.fromLTRB(
                                        18, 10, 18, 10.0),
                                    color: Colors.red,
                                  ),
                                  new RaisedButton(
                                    child: new Text(
                                        getTranslated(context, 'Hold'),
                                        style: TextStyle(fontSize: 18)),
                                    onPressed: () {
                                      if (resoneController.text != "") {
                                        takeAction("Hold", appData);
                                      } else {
                                        Toast.show(
                                            "Please enter remark..", context,
                                            duration: Toast.LENGTH_LONG,
                                            gravity: Toast.BOTTOM);
                                      }
                                    },
                                    textColor: Colors.white,
                                    padding: const EdgeInsets.fromLTRB(
                                        18, 10, 18, 10.0),
                                    color: Colors.orange,
                                  ),
                                ],
                              ),
                            ),

                            FutureBuilder<void>(
                                future: _launched, builder: _launchStatus),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(child: Text("No Data")),
          )
        : Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(child: CircularProgressIndicator()));
  }

  Future<void> _getApproveDetails(appdata1) async {
    Network().check().then((intenet) async {
      if (intenet != null && intenet) {
        try {
          final uri = Services.ApprovalDetails;
          approvalDetailsRst.clear();
          var token = await globalMyLocalPrefes
              .get(AppConstant.ACCESS_TOKEN.toString());
          print("appdata2: $appdata1");
          Map body = {
            "AppType": appdata1.appType,
            "AppId": appdata1.appID.toString(),
            // "AppType": "grn",
            // "AppId": "640",
            "TokenKey": token
          };
          print("BODY2: $body");

          http.post(uri, body: body).then((response) async {
            if (response.statusCode == 200) {
              var jsonResponse = jsonDecode(response.body);
              print("Re222 : ${jsonResponse["ResultObject"]}");
              if (jsonResponse["StatusCode"] == 200) {
                ApproveDetails approveDetails =
                    new ApproveDetails.fromJson(jsonResponse);
                setState(() {
                  isLoading = false;
                  approvalDetailsRst = approveDetails.resultObject;
                });
                print("Re6666 : ${approvalDetailsRst[0]}");
              } else {
                print("Re6666 : ${jsonResponse["ModelErrors"]}");
                if (jsonResponse["ModelErrors"] == 'Unauthorized') {
                  GetToken().getToken().then((value) {
                    _getApproveDetails(appdata1);
                  });
                  // _getNewsList();
                  // Future<String> token = getToken();
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  _scaffoldKey.currentState.showSnackBar(UIhelper.showSnackbars(
                      "Something wnet wrong.. Please try again later.12"));
                }
              }
            } else {
              isLoading = false;

              print("response.statusCode.." + response.statusCode.toString());
              _scaffoldKey.currentState.showSnackBar(UIhelper.showSnackbars(
                  "Something wnet wrong.. Please try again later.1"));
            }
          });
        } catch (e) {
          isLoading = false;

          print("Error: $e");
          return (e);
        }
      } else {
        isLoading = false;

        Navigator.pop(context);
        Toast.show("Please check internet connection", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    });
  }

  Future<void> _getApproveHistList(appdata1) async {
    Network().check().then((intenet) async {
      if (intenet != null && intenet) {
        try {
          setState(() {
            isLoading = true;
          });
          final uri = Services.ApprovalHistory;
          approvalHistList.clear();
          var token = await globalMyLocalPrefes
              .get(AppConstant.ACCESS_TOKEN.toString());
          print("appdata1: $appdata1");
          Map body = {
            "AppType": appdata1.appType,
            "AppId": appdata1.appID.toString(),
            // "AppType": "pro",
            // "AppId": "757",
            "TokenKey": token
          };
          print("BODY: $body");

          http.post(uri, body: body).then((response) async {
            if (response.statusCode == 200) {
              var jsonResponse = jsonDecode(response.body);
              print("Reponse---2 : $jsonResponse");
              if (jsonResponse["StatusCode"] == 200) {
                setState(() {
                  isLoading = false;
                });
                if (jsonResponse["ResultObject"] != null) {
                  ApproveHistory approveHistList =
                      new ApproveHistory.fromJson(jsonResponse);
                  openHistory(context, approveHistList);
                } else {
                  Toast.show("No Data Found!!", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                }
              } else {
                setState(() {
                  isLoading = false;
                });
                if (jsonResponse["ModelErrors"] == 'Unauthorized') {
                  GetToken().getToken().then((value) {
                    _getApproveHistList(appdata1);
                  });
                  // _getNewsList();
                  // Future<String> token = getToken();
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  _scaffoldKey.currentState.showSnackBar(UIhelper.showSnackbars(
                      "Something wnet wrong.. Please try again later.12"));
                }
              }
            } else {
              print("response.statusCode.." + response.statusCode.toString());
              setState(() {
                isLoading = false;
              });
              _scaffoldKey.currentState.showSnackBar(UIhelper.showSnackbars(
                  "Something wnet wrong.. Please try again later.1"));
            }
          });
        } catch (e) {
          setState(() {
            isLoading = false;
          });
          print("Error: $e");
          return (e);
        }
      } else {
        Navigator.pop(context);
        Toast.show("Please check internet connection", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    });
  }
}
