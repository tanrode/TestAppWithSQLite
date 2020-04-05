import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import './dog.dart';
import './dbHelper.dart';

void main() async 
{
  runApp(DogList()); 
}

class DogList extends StatefulWidget {
  @override
  _DogListState createState() => _DogListState();
}

class _DogListState extends State<DogList> {
  
  DBhelper db = DBhelper();
  List<Dog> items;
  int id;
  String name;
  int age;
  int start=0;

  void addItem(int id,String name,int age) async
  {
    await db.insertDog(Dog(id: id,name: name,age: age));
    items = await db.dogs();
    setState(() {
      start=1;  
    });
  }

  void removeItem(int id) async
  {
    await db.deleteDog(id);
    items = await db.dogs();
    setState(() {  
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
          title: Text('Registration Portal'),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 5,
                child:Container(
                  margin: EdgeInsets.all(10),
                  child: Column(children: [
                    TextField(decoration: InputDecoration(labelText: 'ID'),onChanged: (val) => id=int.parse(val),),
                    TextField(decoration: InputDecoration(labelText: 'Name'),onChanged: (val) => name=val,),
                    TextField(decoration: InputDecoration(labelText: 'Age'),onChanged: (val) => age=int.parse(val),),
                    //TextField(decoration: InputDecoration(labelText: 'Date')),
                    RaisedButton(onPressed: () => addItem(id,name,age), child: Text('Add To List')),
                    RaisedButton(onPressed: () => removeItem(id), child: Text('Delete Entry')),
                  ],),
                ),
              ),
              start == 1 ?
              Column(
                  children: items.map((li) {
                return Card(
                  color: Color.fromRGBO(0, 255, 153, 0.8),
                  child: Container(
                    width: 300,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(5),
                          //color: Color.fromRGBO(255, 204, 204, 1),
                          decoration: BoxDecoration(
                              border: Border.all(
                              width: 2,
                              color: Colors.black,
                            ),
                            color: Color.fromRGBO(255, 204, 204, 1),
                          ),
                          child: Text(
                                'ID: '+li.id.toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        padding: EdgeInsets.fromLTRB(2, 1, 2, 1), 
                        ),
                        Container(
                          width: 180,
                          child: Column(
                            children: <Widget>[
                              Text('Name: '+li.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold)),
                              Text('Age: '+li.age.toString(),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.w500))
                            ],
                          crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                        ),
                      ],
                      //mainAxisAlignment: MainAxisAlignment.center,
                    ),
                    margin: EdgeInsets.all(5),
                  ),
                  elevation: 5,
                );
              }).toList()): Text(''),
            ],
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      ),
    );
  }
}

