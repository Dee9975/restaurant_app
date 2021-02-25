import 'food.dart';

class Menu {
  static List<Food> menu = [
    Food(
      id: "1",
      image: "assets/menu1.png",
      name: "LASAGNE",
      price: "\$12",
      restaurantId: "2",
    ),
    Food(
      id: "3",
      image: "assets/menu11.png",
      name: "MUSHROOM RISOTTO",
      price: "\$4",
      restaurantId: "1",
    ),
    Food(
      id: "4",
      image: "assets/menu13.png",
      name: "CIOPPINO",
      price: "\$30",
      restaurantId: "3",

    ),
    Food(
      id: "5",
      image: "assets/menu12.png",
      name: "SEAFOOD PLATTER",
      price: "\$22",
      restaurantId: "1",

    ),
    Food(
      id: "2",
      image: "assets/menu3.png",
      name: "TORTELLINI WITH BROCCOLI",
      price: "\$8",
      restaurantId: "1",

    ),
    Food(
      id: "6",
      image: "assets/menu10.png",
      name: "MEAT ROLL",
      price: "\$19",
      restaurantId: "1",

    ),
    Food(
      id: "7",
      image: "assets/menu7.png",
      name: "SALMON SALAD",
      price: "\$25",
      restaurantId: "1",

    ),
    Food(
      id: "8",
      image: "assets/menu5.png",
      name: "MEATBALLS AND PASTA",
      price: "\$7",
      restaurantId: "1",

    ),
    Food(
      id: "9",
      image: "assets/menu9.png",
      name: "STEAK AU POIVRE",
      price: "\$63",
      restaurantId: "1",
    ),
    Food(
      id: "10",
      image: "assets/menu8.png",
      name: "CHICKEN SALAD",
      price: "\$43",
      restaurantId: "1",
    ),
  ];

  static Food getFoodById(id) {
    return menu.where((p) => p.id == id).first;
  }
}
