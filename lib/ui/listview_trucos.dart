import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:recetapp/model/trucos.dart';
import 'package:recetapp/ui/trucos_information.dart';
import 'package:recetapp/ui/trucos_screen.dart';

class ListViewTrucos extends StatefulWidget {
  @override
  _ListViewTrucosState createState() => _ListViewTrucosState();
}

final trucosReference = FirebaseDatabase.instance.reference().child('trucos');

class _ListViewTrucosState extends State<ListViewTrucos> {
   List<Trucos> items;
   StreamSubscription<Event> _agregarTrucos;
   StreamSubscription<Event> _editarTrucos;
   @override
  void initState() {
    // TODO: implement initState
    items = new List();
    _agregarTrucos = trucosReference.onChildAdded.listen(_agregarTruco);
    _agregarTrucos = trucosReference.onChildChanged.listen(_editarTruco);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _agregarTrucos.cancel();
    _editarTrucos.cancel();
  }

 @override

  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Trucos',
        home : Scaffold(
          appBar: AppBar(
            title: Text('Trucos'),
            centerTitle: true,
            backgroundColor: Colors.yellow,
          ),
          body: Center(
              child: ListView.builder(itemCount: items.length ,
                padding: EdgeInsets.only(top: 12.0),
                itemBuilder: (context,position){
                  return Column(
                    children: <Widget>[
                      Divider(height: 7.0,),
                      Row(
                        children: <Widget>[
                          Expanded(child: ListTile(title: Text('${items[position].nombre}',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 21.0,
                            ),
                          ),
                            leading: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundColor: Colors.yellow,
                                  radius: 22.0,
                                  child: Icon(
                                    Icons.restaurant_menu,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            onTap: () => _navegarAInformacionTrucos(context, items[position]),)),
                          IconButton(
                              icon: Icon(Icons.delete, color: Colors.red,),
                              onPressed: ()=> _borrarTrucos(context, items[position],position) ),
                          IconButton(
                              icon: Icon(Icons.info, color: Colors.blueAccent,),
                              onPressed: ()=> _navegarATrucos(context, items[position]) ),
                        ],
                      )
                    ],
                  );
                },)
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add,color: Colors.white70,),
            backgroundColor: Colors.black,
            onPressed: () => _crearTruco(context),
          ),
        )
    );
  }
  void _agregarTruco(Event event ){
    setState(() {
      items.add(new Trucos.fromSnapshot(event.snapshot));
    });
  }

  void _editarTruco(Event event ){
    var antiguoTruco = items.singleWhere((trucos) => trucos.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(antiguoTruco)] = new Trucos.fromSnapshot(event.snapshot);
    });
  }

  void _borrarTrucos(BuildContext context, Trucos trucos, int posicion) async{
    await trucosReference.child(trucos.id).remove().then((_){
      setState(() {
        items.removeAt(posicion);
      });
    });

  }

  void _navegarAInformacionTrucos(BuildContext context,Trucos trucos) async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => TrucosScreen(trucos)),
    );
  }

  void _navegarATrucos(BuildContext context,Trucos trucos) async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => TrucosInformation(trucos)),
    );
  }

  void _crearTruco(BuildContext context) async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => TrucosScreen(Trucos(null,'',''))),
    );
  }

}