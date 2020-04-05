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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
          title: Text('My Expenses App'),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          margin: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Card(
                color: Color.fromRGBO(0, 204, 255, 0.8),
                child: Container(
                  width: 90,
                  margin: EdgeInsets.all(5),
                  child: Text(
                    'Hello',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                elevation: 7,
              ),
              Card(
                elevation: 5,
                child:Container(
                  margin: EdgeInsets.all(10),
                  child: Column(children: [
                    TextField(decoration: InputDecoration(labelText: 'ID'),onChanged: (val) => id=int.parse(val),),
                    TextField(decoration: InputDecoration(labelText: 'Title'),onChanged: (val) => name=val,),
                    TextField(decoration: InputDecoration(labelText: 'Amount'),onChanged: (val) => age=int.parse(val),),
                    //TextField(decoration: InputDecoration(labelText: 'Date')),
                    RaisedButton(onPressed: () => addItem(id,name,age), child: Text('Add To List')),
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
                                li.id.toString(),
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
                              Text(li.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold)),
                              Text(li.age.toString(),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w500))
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

