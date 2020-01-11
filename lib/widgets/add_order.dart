import 'dart:async';

import 'package:demo_app/blocs/bloc_provider.dart';
import 'package:demo_app/blocs/orders_bloc.dart';
import 'package:demo_app/models/meal_model.dart';
import 'package:flutter/material.dart';

class AddOrderButton extends StatefulWidget {
  final bool mayPop;
  final int duplicate;
  final int index;
  AddOrderButton({Key key, @required this.mayPop, this.duplicate, this.index}) : super(key : key);
  @override
  _AddOrderButtonState createState() => _AddOrderButtonState(duplicate: duplicate);
}

class _AddOrderButtonState extends State<AddOrderButton> {
  _AddOrderButtonState({@required this.duplicate});
  int duplicateOrders = 1;
  int duplicate;
  StreamSubscription _subscription;
  bool _noDialog = false;


  
  @override
  Widget build(BuildContext context) {
    OrderBloc _orderBloc = BlocProvider.of<OrderBloc>(context);
    List<FoodItem> _currentFoodList = <FoodItem>[];
    if(duplicate != null) {
      duplicateOrders = duplicate;
    }

    addOrder() {
      (widget.duplicate == null)
      ? _orderBloc.inOrderItem.add([null, duplicateOrders, _currentFoodList])
      : _orderBloc.inEditedOrder.add([widget.index, duplicate, _currentFoodList]);
      _orderBloc.inAddFood.add(null);
      setState(() {
        duplicateOrders = 1; 
      });
      if(widget.mayPop) {
        Navigator.pop(context);
      }
    }

    _subscription = _orderBloc.outCurrentList.listen((onData) => _currentFoodList = onData);
    return Container(
      height: 40.0,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    iconSize: 25,
                    icon: Icon(Icons.remove),
                    onPressed: (duplicateOrders <= 1) 
                    ? null
                    : () {
                      setState(() {
                        (duplicate != null) ? duplicate -= 1 : duplicateOrders -= 1;
                      });
                    },
                  ),
                  Text(duplicateOrders.toString(), style: TextStyle(fontSize: 22),),
                  IconButton(
                    icon: Icon(Icons.add),
                    iconSize: 25,
                    onPressed: () {
                      setState(() {
                        (duplicate != null) ? duplicate += 1 : duplicateOrders += 1;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.deepPurple[600],
              ),
              child: StreamBuilder<bool>(
                stream: _orderBloc.outNoDialog,
                initialData: false,
                builder: (context, snapshot) {
                  return FlatButton(
                    color: Colors.deepPurple[600],
                    child: Text((widget.duplicate == null) ? 'Add to Orders' : 'Replace Order', 
                    style: TextStyle(fontSize: 18.0),
                    ),
                    onPressed: () {
                      if(!snapshot.data) {
                        showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return(
                            AlertDialog(
                              title: Center(
                                child: Icon(Icons.info, color: Colors.blue, size: 30,),
                              ),
                              content: StatefulBuilder(
                                builder: (BuildContext context, StateSetter setState) {
                                  return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text('The food item(s) you selected will be treated as ONE order. (i.e packed together). Press accept if you have selected all the food items for this order.'),
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        activeColor: Colors.blue,
                                        value: _noDialog,
                                        onChanged: (bool newValue) {
                                          setState(() {
                                            _noDialog = newValue; 
                                          });
                                        },
                                      ),
                                      Text('Do not show this again.')
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 20.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        RaisedButton(
                                          child: Text('Accept', style: TextStyle(fontSize: 18.0,)),
                                          onPressed: () {
                                            _orderBloc.inDialog.add(_noDialog);
                                            Navigator.pop(context, true);
                                          },
                                        ),
                                        RaisedButton(
                                          color: Colors.transparent,
                                          child: Text('Go Back', style: TextStyle(fontSize: 18.0, color: Colors.blue)),
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              );
                                },
                              ),
                            )
                          );
                        }
                      ).then((val) {
                        if(val) {
                          addOrder();
                        }
                      });
                      }
                      else {
                        addOrder();
                      }
                    },
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}