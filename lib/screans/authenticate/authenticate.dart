import 'package:firebase/screans/authenticate/register.dart';
import 'package:firebase/screans/authenticate/signin.dart';
import 'package:flutter/material.dart';
class Auth extends StatefulWidget {


  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
bool showsignIn = true;

void toggleView(){
  setState(() => showsignIn= !showsignIn);


}

  @override
  Widget build(BuildContext context) {
    if (showsignIn){
      return SignIn(toggleView: toggleView);
    }
    else{
      return Register(toggleView: toggleView);
    }
  }
}
