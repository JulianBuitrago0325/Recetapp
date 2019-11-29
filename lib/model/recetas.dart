import 'package:firebase_database/firebase_database.dart';


class Recetas{

String _id;
String _nombre;
dynamic _ingredientes = new List<String>();
String _procedimiento;



Recetas(this._id,this._nombre,this._ingredientes,this._procedimiento);

Recetas.map(dynamic obj){
  this._id = obj["id"];
  this._nombre = obj["nombre"];
  this._ingredientes = obj["ingredientes"];
  this._procedimiento = obj["procedimiento"]; 
}

String get id => _id;
String get nombre => _nombre;
dynamic get ingredientes => _ingredientes;
String get procedimiento => _procedimiento;

Recetas.fromSnapshot(DataSnapshot snapshot){
    _id = snapshot.key;
    _nombre = snapshot.value['Nombre'];
    _ingredientes = snapshot.value['Ingredientes'];
    _procedimiento = snapshot.value['Procedimiento'];

  }





}