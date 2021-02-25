import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:restaurant_app/src/app.dart';

void main() async {
  await GetStorage.init();
  runApp(App());
}