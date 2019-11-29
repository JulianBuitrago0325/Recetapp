import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:recetapp/model/recetas.dart';


class RecetasScreen extends StatefulWidget {
  final Recetas recetas;
  RecetasScreen(this.recetas);

  @override
  _RecetasScreenState createState() => _RecetasScreenState();
}

final recetasReference = FirebaseDatabase.instance.reference().child('recetas');

class _RecetasScreenState extends State<RecetasScreen> {
List<Recetas> items;
TextEditingController _nombreController;
//Ingredientes _ingredientesController;
TextEditingController _ingredientesController;
TextEditingController _procedimientoController;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nombreController = new TextEditingController(text: widget.recetas.nombre);
    _ingredientesController = new TextEditingController(text: widget.recetas.ingredientes.toString());
    _procedimientoController = new TextEditingController(text: widget.recetas.procedimiento);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Base Recetas'),
        backgroundColor: Colors.yellow,
      ),
      body: ListView(children: <Widget>[
        Container(
        height: 570.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                Card(
                  child:TextField(
                  controller: _nombreController,
                  style: TextStyle(
                      fontSize: 17.0 ,
                      color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon:  Icon(Icons.fastfood),
                      labelText: 'Nombre:'),
                ),),     
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Divider(),
                Card(child:
                TextField(
                  controller: _ingredientesController,
                  inputFormatters: List(),
                  style: TextStyle(
                      fontSize: 17.0 ,
                      color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon:  Icon(Icons.local_grocery_store),
                      labelText: 'Ingredientes:'),
                ) ),
                Divider(),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                Card(child:
                TextField(
                  controller: _procedimientoController,
                  style: TextStyle(
                      fontSize: 17.0 ,
                      color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon:  Icon(Icons.format_list_numbered),
                      labelText: 'Procedimiento:'),
                ), ),                       
                FlatButton(
                  
                  color: Colors.yellow,
                  onPressed: (){
                  if(widget.recetas.id != null){
                    recetasReference.child(widget.recetas.id).set({
                      'Nombre' : _nombreController.text,
                      'Ingredientes' : _ingredientesController.text,
                      'Procedimiento' : _procedimientoController.text,
                    }).then((_){
                      Navigator.pop(context);
                    });
                  }else{
                    recetasReference.push().set({
                      'Nombre' : _nombreController.text,
                      'Ingredientes' : _ingredientesController.text,
                      'Procedimiento' : _procedimientoController.text
                    }).then((_){
                      Navigator.pop(context);
                    });
                  }
                },
                    child: (widget.recetas.id != null) ? Text('Actualizar'): Text('Agregar')),
              ],
            ),
          ),
        ),
      ),   
      ],)     
    );
  }
}