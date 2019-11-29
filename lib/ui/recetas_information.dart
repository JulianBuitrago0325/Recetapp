import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:recetapp/model/recetas.dart';

class RecetasInformation extends StatefulWidget {
  final Recetas recetas;
  RecetasInformation(this.recetas);
  @override
  _RecetasInformationState createState() => _RecetasInformationState();
}

final recetasReference = FirebaseDatabase.instance.reference().child('recetas');

class _RecetasInformationState extends State<RecetasInformation> {

  List<Recetas> items;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información sobre las recetas'),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        height: 400.0,
        padding: const EdgeInsets.all(20.0),
        child:  Card(
          child: Center(
            child: Column(
              children: <Widget>[
                new Text("${widget.recetas.nombre}", style: TextStyle(fontSize: 22.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Ingredientes: ${widget.recetas.ingredientes}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                new Text("Procedimiento: ${widget.recetas.procedimiento}", style: TextStyle(fontSize: 18.0),),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider()               
              ],
            ),
          ),
        ),
      ),
    );

  }
}