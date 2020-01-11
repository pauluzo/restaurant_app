import 'package:demo_app/blocs/bloc_provider.dart';
import 'package:demo_app/blocs/orders_bloc.dart';
import 'package:demo_app/models/meal_model.dart';
import 'package:demo_app/models/orders_model.dart';
import 'package:demo_app/pages/edit_orders.dart';
import 'package:flutter/material.dart';

class  OrderContainer extends StatelessWidget {
  OrderContainer({Key key, this.orderData, this.index}) : super(key : key);
  final Order orderData;
  final int index;

  @override
  Widget build(BuildContext context) {
    OrderBloc _orderBloc = BlocProvider.of<OrderBloc>(context);
    return Container(
      child: GestureDetector(
        onTap: () {
          orderData.index = index;
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => EditOrder(
              order: orderData,
            )
          ));
          _orderBloc.inAddFood.add(null);
        }, 
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.deepPurpleAccent),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'ORDER ${index + 1}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    Container(
                      padding: EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: InkWell(
                        child: Icon(Icons.close, color: Colors.red,),
                        onTap: () {
                          _orderBloc.inRemoveOrder.add(orderData);
                        },
                      ),
                    ),
                  ],
                ),
              ), 
              Builder(
                builder: (BuildContext context) {
                  List<FoodItem> _foodList = orderData.foodList;
                  List<Row> _foodItems = _foodList.map((item) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 100.0,
                          child: Text('${item.foodName}', 
                          style: TextStyle(fontSize: 14.0),)
                        ),
                        Text('${item.quantity}'),
                        Text('\u{20A6} ${item.price * item.quantity}'),
                      ],
                    );
                  }).toList();
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: _foodItems,
                  );
                },
              ),
              Text('No of same orders:  ${orderData.duplicate}', style: TextStyle(fontSize: 16.0),),
              Text('Order Total:  \u{20A6} ${orderData.total}', style: TextStyle(fontSize: 15.0),),
            ],
          ),
        ),
      ),
    );
  }
}