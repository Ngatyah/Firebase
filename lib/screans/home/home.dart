import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/brew.dart';
import 'package:firebase/screans/home/brew_list.dart';
import 'package:firebase/screans/home/setting_form.dart';
import 'package:firebase/services/auth.dart';
import 'package:firebase/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingspanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0 ),
          child: SettingForm() ,
        );

      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[200],
          title: Text('Brew Crew'),
          elevation: 0.0,
          actions: [
            FlatButton.icon(onPressed: ()=>_showSettingspanel(),
                icon: Icon(Icons.settings), label:Text('Settings')),
            FlatButton.icon(
                onPressed: () async {
                  await _authService.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('SignOut'))
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:AssetImage('assets/coffee_bg.png'),
              )
            ),
            child: BrewList()),
      ),
    );
  }
}
