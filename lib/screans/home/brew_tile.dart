import 'package:firebase/models/brew.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {
  final Brew br;
  BrewTile({this.br});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: GestureDetector(
          child: Card(
            color: Colors.blueGrey,

            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.local_drink,
                  color: Colors.brown[br.strength],
                ),
              ),
              title: Text(br.name,style: TextStyle(color: Colors.white),),
              subtitle: Text('Add ${br.sugar} spoons of sugar',style: TextStyle(color: Colors.white),),
            ),
          ),
        )
    );
  }
}
