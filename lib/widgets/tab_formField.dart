import 'package:demo_app/blocs/bloc_provider.dart';
import 'package:demo_app/blocs/orders_bloc.dart';
import 'package:demo_app/models/meal_model.dart';
import 'package:demo_app/pages/food_select.dart';
import 'package:flutter/material.dart';

class TabFormField extends StatelessWidget {
  TabFormField({Key key, @required this.foodItem}) : super(key : key);
  final FoodItem foodItem;

  @override
  Widget build(BuildContext context) {
    OrderBloc _orderBloc = BlocProvider.of<OrderBloc>(context);

    return Container(
      child: Column(
      children: <Widget>[
        StreamBuilder(
          stream: _orderBloc.outCurrentList,
          builder: (BuildContext context, AsyncSnapshot<List<FoodItem>> snapshot) {
            FoodItem _thisFoodItem = FoodItem(foodName: foodItem.foodName, price: foodItem.price, quantity: 0, toppings: foodItem.toppings);
            if(snapshot.data != null && snapshot.data.isNotEmpty) {
              for (var item in snapshot.data) {
                if(item.foodName == foodItem.foodName) {
                  _thisFoodItem = item;
                  break;
                }
              }
            }

            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: InkWell(
                onTap: () {
                  _orderBloc.inAddFood.add(_thisFoodItem);
                },
                child: Container(
                  height: 70.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_thisFoodItem.foodName, style: TextStyle(color: Colors.white70, fontSize: 16.0),),
                          Text('1 portion', style: TextStyle(color: Colors.white70, fontSize: 14.0),),
                          Text('\u{20A6} ${_thisFoodItem.price.toString()}', style: TextStyle(color: Colors.white70, fontSize: 16.0),),
                        ],
                      ),
                      Container(
                        width: 150,
                        padding:EdgeInsets.all(5.0),
                        child: (_thisFoodItem.quantity <= 0) 
                        ? null
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 25,
                              height: 25,
                              child: Material(
                                type: MaterialType.canvas,
                                color: Colors.deepPurple,
                                child: Center(child: Text(_thisFoodItem.quantity.toString(), style: TextStyle(color: Colors.white, fontSize: 20.0),)),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                _orderBloc.inRemoveFood.add(_thisFoodItem);
                              },
                              child: Container(
                                height: 30.0,
                                width: 30.0,
                                child: Material(
                                  type: MaterialType.circle,
                                  color: Colors.red,
                                  child: Icon(Icons.remove, color: Colors.white,),
                                ),
                              ),
                            ),
                          ],  
                        ),
                      )  
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        Divider(
          color: Colors.white70,
        ),
      ],
    )
    );
  }
}

// Create a pseudo TabForm that directs to another page, when tapped
class PseudoTabForm extends StatelessWidget {
  final FoodItem foodItem;
  PseudoTabForm({Key key, @required this.foodItem}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    OrderBloc _orderBloc = BlocProvider.of<OrderBloc>(context);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 70.0,
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            width: MediaQuery.of(context).size.width,
            child: InkWell(
              onTap: () {
                _orderBloc.inAddFood.add(null);
                Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => FoodItemProvider(foodItem: foodItem,)
                ));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(foodItem.foodName, style: TextStyle(color: Colors.white70, fontSize: 16.0),),
                  Text('1 portion', style: TextStyle(color: Colors.white70, fontSize: 14.0),),
                  Text('\u{20A6} ${foodItem.price.toString()}', style: TextStyle(color: Colors.white70, fontSize: 16.0),),
                ],
              ),
            ),
          ),
          Divider(color: Colors.white70,)
        ],
      ),
    );
  }
}