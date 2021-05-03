import 'package:camera/providers/great_places.dart';
import 'package:camera/screen/add_place.dart';
import 'package:camera/screen/place_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
           value:GreatPlaces(),
          child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesListScreen(),

        routes:{
             '/add-place':(context)=>AddPlaceScreen()
        }
      
      ),
    );
  }
}
