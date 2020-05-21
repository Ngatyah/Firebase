import 'package:firebase/screans/authenticate/signin.dart';
import 'package:firebase/screans/home/home.dart';
import 'package:firebase/services/auth.dart';
import 'package:firebase/shared/constants.dart';
import 'package:firebase/shared/loading.dart';
import 'package:flutter/material.dart';


class Register extends StatefulWidget {
  final  Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool loading = false;

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email;
  String password;
  String name;
  String error='';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Sign Up to BrewScrew'),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.brown[400],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Container(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    onChanged: (val) {
                      setState(() {
                        return name=val;
                      });
                    },
                    decoration: textInputDecoration.copyWith(hintText: 'name'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (val)=> val.isEmpty ? 'Enter Email': null,
                    onChanged: (val) {
                      setState(() {
                        return email=val;
                      });
                    },
                    decoration: textInputDecoration.copyWith(hintText: 'email'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (val)=> val.length <6 ?'Enter Your Email 6 + Char Long': null,
                    obscureText: true,
                    onChanged: (val) {
                      setState(()=>password=val);
                    },
                    decoration: textInputDecoration.copyWith(hintText: 'password')
                  ),
                  SizedBox(height: 20,),

                  RaisedButton(
                    color: Colors.teal[500],
                    onPressed:()async{
                      if(_formkey.currentState.validate()) {
                        setState(() {
                          loading= true;
                        });
                        dynamic result = await _auth.registerWihEmailandPassword(email, password);

                        if(result== null) {
                          setState(() {
                              error ='Please Check your Email and password';
                              loading= false;
                          });
                        }
                        else {
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                          print('data Saved');

                        }
                      }
                      } ,
                    child: Text('Register',
                      style: TextStyle(color: Colors.white),),

                  ),

                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Text('Already have an Account? '),
                      GestureDetector(
                        onTap:(){
                          widget.toggleView();
                          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
                        } ,
                        child: Text('SignIn',
                          style: TextStyle(
                              decoration: TextDecoration.underline
                          ),),
                      )
                    ],
                  ),
                  SizedBox(height: 40,),

                  Text(error)

                ],
              ),
            ),
          )),
    );
  }
}
