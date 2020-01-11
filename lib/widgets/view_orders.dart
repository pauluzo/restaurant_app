import 'package:demo_app/blocs/bloc_provider.dart';
import 'package:demo_app/blocs/orders_bloc.dart';
import 'package:demo_app/models/orders_model.dart';
import 'package:demo_app/pages/orders.dart';
import 'package:flutter/material.dart';

class ViewOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OrderBloc _orderBloc = BlocProvider.of<OrderBloc>(context);
    return Container(
      constraints: BoxConstraints(
        maxHeight: 30.0,
        maxWidth: 70.0,
      ),
      child: RaisedButton(
        color: Colors.deepPurple,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => OrdersPage(),
          ));
        },
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Icon(Icons.shopping_cart, size: 30.0,),
            Positioned(
              top: 2,
              right: 1,
              child: Material(
                elevation: 2.0,
                type: MaterialType.canvas,
                color: Colors.redAccent,
                child: StreamBuilder<List<Order>>(
                  stream: _orderBloc.outOrderList,
                  initialData: [],
                  builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
                    return Text(
                      snapshot.data.length.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}