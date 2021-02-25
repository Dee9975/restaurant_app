import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/src/resources/controllers/shopping_cart_controller.dart';
import 'package:restaurant_app/src/resources/models/food.dart';

class ShoppingCartItem extends StatelessWidget {
  final Food food;
  final Function(Food) onRemoved;
  ShoppingCartItem({this.food, this.onRemoved});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  child: Image.asset(food.image),
                  width: 50,
                ),
                SizedBox(
                  width: 16.0,
                ),
                Text("${food.quantity}X "),
                Container(
                    width: Get.width - 232,
                    child: Text(food.name)),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                onRemoved(food);
              },
              child: Text("Remove"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).accentColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
