import 'package:demo_app/blocs/bloc_provider.dart';
import 'package:demo_app/blocs/orders_bloc.dart';
import 'package:demo_app/models/orders_model.dart';
import 'package:demo_app/pages/home.dart';
import 'package:demo_app/widgets/order_container.dart';
import 'package:demo_app/widgets/order_total.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    OrderBloc _orderBloc = BlocProvider.of<OrderBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders', style: TextStyle(fontSize: 20.0,),),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage('assets/images/orders_bg.jpg'),
            fit: BoxFit.cover,
          )
        ),
        width: width,
        height: height,
        constraints: BoxConstraints(
          maxWidth: width,
          minWidth: width - 50,
          maxHeight: height,
          minHeight: height,
        ),
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<List<Order>>(
                  stream: _orderBloc.outOrderList,
                  builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
                    List<Order> _ordersList = snapshot.data;
                    List<OrderContainer> _orderContainers = <OrderContainer>[];
                    if(_ordersList != null && _ordersList.isNotEmpty) {
                      for (var i = 0; i < _ordersList.length; i++) {
                        _orderContainers.add(OrderContainer(orderData: _ordersList[i], index: i,));
                      }
                    }
                    return (_ordersList == null || _ordersList.isEmpty)
                    ? Text('There are no orders yet', style: TextStyle(fontSize: 20.0),)
                    :  Container(
                      constraints: BoxConstraints(
                        minHeight: height / 4,
                        maxHeight: height / 2,
                      ),
                      padding: EdgeInsets.all(5.0),
                      width: width,
                      child: ListView(
                        children: _orderContainers,
                      ),
                    );
                  },
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.deepPurpleAccent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: FlatButton(
                      splashColor: Colors.white10,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context, 
                          MaterialPageRoute(
                            builder: (BuildContext context) => HomePage()
                          ), 
                          ModalRoute.withName('HomePage')
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.add, color: Colors.blue,),
                            Text('Add Order', style: TextStyle(fontSize: 16.0, color: Colors.blue[500]),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                OrderTotal(),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.deepPurple, 
                    border: Border.all(),
                  ),
                  child: FlatButton(
                    child: Text('PAY FOR ORDERS', style: TextStyle(fontSize: 20.0,),),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}