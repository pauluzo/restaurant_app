import 'package:demo_app/models/meal_model.dart';
import 'package:demo_app/models/orders_model.dart';
import 'package:demo_app/widgets/add_order.dart';
import 'package:demo_app/widgets/current_total.dart';
import 'package:demo_app/widgets/tab_formField.dart';
import 'package:flutter/material.dart';

class EditOrderWidget extends StatelessWidget {
  final Order order;
  EditOrderWidget({Key key, @required this.order, }) : super(key : key);
  @override
  Widget build(BuildContext context) {
    
    List<FoodItem> _foodList = order.foodList;
    List<TabFormField> _tabList = _foodList.map((item) {
      return TabFormField(
        foodItem: item,
      );
    }).toList();
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height:  MediaQuery.of(context).size.height - 170,
            child: ListView(
              children: _tabList,
            ),
          ),
          CurrentTotal(),
          AddOrderButton(
            index: order.index,
            duplicate: order.duplicate,
            mayPop: true,

          )
        ],
      ),
    );
  }
}