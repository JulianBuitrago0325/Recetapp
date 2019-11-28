import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:recetapp/model/trucos.dart';


class TrucosScreen extends StatefulWidget {
  final Trucos trucos;
  TrucosScreen(this.trucos);

  @override
  _TrucosScreenState createState() => _TrucosScreenState();
}

final trucosReference = FirebaseDatabase.instance.reference().child('trucos');

class _TrucosScreenState extends State<TrucosScreen> {
List<Trucos> items;
TextEditingController _nombreController;
TextEditingController _procedimientoController;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nombreController = new TextEditingController(text: widget.trucos.nombre);
    _procedimientoController = new TextEditingController(text: widget.trucos.procedimiento);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Trucos de Cocina'),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        height: 570.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                Card( 
                  child : TextField(
                  controller: _nombreController,
                  style: TextStyle(
                      fontSize: 17.0 ,
                      color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon:  Icon(Icons.star),
                      labelText: 'Nombre:'),
                ),),
                
                Padding(padding: EdgeInsets.only(top: 10.0),),
                Divider(),
                Card(
                  child: TextField(
                  controller: _procedimientoController,
                  style: TextStyle(
                      fontSize: 17.0 ,
                      color: Colors.deepOrangeAccent),
                  decoration: InputDecoration(icon:  Icon(Icons.restaurant),
                      labelText: 'Procedimiento:'),
                ),),                       
                FlatButton(
                  color: Colors.yellow,               
                  onPressed: (){
                  if(widget.trucos.id != null){
                    trucosReference.child(widget.trucos.id).set({
                      'Nombre' : _nombreController.text,
                      'Procedimiento' : _procedimientoController.text,
                    }).then((_){
                      Navigator.pop(context);
                    });
                  }else{
                    trucosReference.push().set({
                      'Nombre' : _nombreController.text,
                      'Procedimiento' : _procedimientoController.text
                    }).then((_){
                      Navigator.pop(context);
                    });
                  }
                },
                    child: (widget.trucos.id != null) ? Text('Actualizar'): Text('Agregar')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}