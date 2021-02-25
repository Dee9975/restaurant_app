
import 'package:flutter/material.dart';
import 'package:restaurant_app/src/resources/models/restaurant.dart';

class SearchCard extends StatefulWidget {
  final List<Restaurant> data;
  final Function(String) onChange;

  SearchCard({Key key, this.data, this.onChange}) : super(key: key);

  @override
  SearchCardState createState() => SearchCardState();
}

class SearchCardState extends State<SearchCard> {
  final TextEditingController _searchControl = new TextEditingController();

  @override
  void dispose() {
    _searchControl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _searchControl.addListener(() {
      if (widget.onChange != null) {
        widget.onChange(_searchControl.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    void findMatch(String input) {
      if (input.length > 0) {

      }
    }

    _searchControl.addListener(() {
      findMatch(_searchControl.text);
    });
    return Card(
      elevation: 6.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: TextField(
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            hintText: "Search..",
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            suffixIcon: Icon(
              Icons.filter_list,
              color: Colors.black,
            ),
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
            ),
          ),
          maxLines: 1,
          controller: _searchControl,
        ),
      ),
    );
  }
}