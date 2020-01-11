import 'meal_model.dart';

// A class model to represent the data required each time an order is made.
class Order {
  List<FoodItem> foodList;
  int duplicate = 1;
  int total = 0;
  int index;

  Order();
}