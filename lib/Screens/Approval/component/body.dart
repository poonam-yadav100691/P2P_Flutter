import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:p2p/Screens/Approval/ApprovalDetails/approval-details.dart';
import 'package:p2p/Screens/Approval/component/approvalPODO.dart';
import 'package:p2p/Screens/HomePage/homePage.dart';
import 'package:p2p/constants/AppConstant.dart';
import 'package:p2p/constants/Services.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  SharedPreferences sharedPreferences;

  List<ResultObject> approvalList = new List();
  int userID;

  @override
  void initState() {
    _getApproveList();
    super.initState();
  }

  Future<void> _getApproveList() async {
    try {
      final uri = Services.ApprovalList;
      approvalList.clear();
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String token = sharedPreferences.getString(AppConstant.ACCESS_TOKEN);
      int buID = sharedPreferences.getInt(AppConstant.BUSINESSID.toString());
      int deprtID = sharedPreferences.getInt(AppConstant.DEPARTMENT.toString());
      int userID = sharedPreferences.getInt(AppConstant.USER_ID.toString());

      Map body = {
        "UserId": 33,
        "BusinessUnitId": 4,
        "DepartmentId": 8,
        "TokenKey": "f62e03da-0576-4da4-9d17-8460df471401"
      };

      print("Body::: $body");
      print("uri: $uri");
      http.post(uri, body: body).then((response) {
        print("jsonResponse");
        var jsonResponse = jsonDecode(response.body);
        print("jsonResponse: $jsonResponse");

        ApprovalList approveList = new ApprovalList.fromJson(jsonResponse);
        if (jsonResponse["StatusCode"] == 200) {
          setState(() {
            approvalList = approveList.resultObject;

            userID = sharedPreferences.getInt(AppConstant.USER_ID.toString());
            isLoading = false;
          });
        } else {
          print("ModelError: ${jsonResponse["ModelErrors"]}");
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
            // currentState.showSnackBar(
            //     UIhelper.showSnackbars(jsonResponse["ModelErrors"]));
          }
        }
      }).then((value) => print("werror"));
    } catch (e) {
      print("Err: $e");
      return (e);
    }
  }

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
                  color: approvalList.title == "PROOHQS10167"
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
                        approvalList.title,
                        style: new TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        approvalList.desc,
                        style: new TextStyle(),
                      ),
                      Text(
                        'BU: ${approvalList.businessUnitName}',
                        style: new TextStyle(),
                      ),
                      Text(
                        'Total: ${approvalList.totalAmount}',
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
