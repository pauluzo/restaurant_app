import 'package:flutter/material.dart';
import 'package:demo_app/models/meal_model.dart';
import 'package:demo_app/widgets/tab_formField.dart';

// This is the widget that would be returned to the TabView widget of each TabBar (on any of the pages requiring forms).
// The required environment should be provided. i.e the Form, TabController and then the TabBar. 

class TabChildWidget extends StatelessWidget {
  final Stream<List<FoodItem>> stream;
  TabChildWidget({Key key, @required this.stream}) : super(key : key);
  
  @override
  Widget build(BuildContext context) {
    List<Widget> tabList;
    return StreamBuilder(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<List<FoodItem>> snapshot) {
        tabList =  (snapshot.data != null) 
        ? snapshot.data.map((item) {
          return TabFormField(
            foodItem: item,
          );
        }).toList()
        : [
          Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ];
        return Container(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            scrollDirection: Axis.vertical,       
            children: tabList,
          ),
        );
      },
    );
  }
}

// This class will be called on, with stream from the FoodList.mainMeal constructor
// on the main page, to navigate to the page where extras/toppings can be added to the main meal.
class TabChildDuplicate extends StatelessWidget {
final Stream<List<FoodItem>> stream;
  TabChildDuplicate({Key key, @required this.stream}) : super(key : key);
  
  @override
  Widget build(BuildContext context) {
    List<Widget> tabList;
    return StreamBuilder<List<FoodItem>>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<List<FoodItem>> snapshot) {
        tabList = (snapshot.data != null) 
        ? snapshot.data.map((item) {
          return PseudoTabForm(
            foodItem: item,
          );
        }).toList()
        : [
          Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ];
        return Container(
          child: ListView(       
            children: tabList,
          ),
        );
      },
    );
  }
}