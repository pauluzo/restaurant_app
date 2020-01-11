// A class model for each food item (created with pure dart)
class FoodItem {
  final String foodName;
  final int price;
  final List<String> toppings;
  final String mealClass;
  int quantity;
  // constructor
  FoodItem({this.foodName, this.price, this.mealClass, this.quantity, this.toppings});

  // A named constructor function, to assign values to the flelds of a class from a Map()
  FoodItem.fromMap(Map<String, dynamic> map) 
    : foodName = map['name'],
      mealClass = map['mealClass'],
      price = map['price'],
      quantity = map['quantity'],
      toppings = map['extraPortions'];
}