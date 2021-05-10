import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:p2p/Screens/Approval/ApprovalDetails/approval-details.dart';
import 'package:p2p/Screens/Approval/component/approvalPODO.dart';
import 'package:p2p/Screens/HomePage/homePage.dart';
import 'package:p2p/constants/AppConstant.dart';
import 'package:p2p/constants/Network.dart';
import 'package:p2p/constants/Services.dart';
import 'package:p2p/main.dart';
import 'package:toast/toast.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import './background.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<ResultObject> approvalList = new List();
  List p2PTypeId = List();
  List businessUnitIds = List();
  // int userID;

  @override
  void initState() {
    _getApproveList();
    super.initState();
  }

  Future<void> _getApproveList() async {
    Network().check().then((intenet) async {
      if (intenet != null && intenet) {
        try {
          final uri = Services.ApprovalList;
          approvalList.clear();
          var token = await globalMyLocalPrefes
              .get(AppConstant.ACCESS_TOKEN.toString());

          var busiId =
              await globalMyLocalPrefes.get(AppConstant.BUSINESSID.toString());
          var deptId =
              await globalMyLocalPrefes.get(AppConstant.DEPARTMENT.toString());
          var userTd =
              await globalMyLocalPrefes.get(AppConstant.USER_ID.toString());

          Map body = {
            "UserId": userTd.toString(),
            "BusinessUnitId": busiId.toString(),
            "DepartmentId": deptId.toString(),
            "TokenKey": token,
            "P2PTypeId": p2PTypeId.toList(),
            "BusinessUnitIds": businessUnitIds.toList(),
          };
          print("BODY: $body");

          http.post(uri, body: body).then((response) async {
            if (response.statusCode == 200) {
              var jsonResponse = jsonDecode(response.body);
              print("Reponse---2 : $jsonResponse");
              if (jsonResponse["StatusCode"] == 200) {
                ApprovalList approveList =
                    new ApprovalList.fromJson(jsonResponse);
                setState(() {
                  approvalList = approveList.resultObject;
                  isLoading = false;
                });
              } else {
                if (jsonResponse["ModelErrors"] == 'Unauthorized') {
                  GetToken().getToken().then((value) {
                    _getApproveList();
                  });
                  // _getNewsList();
                  // Future<String> token = getToken();
                } else {
                  setState(() {
                    isLoading = false;
                  });
                  Toast.show(
                      "Something went wrong.. Please try again later.", context,
                      duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                }
              }
            } else {
              print("response.statusCode.." + response.statusCode.toString());
              Toast.show(
                  "Something wnet wrong.. Please try again later.", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            }
          });
        } catch (e) {
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

  void _goToDetails(BuildContext context1, approveData) {
    String jsonUser = jsonEncode(approveData);
    print(jsonUser);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ApprovalDetails(
            appData: jsonUser,
          ),
        ));
  }

  Widget notiDetailCard(approvalList) {
    return Container(
      padding: new EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
      child: new Card(
        child: new InkWell(
          onTap: () {
            _goToDetails(context, approvalList);
          },
          child: Row(
            children: <Widget>[
              Container(
                height: 100,
                width: 10,
                decoration: new BoxDecoration(
                  color: approvalList.appStatus != "Pending"
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
                        approvalList.appNo,
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Flexible(
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          strutStyle: StrutStyle(fontSize: 12.0),
                          text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              text: approvalList.title),
                        ),
                      ),
                      Text(
                        'BU: ${approvalList.businessUnitName}',
                        style: new TextStyle(),
                      ),
                      Text(
                        'Total: ${approvalList.totalAmount} ${approvalList.currencyName}',
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
                          approvalList.appDate,
                          style: new TextStyle(),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 8.0, right: 8),
                          child: approvalList.title != null
                              ? Text(
                                  approvalList.appStatus,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kGreyLightColor),
                                )
                              : Container()),
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
                              _goToDetails(context, approvalList);
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
    if (!isLoading) {
      return Background(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: approvalList.map((p) {
                  return notiDetailCard(p);
                }).toList()
                // SizedBox(height: size.height * 0.03),

                ),
          ],
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
