import 'package:demo_app/blocs/bloc_provider.dart';
import 'package:demo_app/blocs/orders_bloc.dart';
import 'package:flutter/material.dart';

class CurrentTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OrderBloc _orderBloc = BlocProvider.of<OrderBloc>(context);
    return StreamBuilder<int>(
      stream: _orderBloc.outCurrentTotal,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          height: 30.0,
          padding: EdgeInsets.symmetric(horizontal: 50.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(child: Text('Total : ', style: TextStyle(fontSize: 20.0),)),
                (snapshot.data == null)
                ?  Container(child: Text('\u{20A6}  0', style: TextStyle(fontSize: 20.0),))
                :  Container(child: Text('\u{20A6} ${snapshot.data}', style: TextStyle(fontSize: 20.0),)),
              ],
            ),
          ),
        );
      },
    );
  }
}