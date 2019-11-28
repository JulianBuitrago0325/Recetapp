import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:recetapp/model/trucos.dart';

class TrucosInformation extends StatefulWidget {
  final Trucos trucos;
  TrucosInformation(this.trucos);
  @override
  _TrucosInformationState createState() => _TrucosInformationState();
}

final trucosReference = FirebaseDatabase.instance.reference().child('trucos');

class _TrucosInformationState extends State<TrucosInformation> {

  List<Trucos> items;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trucos en la Cocina '),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        height: 400.0,
        padding: const EdgeInsets.all(20.0),
        child:  Card(
          child: Center(
            child: Column(
              children: <Widget>[
                
                new Text("${widget.trucos.nombre}", 
                style: TextStyle(fontSize: 21.2),
                textAlign: TextAlign.center,                            
                ),
                Padding(padding: EdgeInsets.only(top: 8.0),),
                new Text("${widget.trucos.procedimiento}", 
                style: TextStyle(fontSize: 17.1),
                textAlign: TextAlign.center, 

                ),
                Padding(padding: EdgeInsets.only(top: 8.0),),            
              ],
            ),
          ),
        ),
      ),
    );

  }
}
