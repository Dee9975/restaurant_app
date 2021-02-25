import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app/src/resources/mock_data/categories.dart';
import 'package:restaurant_app/src/resources/mock_data/friends.dart';
import 'package:restaurant_app/src/resources/mock_data/restaurants.dart';
import 'package:restaurant_app/src/resources/models/category.dart';
import 'package:restaurant_app/src/resources/models/restaurant.dart';
import 'package:restaurant_app/src/screens/details.dart';
import 'package:restaurant_app/src/screens/food_menu.dart';
import 'package:restaurant_app/src/screens/pager.dart';
import 'package:restaurant_app/src/screens/trending.dart';
import 'package:restaurant_app/src/widgets/category_item.dart';
import 'package:restaurant_app/src/widgets/search_card.dart';
import 'package:restaurant_app/src/widgets/slide_item.dart';
import 'package:supercharged/supercharged.dart';
import 'package:string_similarity/string_similarity.dart';

import 'categories.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Restaurant> data = restaurants;

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildSearchBar(context),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),
            buildRestaurantRow('Trending Restaurants', context),
            SizedBox(height: 10.0),
            buildRestaurantList(context),
            SizedBox(height: 10.0),
            buildCategoryRow('Category', context),
            SizedBox(height: 10.0),
            buildCategoryList(context),
            SizedBox(height: 20.0),
            buildCategoryRow('Friends', context),
            SizedBox(height: 10.0),
            buildFriendsList(),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }

  buildRestaurantRow(String restaurant, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "$restaurant",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        FlatButton(
          child: Text(
            "See all (${restaurants.length})",
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Trending();
                },
              ),
            );
          },
        ),
      ],
    );
  }

  buildCategoryRow(String category, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "$category",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        FlatButton(
          child: Text(
            "See all (${categories.length})",
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Categories();
                },
              ),
            );
          },
        ),
      ],
    );
  }

  buildSearchBar(BuildContext context) {
    return PreferredSize(
      child: Padding(
        padding: EdgeInsets.only(
          top: Platform.isAndroid ? 30.0 : 50.0,
          left: 10.0,
          right: 10.0,
        ),
        child: SearchCard(
          onChange: findRestaurant,
        ),
      ),
      preferredSize: Size(
        Get.width,
        60.0,
      ),
    );
  }

  buildCategoryList(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      child: ListView.builder(
        primary: false,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categories == null ? 0 : categories.length,
        itemBuilder: (BuildContext context, int index) {
          Category cat = categories[index];

          return CategoryItem(
            cat: cat,
          );
        },
      ),
    );
  }

  buildRestaurantList(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.4,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          Restaurant restaurant = data[index];

          return restaurant.rating > 4.0 ? Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => FoodMenu());
              },
              child: SlideItem(
                img: restaurant.img,
                title: restaurant.title,
                address: restaurant.address,
                rating: restaurant.rating.toString(),
              ),
            ),
          ) : Offstage();
        },
      ),
    );
  }

  buildFriendsList() {
    return Container(
      height: 50.0,
      child: ListView.builder(
        primary: false,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: friends == null ? 0 : friends.length,
        itemBuilder: (BuildContext context, int index) {
          String img = friends[index];

          return Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                img,
              ),
              radius: 25.0,
            ),
          );
        },
      ),
    );
  }
}
