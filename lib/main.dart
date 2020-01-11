import 'package:demo_app/blocs/bloc_provider.dart';
import 'package:demo_app/blocs/orders_bloc.dart';
import 'package:demo_app/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return BlocProvider(
      bloc: OrderBloc(),
      child: MaterialApp(
        title: 'Custom App Demo',
        debugShowCheckedModeBanner: false,
        color: Colors.blue,
        theme: ThemeData.dark().copyWith(
          accentColor: Colors.purpleAccent,
          splashColor: Colors.white10,
        ),
        home: HomePage(),
      ),
    );
  }
}