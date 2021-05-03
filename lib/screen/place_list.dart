import 'package:camera/providers/great_places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
               future:Provider.of<GreatPlaces>(context,listen:false).fetchAndSetPlaces(),
               builder:(context,snapshot)=>snapshot.connectionState==ConnectionState.waiting?Center(child:CircularProgressIndicator()):
                 Consumer<GreatPlaces>(   
          child:Center(child:Text('nothing to show')),
          builder: (ctx,greatplaces,ch)=> greatplaces.items.length<=0? ch:ListView.builder(itemCount: greatplaces.items.length,itemBuilder: (context,i){
                return ListTile(leading:CircleAvatar(backgroundImage: FileImage( greatplaces.items[i].image ),
                
                
                ),title:Text(greatplaces.items[i].title)                     );
          }  )                              ),
      )
    );
  }
}
