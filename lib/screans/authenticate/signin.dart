import 'package:firebase/screans/home/home.dart';
import 'package:firebase/services/auth.dart';
import 'package:firebase/shared/constants.dart';
import 'package:firebase/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final  Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool loading = false;
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email;
  String password;
  String error='';
  @override
  Widget build(BuildContext context) {



    return  loading ? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Sign In to BrewScrew'),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.brown[400],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  validator: (val)=> val.isEmpty ? 'Enter Email': null,

                  onChanged: (val) {
                    setState(() {
                      return email=val;
                    });
                  },
                  decoration: textInputDecoration.copyWith(hintText: 'password'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (val)=> val.length <6 ?'Enter Your password 6 + Char Long': null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(()=>password=val);
                  },
                  decoration: textInputDecoration.copyWith(hintText: 'password'),
                ),
                SizedBox(height: 20,),

                RaisedButton(
                  color: Colors.teal[500],
                  onPressed:()async{

                    {
                      if (_formkey.currentState.validate()) {
                        setState(()=> loading=true);
                        dynamic result = await _auth.signInWithEmailandPassword(
                            email, password);

                    if(result== null) {
                      setState(() =>error ='Check Your Cridentials');
                      loading= false;
                    }
                    else{
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));

                    }


                    }
                    }

                  } ,
                  child: Text(' SignIn',
                  style: TextStyle(color: Colors.white),),

                ),
                SizedBox(height: 20,),

                Row(
                  children: [
                    Text('Don\'t have an Account? '),
                    GestureDetector(
                      onTap:(){
                        widget.toggleView();
                        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Register()));
                      } ,
                      child: Text('Register',
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
          )),
    );
  }
}
