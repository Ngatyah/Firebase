import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/brew.dart';
import 'package:firebase/screans/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {


    final brew = Provider.of<List<Brew>>(context) ??[];




    return ListView.builder(
      itemCount: brew.length,
        itemBuilder: (context, index){
        return BrewTile(br: brew[index]);

    });
  }
}
