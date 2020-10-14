import 'package:flutter/material.dart';
import 'package:p2p/constants.dart';
import 'package:p2p/localization/localization_constants.dart';

void openHistory(BuildContext context, Type notiList) {
  Size size = MediaQuery.of(context).size;

  // showGeneralDialog(
  //   context: context,
  //   barrierLabel: "Hello there",
  //   barrierDismissible: true,
  //   transitionDuration: Duration(milliseconds: 200), //This is time
  //   barrierColor: Colors.black.withOpacity(0.5), // Add this property is color
  //   pageBuilder: (BuildContext context, Animation animation,
  //       Animation secondaryAnimation) {
  //     return Center(
  //       child: Material(
  //         borderRadius: BorderRadius.circular(9),
  //         child: Container(
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9.0)), //this right here
        child: Container(
          height: size.height * 0.7,
          // decoration: new BoxDecoration(
          //   color: Colors.white,
          //   border: Border.all(
          //     color: Colors.white,
          //     width: 1,
          //   ),
          //   borderRadius: BorderRadius.circular(9),
          // ),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 20),
                  child: Text(
                    getTranslated(context, "PreviousApproversNotes"),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Phahithoun",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Colors.white),
                                    ),
                                    Text(
                                      "24/02/2020 1:30 PM",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Remarks : ",
                                      ),
                                      Flexible(
                                        child: new Text(
                                            "Text here..date appData.date appData date",
                                            style: TextStyle(),
                                            textAlign: TextAlign.left),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Phahithoun",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Colors.white),
                                    ),
                                    Text(
                                      "24/02/2020 1:30 PM",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Remarks : ",
                                      ),
                                      Flexible(
                                        child: new Text(
                                            "Text here..date appData.date appData date",
                                            style: TextStyle(),
                                            textAlign: TextAlign.left),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Phahithoun",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Colors.white),
                                    ),
                                    Text(
                                      "24/02/2020 1:30 PM",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Remarks : ",
                                      ),
                                      Flexible(
                                        child: new Text(
                                            "Text here..date appData.date appData date",
                                            style: TextStyle(),
                                            textAlign: TextAlign.left),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Phahithoun",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Colors.white),
                                    ),
                                    Text(
                                      "24/02/2020 1:30 PM",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Remarks : ",
                                      ),
                                      Flexible(
                                        child: new Text(
                                            "Text here..date appData.date appData date",
                                            style: TextStyle(),
                                            textAlign: TextAlign.left),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Phahithoun",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Colors.white),
                                    ),
                                    Text(
                                      "24/02/2020 1:30 PM",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Remarks : ",
                                      ),
                                      Flexible(
                                        child: new Text(
                                            "Text here..date appData.date appData date",
                                            style: TextStyle(),
                                            textAlign: TextAlign.left),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RaisedButton(
                      color: kOrangeColor,
                      child: new Text(
                        getTranslated(context, 'Close'),
                        style: TextStyle(color: kWhiteColor),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
