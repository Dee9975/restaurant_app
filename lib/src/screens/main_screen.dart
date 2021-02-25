import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/src/resources/controllers/shopping_cart_controller.dart';
import 'package:restaurant_app/src/resources/mock_data/categories.dart';
import 'package:restaurant_app/src/resources/mock_data/restaurants.dart';
import 'package:restaurant_app/src/screens/shopping_cart.dart';
import 'package:supercharged/supercharged.dart';

import 'home.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;

  List icons = [
    Icons.home,
    Icons.label,
    Icons.shopping_cart,
    Icons.notifications,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: List.generate(5, (index) => Home()),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 7),
            buildTabIcon(0),
            buildTabIcon(1),
            buildTabIcon(2),
            buildTabIcon(3),
            buildTabIcon(4),
            SizedBox(width: 7),
          ],
        ),
        color: Theme.of(context).primaryColor,
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Stack(
        children: [
          FloatingActionButton(
            elevation: 10.0,
            child: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              if (ShoppingCartController.to.items.length > 0) {
                Get.to(() => ShoppingCart());
              }
            },
          ),
          Obx(() => ShoppingCartController.to.items.length > 0 ? Positioned(
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.amber),
                      child: Text(
                        ShoppingCartController.to.getTotalCount().toString(),
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    top: 0.0,
                    right: 0.0,
                  ) : Offstage(),
              ),
        ],
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    restaurants = restaurants.sortedBy(
      (a, b) => b.rating.compareTo(a.rating),
    );
    categories = categories.sortedByString((element) => element.name);
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  buildTabIcon(int index) {
    if (index == 2) {
      return IconButton(
        icon: Icon(
          icons[index],
          size: 24.0,
          color: Colors.transparent,
        ),
        onPressed: null,
      );
    } else {
      return IconButton(
        icon: Icon(
          icons[index],
          size: 24.0,
        ),
        color: _page == index
            ? Theme.of(context).accentColor
            : Theme.of(context).textTheme.caption.color,
        onPressed: () => _pageController.jumpToPage(index),
      );
    }
  }
}
