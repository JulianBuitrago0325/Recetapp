import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:recetapp/model/recetas.dart';
import 'package:recetapp/ui/recetas_information.dart';
import 'package:recetapp/ui/recetas_screen.dart';

class ListViewRecetas extends StatefulWidget {
  @override
  _ListViewRecetasState createState() => _ListViewRecetasState();
}

final recetasReference = FirebaseDatabase.instance.reference().child('recetas');

class _ListViewRecetasState extends State<ListViewRecetas> {
   List<Recetas> items;
   StreamSubscription<Event> _agregarRecetas;
   StreamSubscription<Event> _editarRecetas;
   @override
  void initState() {
    // TODO: implement initState
    items = new List();
    _agregarRecetas = recetasReference.onChildAdded.listen(_agregarReceta);
    _agregarRecetas = recetasReference.onChildChanged.listen(_editarReceta);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _agregarRecetas.cancel();
    _editarRecetas.cancel();
  }

 @override

  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Recetas',
        home : Scaffold(
          appBar: AppBar(
            title: Text('Recetas'),
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
                                    Icons.local_pizza,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                            onTap: () => _navegarAInformacionRecetas(context, items[position]),)),
                          IconButton(
                              icon: Icon(Icons.delete, color: Colors.red,),
                              onPressed: ()=> _borrarRecetas(context, items[position],position) ),
                          IconButton(
                              icon: Icon(Icons.info, color: Colors.blueAccent,),
                              onPressed: ()=> _navegarARecetas(context, items[position]) ),
                        ],
                      )
                    ],
                  );
                },)
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add,color: Colors.white,),
            backgroundColor: Colors.black,
            onPressed: () => _crearReceta(context),
          ),
        )
    );
  }
  void _agregarReceta(Event event ){
    setState(() {
      items.add(new Recetas.fromSnapshot(event.snapshot));
    });
  }

  void _editarReceta(Event event ){
    var antiguoReceta = items.singleWhere((recetas) => recetas.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(antiguoReceta)] = new Recetas.fromSnapshot(event.snapshot);
    });
  }

  void _borrarRecetas(BuildContext context, Recetas recetas, int posicion) async{
    await recetasReference.child(recetas.id).remove().then((_){
      setState(() {
        items.removeAt(posicion);
      });
    });

  }

  void _navegarAInformacionRecetas(BuildContext context,Recetas recetas) async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => RecetasScreen(recetas)),
    );
  }

  void _navegarARecetas(BuildContext context,Recetas recetas) async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => RecetasInformation(recetas)),
    );
  }

  void _crearReceta(BuildContext context) async{
    await Navigator.push(context,
      MaterialPageRoute(builder: (context) => RecetasScreen(Recetas(null,'',List().toList(),''))),
    );
  }

}
