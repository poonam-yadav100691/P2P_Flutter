import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:p2p/Screens/Approval/FilterDataPODO.dart';
import 'package:p2p/Screens/HomePage/homePage.dart';
import 'package:p2p/constants/AppConstant.dart';
import 'package:p2p/constants/Network.dart';
import 'package:p2p/constants/Services.dart';
import 'package:http/http.dart' as http;
import 'package:p2p/main.dart';

class SideMenuCat extends StatefulWidget {
  SideMenuCat();

  @override
  _SideMenuCatState createState() => _SideMenuCatState();
}

class _SideMenuCatState extends State<SideMenuCat> {
  List selecteCategorys = [];
  List selecteP2PType = [];

  List<ResultObject> filterDataList = [];
  List<P2PType> P2pType = [];
  List<BusinessUnit> _buCategories = [];
  bool isLoading = true;

  void _onCategorySelected(bool selected, categoryId, type) {
    if (selected == true) {
      if (type == 'P2pType') {
        setState(() {
          selecteP2PType.add(categoryId);
        });
      } else {
        setState(() {
          selecteCategorys.add(categoryId);
        });
      }
    } else {
      if (type == 'P2pType') {
        setState(() {
          selecteP2PType.remove(categoryId);
        });
      } else {
        setState(() {
          selecteCategorys.remove(categoryId);
        });
      }
    }
    print("selecteCategorys: $selecteCategorys");
    print("selecteP2PType: $selecteP2PType");
  }

  Future<void> _getFilterList() async {
    Network().check().then((intenet) async {
      if (intenet != null && intenet) {
        try {
          final uri = Services.FilterData;
          filterDataList.clear();
          var token = await globalMyLocalPrefes
              .get(AppConstant.ACCESS_TOKEN.toString());
          Map<String, dynamic> body = {"TokenKey": token};
          Map<String, String> headers = {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          };
          http
              .post(Uri.parse(uri), body: json.encode(body), headers: headers)
              .then((response) async {
            var jsonResponse = jsonDecode(response.body);
            // print("Reponse---2 : $jsonResponse");
            if (jsonResponse["StatusCode"] == 200) {
              FilterData filterList = new FilterData.fromJson(jsonResponse);
              print("filterList---2 : $filterList");
              setState(() {
                filterDataList = filterList.resultObject;
                P2pType = filterDataList[0].p2PType;
                _buCategories = filterDataList[0].businessUnit;
                isLoading = false;
              });
              print("_buCategories: $_buCategories");
            } else {
              if (jsonResponse["ModelErrors"] == 'Unauthorized') {
                GetToken().getToken().then((value) {
                  _getFilterList();
                });
                // _getNewsList();
                // Future<String> token = getToken();
              } else {
                setState(() {
                  isLoading = false;
                });
                Fluttertoast.showToast(
                    msg: "Something went wrong.. Please try again later.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            }
          });
        } catch (e) {
          print("Error: $e");
          return (e);
        }
      } else {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Something went wrong.. Please try again later.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getFilterList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 8.0),
        padding: EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300],
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: 18,
              margin: EdgeInsets.fromLTRB(0, 8, 0, 8.0),
              padding: EdgeInsets.all(0.0),
              child: Text(
                "Type",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: P2pType.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    // margin: EdgeInsets.fromLTRB(0, 8, 0, 8.0),

                    height: 40,
                    child: CheckboxListTile(
                      value: selecteP2PType.contains(P2pType[index].typeId),
                      onChanged: (bool selected) {
                        _onCategorySelected(
                            selected, P2pType[index].typeId, "P2pType");
                      },
                      title: Text(P2pType[index].typeName,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400)),
                      secondary: const Icon(
                        Icons.label_important,
                        color: Colors.black,
                        size: 20,
                      ),
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 16,
              margin: EdgeInsets.only(top: 8.0),
              padding: EdgeInsets.all(0.0),
              child: Text(
                "Business Unit",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: _buCategories.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 40,
                    child: CheckboxListTile(
                      value: selecteCategorys
                          .contains(_buCategories[index].businessUnitId),
                      onChanged: (bool selected) {
                        _onCategorySelected(
                            selected,
                            _buCategories[index].businessUnitId,
                            "_buCategories");
                      },
                      title: Text(_buCategories[index].businessUnitName,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400)),
                      secondary: const Icon(
                        Icons.lens,
                        color: Colors.black,
                        size: 16,
                      ),
                      activeColor: Colors.green,
                      checkColor: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
