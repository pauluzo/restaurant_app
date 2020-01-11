import 'foodMap_model.dart';
import 'meal_model.dart';

/* 
  A class model for providing a sub-list of food items, depending on their category. 
  This is done by leveraging the use of named constructors in dart classes to provide food items
  that are peculiar to a particular food category e.g main meal, swallow, drinks, proteins
*/
class FoodList {
  // List of all food Item maps, gotten from the [foodMap_model]
  FoodListProvider _listProvider = listProvider;
  List<FoodItem> itemList;
  List<Map> foodList = [];
  // class constructor to get the list of all the food item maps
  FoodList() {
    // foodList is given the value of the list of maps gotten from the [foodMap_model]
    foodList = _listProvider.foodItemList;
    // itemList is a new list of [FoodItem] classes that are formed from mapping the values of foodList
    itemList = foodList.map((item) {
      return FoodItem.fromMap(item);
    }).toList();    
  }

  // Constructor for getting and storing all food items within the category of 'main meal', from [foodMap_model]
  FoodList.forMEAL() {
    foodList = _listProvider.foodItemList;

    Map<String, dynamic> newList = Map();
    List<Map<String, dynamic>> newMealList = List<Map<String, dynamic>>();
    // mealList is a derived list from [foodList], which contains food Items objects with category of 'main meal' or otherwise, null.
    List<Map<String, dynamic>> mealList = foodList.map((item) {
      if(item['mealClass'] == 'MainMeal') {
        newList = item;
      } else {
        newList = null;
      }
      return newList;
    }).toList();
    
    // iterator function to add non-null values of the [mealList] (i.e the values with category == main meal)
    for (var item in mealList) {
      if(item != null) {
        newMealList.add(item);
      }
    }

    // finally, the [newMealList] is mapped over to produce a list of [FoodItem] classes peculiar to only this 'main meal category. 
    itemList = newMealList.map((item) {
      return FoodItem.fromMap(item);
    }).toList();
  }

  // The above named constructor procedures is repeated for the other named constructors
  FoodList.forSWALLOW() {
    foodList = _listProvider.foodItemList;
    Map<String, dynamic> newList = Map();
    List<Map<String, dynamic>> newMealList = List<Map<String, dynamic>>();
    List<Map<String, dynamic>> mealList = foodList.map((item) {
      if(item['mealClass'] == 'Swallow') {
        newList = item;
      } else {
        newList = null;
      }
      return newList;
    }).toList();
    
    for (var item in mealList) {
      if(item != null) {
        newMealList.add(item);
      }
    }

    itemList = newMealList.map((item) {
      return FoodItem.fromMap(item);
    }).toList();
  }

  FoodList.forSOUP() {
    foodList = _listProvider.foodItemList;
    Map<String, dynamic> newList = Map();
    List<Map<String, dynamic>> newMealList = List<Map<String, dynamic>>();
    List<Map<String, dynamic>> mealList = foodList.map((item) {
      if(item['mealClass'] == 'Soup') {
        newList = item;
      } else {
        newList = null;
      }
      return newList;
    }).toList();
    
    for (var item in mealList) {
      if(item != null) {
        newMealList.add(item);
      }
    }

    itemList = newMealList.map((item) {
      return FoodItem.fromMap(item);
    }).toList();
  }

  FoodList.forSIDEMEAL() {
    foodList = _listProvider.foodItemList;
    Map<String, dynamic> newList = Map();
    List<Map<String, dynamic>> newMealList = List<Map<String, dynamic>>();
    List<Map<String, dynamic>> mealList = foodList.map((item) {
      if(item['mealClass'] == 'Side') {
        newList = item;
      } else {
        newList = null;
      }
      return newList;
    }).toList();
    
    for (var item in mealList) {
      if(item != null) {
        newMealList.add(item);
      }
    }

    itemList = newMealList.map((item) {
      return FoodItem.fromMap(item);
    }).toList();
  }

  FoodList.forSAUCE() {
    foodList = _listProvider.foodItemList;
    Map<String, dynamic> newList = Map();
    List<Map<String, dynamic>> newMealList = List<Map<String, dynamic>>();
    List<Map<String, dynamic>> mealList = foodList.map((item) {
      if(item['mealClass'] == 'Sauce') {
        newList = item;
      } else {
        newList = null;
      }
      return newList;
    }).toList();
    
    for (var item in mealList) {
      if(item != null) {
        newMealList.add(item);
      }
    }

    itemList = newMealList.map((item) {
      return FoodItem.fromMap(item);
    }).toList();
  }

  FoodList.forPROTEIN() {
    foodList = _listProvider.foodItemList;
    Map<String, dynamic> newList = Map();
    List<Map<String, dynamic>> newMealList = List<Map<String, dynamic>>();
    List<Map<String, dynamic>> mealList = foodList.map((item) {
      if(item['mealClass'] == 'Protein') {
        newList = item;
      } else {
        newList = null;
      }
      return newList;
    }).toList();
    
    for (var item in mealList) {
      if(item != null) {
        newMealList.add(item);
      }
    }

    itemList = newMealList.map((item) {
      return FoodItem.fromMap(item);
    }).toList();
  }

  FoodList.forDRINKS() {
    foodList = _listProvider.foodItemList;
    Map<String, dynamic> newList = Map();
    List<Map<String, dynamic>> newMealList = List<Map<String, dynamic>>();
    List<Map<String, dynamic>> mealList = foodList.map((item) {
      if(item['mealClass'] == 'Drink') {
        newList = item;
      } else {
        newList = null;
      }
      return newList;
    }).toList();
    
    for (var item in mealList) {
      if(item != null) {
        newMealList.add(item);
      }
    }

    itemList = newMealList.map((item) {
      return FoodItem.fromMap(item);
    }).toList();
  }
}