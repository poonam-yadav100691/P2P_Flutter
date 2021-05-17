import 'package:flutter/material.dart';
import 'package:p2p/Screens/Approval/SideMenuCat.dart';
import 'package:p2p/constants.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void getDate() => {Navigator.pop(context)};
    return Container(
      width: size.width * 0.66,
      child: Drawer(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  // height: 50.0,
                  child: DrawerHeader(
                    child: Image.asset('assets/images/logo-pa.png'),
                  ),
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.all(0.0)),
            ),
            Expanded(
              flex: 5,
              child: Container(
                // color: Colors.yellow,
                child: SideMenuCat(),
              ),
            ),
            ElevatedButton(
              onPressed: () => {getDate()},
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(
                    colors: <Color>[
                      kOrangeColor,
                      kOrangeColor,
                    ],
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 10.0, 16, 10),
                child: const Text('Get Data', style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
