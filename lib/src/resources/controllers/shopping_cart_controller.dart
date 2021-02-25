import 'package:get/get.dart';
import 'package:restaurant_app/src/resources/models/food.dart';
import 'package:supercharged/supercharged.dart';

class ShoppingCartController extends GetxController {
  static ShoppingCartController get to => Get.find();

  final items = <Food>[].obs;

  void addItem(Food food) {
    bool found = false;
    items.forEachIndexed((index, element) {
      if (element.id == food.id) {
        int quantity = element.quantity + food.quantity;
        items.removeAt(index);
        items.add(
          Food(
            name: food.name,
            quantity: quantity,
            id: food.id,
            price: food.price,
            restaurantId: food.restaurantId,
            image: food.image,
          ),
        );
        found = true;
      }
    });
    if (!found) {
      items.add(food);
    }
    update();
  }

  void removeItem(Food food) {
    items.removeWhere((element) => element.id == food.id);
    update();
  }

  int getTotalCount() {
    int total = 0;
    for (var value in items) {
      total += value.quantity;
    }

    return total;
  }
}
