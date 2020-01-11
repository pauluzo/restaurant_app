import 'package:demo_app/blocs/bloc_provider.dart';
import 'package:demo_app/models/foodList_model.dart';
import 'package:demo_app/models/meal_model.dart';
import 'package:rxdart/rxdart.dart';

/* 
  Business Logic Component that provides subject listeners with list 
  of foodItems for each category
*/
class FoodItemBloc implements BlocBase {
  static final List<FoodItem> _mainMealList = FoodList.forMEAL().itemList;
  static final List<FoodItem> _proteinList = FoodList.forPROTEIN().itemList;
  static final List<FoodItem> _sauceList = FoodList.forSAUCE().itemList;
  static final List<FoodItem> _sideMealList = FoodList.forSIDEMEAL().itemList;
  static final List<FoodItem> _drinksList = FoodList.forDRINKS().itemList;
  static final List<FoodItem> _swallowList = FoodList.forSWALLOW().itemList;
  static final List<FoodItem> _soupList = FoodList.forSOUP().itemList;

  BehaviorSubject<List<FoodItem>> _mainMealController = BehaviorSubject<List<FoodItem>>();
  BehaviorSubject<List<FoodItem>> _proteinController = BehaviorSubject<List<FoodItem>>();
  BehaviorSubject<List<FoodItem>> _sauceController = BehaviorSubject<List<FoodItem>>();
  BehaviorSubject<List<FoodItem>> _sideMealController = BehaviorSubject<List<FoodItem>>();
  BehaviorSubject<List<FoodItem>> _drinksController = BehaviorSubject<List<FoodItem>>();
  BehaviorSubject<List<FoodItem>> _swallowController = BehaviorSubject<List<FoodItem>>();
  BehaviorSubject<List<FoodItem>> _soupController = BehaviorSubject<List<FoodItem>>();

  Sink<List<FoodItem>> get _inMainMeal => _mainMealController.sink;
  Stream<List<FoodItem>> get outMainMeal => _mainMealController.stream;
  Sink<List<FoodItem>> get _inProtein => _proteinController.sink;
  Stream<List<FoodItem>> get outProtein => _proteinController.stream;
  Sink<List<FoodItem>> get _inSauce => _sauceController.sink;
  Stream<List<FoodItem>> get outSauce => _sauceController.stream;
  Sink<List<FoodItem>> get _inSideMeal => _sideMealController.sink;
  Stream<List<FoodItem>> get outSideMeal => _sideMealController.stream;
  Sink<List<FoodItem>> get _inDrinks => _drinksController.sink;
  Stream<List<FoodItem>> get outDrinks => _drinksController.stream;
  Sink<List<FoodItem>> get _inSwallow => _swallowController.sink;
  Stream<List<FoodItem>> get outSwallow => _swallowController.stream;
  Sink<List<FoodItem>> get _inSoup => _soupController.sink;
  Stream<List<FoodItem>> get outSoup => _soupController.stream;

  // Each of the subjects' sink is initialized and prepopulated with a meal category's food list
  FoodItemBloc() {
    _inMainMeal.add(_mainMealList);
    _inProtein.add(_proteinList);
    _inSauce.add(_sauceList);
    _inSideMeal.add(_sideMealList);
    _inDrinks.add(_drinksList);
    _inSwallow.add(_swallowList);
    _inSoup.add(_soupList);
  }

  @override
  void dispose() {
    _mainMealController.close();
    _proteinController.close();
    _sauceController.close();
    _sideMealController.close();
    _drinksController.close();
    _swallowController.close();
    _soupController.close();
  }
}

