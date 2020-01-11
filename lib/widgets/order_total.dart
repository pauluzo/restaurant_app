import 'package:demo_app/blocs/bloc_provider.dart';
import 'package:demo_app/blocs/orders_bloc.dart';
import 'package:flutter/material.dart';

class OrderTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OrderBloc _orderBloc = BlocProvider.of<OrderBloc>(context);

    return Container(
      constraints: BoxConstraints(
        maxHeight: 60.0,
        minHeight: 30.0,
        minWidth: 100.0,
        maxWidth: 150.0,
      ),
      child: StreamBuilder<int>(
        stream: _orderBloc.outOrdersTotal,
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Total : ', style: TextStyle(fontSize: 17.0),),
                Text('\u{20A6} ${snapshot.data.toString()}', style: TextStyle(fontSize: 17.0),),
              ],
            )
          );
        },
      ),
    );
  }
}