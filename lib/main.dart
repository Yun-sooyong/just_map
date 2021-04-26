import 'package:flutter/material.dart';
import 'package:just_map/blocs/application_bloc.dart';
import 'package:just_map/screens/home.dart';
import 'package:just_map/screens/splash_screen.dart';
import 'package:just_map/screens/map_screen.dart';
import 'package:provider/provider.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomeScreen(),
  "/map": (BuildContext context) => MapSample(),
};

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Just Map',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: routes,
        home: SplashScreen(),
      ),
    );
  }

}
