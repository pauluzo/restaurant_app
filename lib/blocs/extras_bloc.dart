import 'package:demo_app/models/foodList_model.dart';
import 'package:demo_app/models/meal_model.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc_provider.dart';

/* 
  This bloc handles the logic for the list of extra portions suggestion for a main meal item.
  It receives a [FoodItem] when instantiated, to suggest extras options for the foodItem. 
*/
class ExtrasBloc implements BlocBase {
  // subject for receiving and sending out list of food extras for a particular food item.
  BehaviorSubject<List<FoodItem>> _foodExtrasController = BehaviorSubject<List<FoodItem>>();
  Sink<List<FoodItem>> get _inFoodExtras => _foodExtrasController.sink;
  Stream<List<FoodItem>> get outFoodExtras => _foodExtrasController.stream;
  
  // constructor that receives a [FoodItem] and attemps to get a list of extras for the foodItem
  ExtrasBloc(FoodItem foodItem) {
    // list that contains all the food items, gotten from the [FoodList] model
    List<FoodItem> _foodList = FoodList().itemList;
    List<FoodItem> _newExtrasList = List<FoodItem>();
    // list that contains all the food items associated to THIS food item as extra, otherwise, null
    List<FoodItem> _extrasList = _foodList.map((item) {
      if(item.toppings != null && item.toppings.contains(foodItem.foodName)) {
        return item;
      }
      return null;
    }).toList();
    // remove the [null] values from the extrasList and return the new list as [_newExtrasList]
    for (var item in _extrasList) {
      if(item.runtimeType == FoodItem) {
        _newExtrasList.add(item);
      }
    }
    // Add the new extras list to the subject's sink.
    _inFoodExtras.add(_newExtrasList);
  }

  @override
  void dispose() {
    _foodExtrasController.close();
  }
}