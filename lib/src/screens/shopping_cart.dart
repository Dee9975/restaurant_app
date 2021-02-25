import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/src/resources/controllers/shopping_cart_controller.dart';
import 'package:restaurant_app/src/resources/models/food.dart';
import 'package:restaurant_app/src/widgets/cart_grouped_list.dart';
import 'package:restaurant_app/src/widgets/shopping_cart_item.dart';
import 'package:supercharged/supercharged.dart';

class ShoppingCart extends StatefulWidget {
  ShoppingCart({Key key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  var foodData = {};
  List<Widget> shoppingList = [];
  double total = 0;

  void updateShoppingList(Food item) {
    ShoppingCartController.to.removeItem(item);
    calculateCost(true, item);
  }

  void buildShoppingList() {
    foodData.forEach((key, value) {
      shoppingList.add(
        CartGroupedList(
          food: value,
          id: key,
          onRemoved: updateShoppingList,
        ),
      );
    });
  }

  void calculateCost([bool reduce = false, Food item]) {
    if (ShoppingCartController.to.items.length == 0) {
      setState(() {
        total = 0.0;
      });
    } else {
      if (reduce) {
        setState(() {
          if (item != null) {
            String strippedPrice = item.price.substring(1);
            double price = strippedPrice.toDouble();
            total -= price;
          }
        });
      } else {
        ShoppingCartController.to.items.forEach((element) {
          String strippedPrice = element.price.substring(1);
          double price = strippedPrice.toDouble();
          setState(() {
            total += price * element.quantity;
          });
        });
      }
    }
  }

  @override
  void initState() {
    ShoppingCartController.to.items.forEach((element) {
      if (foodData.containsKey(element.restaurantId)) {
        foodData[element.restaurantId].add(element);
      } else {
        foodData.putIfAbsent(element.restaurantId, () => [element]);
      }
    });
    calculateCost();
    buildShoppingList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping cart"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: shoppingList,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          height: 110,
          child: Center(
            child: Container(
                decoration: BoxDecoration(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total price:",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${total.toString()}\$",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: () => print("Pay"),
                        child: Container(
                          child: Center(
                            child: Text(
                              "Pay",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24.0),
                            ),
                          ),
                          width: Get.width,
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
