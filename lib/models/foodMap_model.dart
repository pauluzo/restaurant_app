// A pure dart class

/*
  An ordered map of data to be consumed by the app. This data should be provided by an api,
  hence this acts as a mock service.
*/
const Map<String, List<String>> extraPortions = {
  'Plantain' : ['Fried Rice', 'Jollof Rice', 'Special Rice', 'Beans', 'Fried Yam', 'Spaghetti'],
  'Egg' : ['Fried Rice', 'Jollof Rice', 'Beans', ],
  'Salad' : ['Fried Rice', 'Jollof Rice',],
  'Moimoi' : ['Fried Rice', 'Jollof Rice'],
  'Jollof Rice' : ['Fried Rice'],
  'Fried Rice' : ['Jollof Rice'],
  'Egg Sauce' : ['Fried Yam'],
  'Fish Sauce' : ['Fried Yam'],
  'Chicken Sauce' : ['Fried Yam'],
  'Stew' : ['Fried Yam']
};

/* 
  A list of food items, which gets the value for [extraPortions] from the map data above.
  This data should also be provided by an api, so this acts a mock service. 
*/
final List<List> list = [['Jollof Rice', 400, 'MainMeal', extraPortions['Jollof Rice']], ['Fried Rice', 400, 'MainMeal', extraPortions['Fried Rice']],
  ['Special Rice', 700, 'MainMeal', null], ['Beans', 300, 'MainMeal', null], ['Yam Porridge', 400, 'MainMeal', null], ['Fried Yam', 400, 'MainMeal', null],
  ['Spaghetti', 400, 'MainMeal', null], ['Eba', 200, 'Swallow', null], ['Fufu', 200, 'Swallow', null], ['Amala', 200, 'Swallow', null], 
  ['Starch', 200, 'Swallow', null], ['Pounded Yam', 300, 'Swallow', null], ['Plantain', 300, 'Side', extraPortions['Plantain']], ['Salad', 200, 'Side', extraPortions['Salad']],
  ['Moimoi', 200, 'Side', extraPortions['Moimoi']], ['Egg', 100, 'Side', extraPortions['Egg']], ['Egg Sauce', 400, 'Sauce', extraPortions['Egg Sauce']], 
  ['Fish Sauce', 400, 'Sauce', extraPortions['Fish Sauce']], ['Chicken Sauce', 400, 'Sauce', extraPortions['Chicken Sauce']], 
  ['Stew', 200, 'Sauce', extraPortions['Stew']], ['Beef', 300, 'Protein', null], ['Grilled Chicken', 700, 'Protein', null], ['Fried Chicken', 700, 'Protein', null], 
  ['Peppered Chicken', 800, 'Protein', null], ['Whole Fish', 800, 'Protein', null], ['Bottle Water', 100, 'Drink', null], ['Fanta', 200, 'Drink', null], ['Coke', 200, 'Drink', null], 
  ['Sprite', 200, 'Drink', null], ['Juice', 600, 'Drink', null], ['Ribena', 400, 'Drink', null], ['Egusi', 200, 'Soup', null], 
  ['Afang', 200, 'Soup', null], ['Ogbono', 200, 'Soup', null], ['Edikaikong', 200, 'Soup', null], ['Okra', 200, 'Soup', null]];

// class model for creating a list of food items from the List data provided to the class constructor
class FoodListProvider {
  List<Map<String, dynamic>> foodItemList = List<Map<String, dynamic>>();

  /* 
    function to create a food item map for each food item and assign values to it from the list object
    provided to this class' constructor. It includes each food item to the [foodItemList] after mapping.
  */
  void addToMap(List list) {
    Map<String, dynamic> _foodItemMap = Map<String, dynamic>();

    _foodItemMap['name'] = list[0];
    _foodItemMap['price'] = list[1];
    _foodItemMap['quantity'] = 0;
    _foodItemMap['mealClass'] = list[2];
    _foodItemMap['extraPortions'] = list[3];

    foodItemList.add(_foodItemMap); 
  }

  // class constructor, accepts a [List<List>] and maps its values, using the add to map function of this class.
  FoodListProvider(List<List> list) {
    list.forEach((item) {
      addToMap(item);
    });
  }
}

// An instance of the foodListProvider class model for import by classes that might need to implement it
FoodListProvider listProvider = FoodListProvider(list);
