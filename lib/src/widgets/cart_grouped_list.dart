import 'package:flutter/material.dart';
import 'package:restaurant_app/src/resources/controllers/shopping_cart_controller.dart';
import 'package:restaurant_app/src/resources/models/food.dart';
import 'package:restaurant_app/src/widgets/shopping_cart_item.dart';

class CartGroupedList extends StatefulWidget {
  final List<Food> food;
  final String id;
  final Function(Food) onRemoved;

  CartGroupedList({
    Key key,
    this.food,
    this.id,
    this.onRemoved,
  }) : super(key: key);

  @override
  CartGroupedListState createState() => CartGroupedListState();
}

class CartGroupedListState extends State<CartGroupedList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.food.length > 0 ? Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Restaurant ${widget.id}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ) : Offstage(),
          Column(
            children: widget.food
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ShoppingCartItem(
                      food: e,
                      onRemoved: (item) {
                        setState(() {
                          widget.food
                              .removeWhere((element) => element.id == item.id);
                        });
                        widget.onRemoved(item);
                      },
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
