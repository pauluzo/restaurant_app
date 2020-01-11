import 'package:demo_app/models/meal_model.dart';
import 'package:demo_app/widgets/tab_formField.dart';
import 'package:flutter/material.dart';

class UniqueContainer extends StatelessWidget {
  final Stream<List<FoodItem>> inStream;
  final String label;
  UniqueContainer({Key key, @required this.inStream, @required this.label}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 40.0,
            child: Text(label, style: TextStyle(fontSize: 16.0)),
          ),
          Divider(),
          StreamBuilder<List<FoodItem>>(
            stream: inStream,
            builder: (BuildContext context, AsyncSnapshot<List<FoodItem>> snapshot) {
              List<FoodItem> _list = snapshot.data;
              List<TabFormField> _tabList = (_list == null) 
              ? [] 
              : _list.map((item) {
                return TabFormField(
                  foodItem: item,
                );
              }).toList();
              return Container(
                child: Column(
                  children: _tabList,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}