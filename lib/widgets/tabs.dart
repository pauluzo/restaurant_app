import 'package:demo_app/blocs/bloc_provider.dart';
import 'package:demo_app/blocs/food_Item_bloc.dart';
import 'package:demo_app/models/meal_model.dart';
import 'package:demo_app/widgets/tabChild_widget.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> _tabNames = ['Main Meal', 'Swallow', 'Soup', 'Side Meal', 'Protein', 'Sauce', 'Drinks'];
    List<Tab> _tabList = List<Tab>();
    for (var i = 0; i < _tabNames.length; i++) {
      _tabList.add(
        Tab(text: _tabNames[i])
      );
    }
    return Container(
      height: 40.0,
      width: 400,
      child: TabBar(
        indicatorColor: Colors.purpleAccent,
        unselectedLabelColor: Colors.grey,
        isScrollable: true,
        tabs: _tabList,
      ),
    );
  }
}

class TabViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FoodItemBloc _foodItemBloc = BlocProvider.of<FoodItemBloc>(context);
    Stream<List<FoodItem>> _mainMealStream = _foodItemBloc.outMainMeal;
    List<Stream<List<FoodItem>>> _streamList =  [_foodItemBloc.outSwallow, _foodItemBloc.outSoup, _foodItemBloc.outSideMeal,
    _foodItemBloc.outProtein, _foodItemBloc.outSauce, _foodItemBloc.outDrinks];
    List<Widget> _tabViewList = List<Widget>();
    _tabViewList.add(
      TabChildDuplicate(
        stream: _mainMealStream,
      )
    );
    _streamList.forEach((item) {
      _tabViewList.add(
        TabChildWidget(
          stream: item,
        )
      );
    });
    return Container(
      child: TabBarView(
        children: _tabViewList,
      ),
    );
  }
}