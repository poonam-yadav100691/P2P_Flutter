import 'package:flutter/material.dart';
import 'package:p2p/Screens/Approval/SideMenuCat.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.76,
      child: Drawer(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  width: 190.0,
                  child: DrawerHeader(
                    child: Image.asset('assets/images/logo-pa.png'),
                  ),
                  margin: EdgeInsets.all(0.0),
                  padding: EdgeInsets.all(0.0)),
            ),
            Expanded(
              flex: 6,
              child: Container(
                // color: Colors.yellow,
                child: SideMenuCat(),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
