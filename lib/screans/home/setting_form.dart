import 'package:firebase/models/user.dart';
import 'package:firebase/services/database.dart';
import 'package:firebase/shared/constants.dart';
import 'package:firebase/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // ignore: missing_return, missing_return
            UserData userData = snapshot.data;
            return Form(
                key: _formkey,
                child: Column(
                  children: [
                    Text(
                      'Update your Brew Settings',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: userData.name,
                      decoration: textInputDecoration,
                      validator: (val) =>
                          val.isEmpty ? 'please Enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    //dropBox
                    DropdownButtonFormField(
                        value: _currentSugar ?? userData.sugar,
                        items: sugars.map((sugar) {
                          return DropdownMenuItem(
                            value: sugar,
                            child: Text('$sugar sugars'),
                          );
                        }).toList(),
                        onChanged: (e) => setState(() => _currentSugar = e)),
                    //slider
                    Slider(
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      activeColor: Colors.brown[userData.strength],
                      inactiveColor: Colors.brown[userData.strength],
                      onChanged: (e) =>
                          setState(() => _currentStrength = e.round()),
                    ),

                    RaisedButton(
                      color: Colors.teal,
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugar ?? userData.sugar,
                              _currentName ?? userData.name,
                              _currentStrength ?? userData.strength);
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                ));
          } else {
            return Loading();
          }
        });
  }
}
