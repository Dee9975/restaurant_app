import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/src/resources/controllers/shopping_cart_controller.dart';
import 'package:restaurant_app/src/resources/mock_data/restaurants.dart';
import 'package:restaurant_app/src/resources/models/restaurant.dart';
import 'package:restaurant_app/src/widgets/search_card.dart';
import 'package:restaurant_app/src/widgets/trending_item.dart';
import 'package:string_similarity/string_similarity.dart';

import 'food_menu.dart';

class Trending extends StatefulWidget {
  @override
  TrendingState createState() => TrendingState();
}

class TrendingState extends State<Trending> {
  List<Restaurant> data = restaurants;

  @override
  Widget build(BuildContext context) {
    void findRestaurant(String input) {
      List<Restaurant> foundData = [];
      if (input.length > 0) {
        restaurants.forEach((element) {
          if (input.similarityTo(element.title) > 0) {
            foundData.add(element);
          }
        });
        if (foundData.length > 0) {
          setState(() {
            data = foundData;
          });
        } else {
          setState(() {
            data = restaurants;
          });
        }
      } else {
        foundData = [];
        setState(() {
          data = restaurants;
        });
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("All restaurants"),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Get.to(() => FoodMenu());
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
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 10.0,
        ),
        child: ListView(
          children: <Widget>[
            SearchCard(
              onChange: (String value) {
                findRestaurant(value);
              },
            ),
            SizedBox(height: 10.0),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (BuildContext context, int index) {
                Restaurant restaurant = data[index];

                return GestureDetector(
                  onTap: () {
                    Get.to(() => FoodMenu());
                  },
                  child: TrendingItem(
                    img: restaurant.img,
                    title: restaurant.title,
                    address: restaurant.address,
                    rating: restaurant.rating.toString(),
                  ),
                );
              },
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}