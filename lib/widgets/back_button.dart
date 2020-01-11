import 'package:flutter/material.dart';
import 'package:demo_app/blocs/orders_bloc.dart';
import 'package:demo_app/blocs/bloc_provider.dart';

class DefaultBackButton extends StatelessWidget {
  const DefaultBackButton({ Key key, this.color,}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    OrderBloc _orderBloc = BlocProvider.of<OrderBloc>(context);
    assert(debugCheckHasMaterialLocalizations(context));
    return IconButton(
      icon: const BackButtonIcon(),
      color: color,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        Navigator.maybePop(context);
        _orderBloc.inAddFood.add(null);
      },
    );
  }
}