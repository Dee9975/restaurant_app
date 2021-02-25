import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/src/screens/shopping_cart.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        right: 5.0,
      ),
      child: new Row(
        children: [
          new Expanded(
            flex: 3,
            child: new Row(
              children: <Widget>[
                new IconButton(
                  tooltip: 'Menu Icon',
                  icon: new Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  ),
                  onPressed: () => Get.back(),
                ),
                new Expanded(
                  child: new Text('MENU',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 21.0,
                          fontFamily: 'Dosis',
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          new IconButton(
            tooltip: 'Shopping Cart',
            icon: new Icon(
              Icons.shopping_cart,
              color: Colors.black87,
            ),
            onPressed: () => Get.to(() => ShoppingCart()),
          ),
        ],
      ),
    );
  }
}
