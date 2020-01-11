import 'package:demo_app/models/meal_model.dart';
import 'bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:demo_app/models/orders_model.dart';

/*
  The power house of the application, where the bulk of the logic is implemented.
*/
class OrderBloc implements BlocBase {
  
  List<Order> _ordersList = <Order>[];

  BehaviorSubject<FoodItem> _addFoodController = BehaviorSubject<FoodItem>();
  Sink<FoodItem> get inAddFood => _addFoodController.sink;
  Stream<FoodItem> get _outAddFood => _addFoodController.stream;

  BehaviorSubject<FoodItem> _removeFoodController = BehaviorSubject<FoodItem>();
  Sink<FoodItem> get inRemoveFood => _removeFoodController.sink;
  Stream<FoodItem> get _outRemoveFood => _removeFoodController.stream;

  PublishSubject<Order> _addOrderController = PublishSubject<Order>();
  Sink<Order> get _inAddOrder => _addOrderController.sink;
  Stream<Order> get _outAddOrder => _addOrderController.stream;

  PublishSubject<Order> _removeOrderController = PublishSubject<Order>();
  Sink<Order> get inRemoveOrder => _removeOrderController.sink;
  Stream<Order> get _outRemoveOrder => _removeOrderController.stream;

  BehaviorSubject<List<Order>> _ordersListController = BehaviorSubject<List<Order>>();
  Sink<List<Order>> get _inOrderList => _ordersListController.sink;
  Stream<List<Order>> get outOrderList => _ordersListController.stream;

  BehaviorSubject<int> _ordersTotalController = BehaviorSubject<int>();
  Sink<int> get _inOrdersTotal => _ordersTotalController.sink;
  Stream<int> get outOrdersTotal => _ordersTotalController.stream;

  BehaviorSubject<int> _currentOrderTotalController = BehaviorSubject<int>();
  Sink<int> get _inCurrentTotal => _currentOrderTotalController.sink;
  Stream<int> get outCurrentTotal => _currentOrderTotalController.stream;

  BehaviorSubject<List<dynamic>> _orderItemController = BehaviorSubject<List<dynamic>>();
  Sink<List<dynamic>> get inOrderItem => _orderItemController.sink;
  Stream<List<dynamic>> get _outOrderItem => _orderItemController.stream;

  BehaviorSubject<List> _editedOrderController = BehaviorSubject<List>();
  Sink<List> get inEditedOrder => _editedOrderController.sink;
  Stream<List> get _outEditedOrder => _editedOrderController.stream;

  BehaviorSubject<List<FoodItem>> _currentOrderController = BehaviorSubject<List<FoodItem>>();
  Sink<List<FoodItem>> get _inCurrentList => _currentOrderController.sink;
  Stream<List<FoodItem>> get outCurrentList => _currentOrderController.stream;

  BehaviorSubject<bool> _dialogController = BehaviorSubject<bool>();
  Sink<bool> get inDialog => _dialogController.sink;
  Stream<bool> get _outDialog => _dialogController.stream;

  BehaviorSubject<bool> _noDialogController = BehaviorSubject<bool>();
  Sink<bool> get _inNoDialog => _noDialogController.sink;
  Stream<bool> get outNoDialog => _noDialogController.stream;

  int _total = 0;
  List<FoodItem> _currentFoodList = <FoodItem>[];

  OrderBloc () {
    _outAddFood.listen(_handleAddFood);
    _outRemoveFood.listen(_handleRemoveFood);
    _outAddOrder.listen(_handleAddOrders);
    _outRemoveOrder.listen(_handleRemoveOrders);
    _outOrderItem.listen(_handleOrder);
    _outEditedOrder.listen(_handleEditedOrder);
    _outDialog.listen((bool data) {
      _inNoDialog.add(data);
    });
  }

  void _getCurrentTotal() {
    int _currentTotal = 0;
    _currentFoodList.forEach((item) {
      _currentTotal += item.price * item.quantity;
    });
    _inCurrentTotal.add(_currentTotal);
  }

  void _handleAddFood (FoodItem  foodItem) {

    if(foodItem == null) {
      _currentFoodList = [];
      _inCurrentList.add(null);
      _inCurrentTotal.add(0);
    } 
    else {
      if(_currentFoodList.length >= 1) {
        List<FoodItem> itemList = List<FoodItem>();
        for (var i = 0; i < _currentFoodList.length; i++) {
          if(_currentFoodList[i].foodName == foodItem.foodName) {
            FoodItem _newFoodItem = _currentFoodList[i];
            _newFoodItem.quantity += 1;
            _currentFoodList.replaceRange(i, i+1 , [_newFoodItem]);
            _getCurrentTotal(); 
            _inCurrentList.add(_currentFoodList); 
            break;  
          } else {
            itemList.add(_currentFoodList[i]);
          }
        }
        if(itemList.length == _currentFoodList.length) {
          foodItem.quantity += 1;
          _currentFoodList.add(foodItem);
          _inCurrentList.add(_currentFoodList);
          _getCurrentTotal();
        }
      } else {
        foodItem.quantity += 1;
        _currentFoodList.add(foodItem);
        _inCurrentList.add(_currentFoodList);
        _getCurrentTotal();
      }
    }
  }

  void _handleRemoveFood(FoodItem foodItem) {

    if(_currentFoodList.length >= 1) {
      for (var i = 0; i < _currentFoodList.length; i++) {
        if(_currentFoodList[i].foodName == foodItem.foodName) {
          FoodItem _newFoodItem = _currentFoodList[i];
          _newFoodItem.quantity -= 1;
          if (_newFoodItem.quantity >= 1) {
            _currentFoodList.replaceRange(i, i+1, [_newFoodItem]);
          } else {
            _currentFoodList.removeAt(i);
          }
          _getCurrentTotal();
          _inCurrentList.add(_currentFoodList); 
          break;  
        } 
      }
    }
  }
  
  void _handleAddOrders (Order data) {
    _ordersList.add(data);
    _inOrderList.add(_ordersList);

    _handleTotal();
  }

  void _handleRemoveOrders(Order data) {
    _ordersList.remove(data); 
    _inOrderList.add(_ordersList);

    _handleTotal();
  }

  void _handleOrder(List data) {
    assert (data[0] == null);
    assert (data[1] > 0);
    if(data[2] != null && data[2].isNotEmpty) {
      Order _order = Order();

      _order.foodList = data[2];
      _order.duplicate = data[1];

      _addOrder(_order);
    } 
  }


  void _addOrder(Order data) {
    int total = 0;
    List<FoodItem> _foodList = data.foodList;
    _foodList.forEach((FoodItem item) {
      int itemTotal = item.price * item.quantity;
      total += itemTotal;
    });
    total *= data.duplicate; 
    data.total = total;
    _inAddOrder.add(data);
  }

  void _handleTotal() {
    _total = 0;
    _ordersList.forEach((Order itemm) {
      if(itemm.foodList != null && itemm.foodList.isNotEmpty) {
        _total += itemm.total;
      }
    });
    _inOrdersTotal.add(_total); 
  }


  void _handleEditedOrder (List data) {
    assert(data[0] != null);
    assert (data[1] != null && data[1] > 0);
    if(data[2] != null && data[2].isNotEmpty) {
      Order _order = Order();

      _order.index = data[0];
      _order.duplicate = data[1];
      _order.foodList = data[2];

      int total = 0;
      List<FoodItem> _foodList = _order.foodList;
      _foodList.forEach((FoodItem item) {
        int itemTotal = item.price * item.quantity;
        total += itemTotal;
      });
      total *= _order.duplicate; 
      _order.total = total;

      _handleReplaceOrder(_order);
    }
  }

  void _handleReplaceOrder (Order data) {
    _ordersList.replaceRange(data.index, data.index + 1, [data]);
    _inOrderList.add(_ordersList);

    _handleTotal();
  }

  @override
  void dispose() {
    _addOrderController.close();
    _removeOrderController.close();
    _ordersListController.close();
    _ordersTotalController.close();
    _orderItemController.close();
    _editedOrderController.close();
    _currentOrderTotalController.close();
    _addFoodController.close();
    _currentOrderController.close();
    _removeFoodController.close();
    _dialogController.close();
    _noDialogController.close();
  }
}