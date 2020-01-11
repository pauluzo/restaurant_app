import 'package:demo_app/blocs/bloc_provider.dart';
import 'package:demo_app/blocs/food_Item_bloc.dart';
import 'package:demo_app/widgets/add_order.dart';
import 'package:demo_app/widgets/current_total.dart';
import 'package:demo_app/widgets/tabs.dart';
import 'package:demo_app/widgets/view_orders.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double  width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      bloc: FoodItemBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Container(padding: EdgeInsets.only(left: 10), child: Text('OAK RESTAURANT', style: TextStyle(fontSize: 20.0, color: Colors.white54, ),)),
          actions: <Widget>[
            ViewOrder(),
          ],
        ),
        body: Container(
          width: width,
          height: height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 170.0,
                width: width,
                color: Colors.blue,
                child: Image.asset(
                  'assets/images/food_image.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  alignment: Alignment.center,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.0),
                child: DefaultTabController(
                  length: 7,
                  child: Column(
                    children: <Widget>[
                      TabBarWidget(),
                      Container(
                        height: 300.0,
                        constraints: BoxConstraints(
                          minHeight: 240.0,
                          maxHeight: 300.0,
                          maxWidth: 410.0,
                          minWidth: 350.0,
                        ),
                        child: TabViewWidget(),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      CurrentTotal(),
                      AddOrderButton(
                        mayPop: false,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}