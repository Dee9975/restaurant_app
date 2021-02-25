import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/src/screens/pager.dart';

class FoodMenu extends StatelessWidget {
  FoodMenu() {
    SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        alignment: AlignmentDirectional.topEnd,
        children: <Widget>[
          new MenuPager(),
        ],
      ),
    );
  }
}
