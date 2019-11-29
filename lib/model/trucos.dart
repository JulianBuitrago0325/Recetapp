import 'package:firebase_database/firebase_database.dart';


class Trucos{

String _id;
String _nombre;
String _procedimiento;



Trucos(this._id,this._nombre,this._procedimiento);

Trucos.map(dynamic obj){
  this._id = obj["id"];
  this._nombre = obj["nombre"];
  this._procedimiento = obj["procedimiento"]; 
}

String get id => _id;
String get nombre => _nombre;
String get procedimiento => _procedimiento;

Trucos.fromSnapshot(DataSnapshot snapshot){
    _id = snapshot.key;
    _nombre = snapshot.value['Nombre'];
    _procedimiento = snapshot.value['Procedimiento'];

  }





}