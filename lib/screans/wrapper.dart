import 'package:firebase/models/user.dart';
import 'package:firebase/screans/authenticate/authenticate.dart';
import 'package:firebase/screans/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      final user = Provider.of<User>(context);

      if (user== null){
        return Auth();
      }
      else{
        return Home();
      }


  }

}




