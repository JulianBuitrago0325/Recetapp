import 'package:flutter/material.dart';
import 'package:recetapp/ui/first_screen.dart';
import 'package:recetapp/ui/listview_recetas.dart';
import 'package:recetapp/ui/listview_trucos.dart';

import 'chatbot.dart';





class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.yellow[900],
        accentColor: Colors.yellow[700]
      ),
      home: MyHomePage(title: "Recetapp"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _current_index= 0;

  List<Widget> _children =[
    ListViewRecetas(),
    ListViewTrucos(),
    HomePageDialogflow(),
    FirstScreen()
    
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _onTabBar(int index){
    setState(() {
      _current_index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _current_index,
        onTap: _onTabBar,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.kitchen,
            color: Colors.yellow,),
            title: Text('Recetas')
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border,
            color: Colors.yellow,),
            title: Text('KitchenTricks')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message,
            color: Colors.yellow),
            title: Text('ChatBot',)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people,
            color: Colors.yellow),
            title: Text('Usuario',)
          )
        ],
      ),
      body: _children[_current_index], 
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}