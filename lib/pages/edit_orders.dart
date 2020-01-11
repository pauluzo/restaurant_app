import 'package:demo_app/models/orders_model.dart';
import 'package:demo_app/widgets/back_button.dart';
import 'package:demo_app/widgets/edit_order_widget.dart';
import 'package:flutter/material.dart';

class EditOrder extends StatelessWidget {
  final Order order;
  EditOrder({Key key, @required this.order}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Container(
          padding: EdgeInsets.all(5.0),
          child: DefaultBackButton(),
        ),
        title: Text('Edit Order ${order.index + 1}', style: TextStyle(fontSize: 20.0),),
      ),
      body: EditOrderWidget(order: order,)
    );
  }
}