import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:p2p/Screens/Approval/FilterDataPODO.dart';
import 'package:p2p/Screens/HomePage/homePage.dart';
import 'package:p2p/constants/Network.dart';
import 'package:p2p/constants/Services.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

class SideMenuCat extends StatefulWidget {
  SideMenuCat();

  @override
  _SideMenuCatState createState() => _SideMenuCatState();
}

class _SideMenuCatState extends State<SideMenuCat> {
  List selecteCategorys = List();
  List<ResultObject> filterDataList = new List();
  bool isLoading = true;

  void _onCategorySelected(bool selected, categoryId) {
    if (selected == true) {
      setState(() {
        selecteCategorys.add(categoryId);
      });
    } else {
      setState(() {
        selecteCategorys.remove(categoryId);
      });
    }

    print(selecteCategorys);
  }

  Future<void> _getFilterList() async {
    Network().check().then((intenet) async {
      if (intenet != null && intenet) {
        try {
          final uri = Services.ApprovalList;
          filterDataList.clear();

          http.get(uri).then((response) async {
            if (response.statusCode == 200) {
              var jsonResponse = jsonDecode(response.body);
              print("Reponse---2 : $jsonResponse");
              if (jsonResponse["StatusCode"] == 200) {
                FilterData filterList = new FilterData.fromJson(jsonResponse);
                setState(() {
                  filterDataList =
                      filterList.resultObject as List<ResultObject>;
                  isLoading = false;
                });
                print("filterDataList ${filterDataList.length}");
                print("filterDataList ${filterDataList[0]}");
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

  @override
  void initState() {
    super.initState();
    _getFilterList();
  }

  @override
  Widget build(BuildContext context) {
    Map _categories = const {
      "responseBody": [
        {"category_id": "t0", "category_name": "Purchase"},
        {"category_id": "t1", "category_name": "Payments"}
      ],
      "responseTotalResult":
          2 // Total result is 3 here becasue we have 3 categories in responseBody.
    };

    Map _buCategories = const {
      "responseBody": [
        {"category_id": "bu0", "category_name": "Headquarters"},
        {"category_id": "bu1", "category_name": "Banquet"},
        {"category_id": "bu2", "category_name": "Exhibition"},
        {"category_id": "bu3", "category_name": "Itexx Savan"},
        {"category_id": "bu4", "category_name": "Itecc Mall"},
        {"category_id": "bu5", "category_name": "Ocean Park"},
      ],

      "responseTotalResult":
          6 // Total result is 3 here becasue we have 3 categories in responseBody.
    };

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
                itemCount: _categories['responseTotalResult'],
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    // margin: EdgeInsets.fromLTRB(0, 8, 0, 8.0),

                    height: 40,
                    child: CheckboxListTile(
                      value: selecteCategorys.contains(
                          _categories['responseBody'][index]['category_id']),
                      onChanged: (bool selected) {
                        _onCategorySelected(selected,
                            _categories['responseBody'][index]['category_id']);
                      },
                      title: Text(
                          _categories['responseBody'][index]['category_name'],
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
                itemCount: _buCategories['responseTotalResult'],
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 40,
                    child: CheckboxListTile(
                      value: selecteCategorys.contains(
                          _buCategories['responseBody'][index]['category_id']),
                      onChanged: (bool selected) {
                        _onCategorySelected(
                            selected,
                            _buCategories['responseBody'][index]
                                ['category_id']);
                      },
                      title: Text(
                          _buCategories['responseBody'][index]['category_name'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
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
