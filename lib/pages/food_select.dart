import 'package:demo_app/blocs/bloc_provider.dart';
import 'package:demo_app/blocs/extras_bloc.dart';
import 'package:demo_app/blocs/food_Item_bloc.dart';
import 'package:demo_app/models/meal_model.dart';
import 'package:demo_app/widgets/add_order.dart';
import 'package:demo_app/widgets/back_button.dart';
import 'package:demo_app/widgets/current_total.dart';
import 'package:demo_app/widgets/tab_formField.dart';
import 'package:demo_app/widgets/unique_container.dart';
import 'package:flutter/material.dart';

class FoodItemProvider extends StatelessWidget {
  final FoodItem foodItem;
  FoodItemProvider({Key key, @required this.foodItem}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: FoodItemBloc(),
      child: FoodSelect(
        foodItem: foodItem,
      ),
    );
  }
}

class FoodSelect extends StatelessWidget {
  final FoodItem foodItem;
  FoodSelect({Key key, @required this.foodItem}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    FoodItemBloc _foodItemBloc = BlocProvider.of<FoodItemBloc>(context);
    final List<List<dynamic>> _foodItemList = [[_foodItemBloc.outProtein, 'Choose your protein'],
    [_foodItemBloc.outDrinks, 'Choose your drink']];
    List<UniqueContainer> _uniqueList = _foodItemList.map((List item) {
      return UniqueContainer(
        inStream: item[0],
        label: item[1],
      );
    }).toList();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Container(
          padding: EdgeInsets.all(5.0),
          child: DefaultBackButton(),
        ),
        title: Text(foodItem.foodName),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: height - 160,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 200.0,
                    color: Colors.blueAccent,
                    child: Center(
                      child: Image.asset(
                        'assets/images/food_image.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 30.0,
                          child: Center(child: Text('Select Extra Portion(s)', style: TextStyle(fontSize: 16.0),)),
                        ),
                        Divider(),
                        TabFormField(
                          foodItem: foodItem,
                        ),
                      ],
                    ),
                  ),
                  BlocProvider(
                    bloc: ExtrasBloc(this.foodItem),
                    child: Builder(
                      builder: (BuildContext context1) {
                        ExtrasBloc _extraBloc = BlocProvider.of<ExtrasBloc>(context1);
                        return StreamBuilder<List<FoodItem>>(
                          stream: _extraBloc.outFoodExtras,
                          builder: (BuildContext context, AsyncSnapshot<List<FoodItem>> snapshot) {
                            List<TabFormField> _tabList = (snapshot.data == null) 
                            ? [] : snapshot.data.map((item) {
                              return TabFormField(
                                foodItem: item,
                              );
                            }).toList();
                            return Column(
                              children: <Widget>[
                                Container(
                                  height: 30.0,
                                  child: Text('Select Your Topping', style: TextStyle(fontSize: 16.0)),
                                ),
                                Divider(),
                                Column(
                                  children: _tabList,
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Column(
                    children: _uniqueList,
                  ),
                ],
              ),
          ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                CurrentTotal(),
                AddOrderButton(
                  mayPop: true,
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}