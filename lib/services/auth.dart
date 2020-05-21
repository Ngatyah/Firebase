import 'package:firebase/models/user.dart';
import 'package:firebase/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{



  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebadeuser(FirebaseUser user){
    return user != null ? User(uid: user.uid):null;
  }
  //auth change user stream

  Stream <User> get user {
     return _auth.onAuthStateChanged.
    //map((FirebaseUser user)=> _userFromFirebadeuser(user))
    map(_userFromFirebadeuser);
  }
  //signin anonymous

Future signInanon() async{

try {
  AuthResult authResult = await _auth.signInAnonymously();
  FirebaseUser user = authResult.user;
  return _userFromFirebadeuser(user);
}catch(e){
  print(e.toString());
  return null;
}

}

  // singin with Email
  Future signInWithEmailandPassword(String email, String password) async{
    try{
      AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = authResult.user;


       return _userFromFirebadeuser(user);

    }catch(e){

    }
  }

  // register with email

Future registerWihEmailandPassword(String email, String password) async{

    try{
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = authResult.user;
      await DatabaseService(uid:user.uid).updateUserData('0', 'Tinga Star', 100);
      return _userFromFirebadeuser(user);

    }catch(e){
      print(e.toString());
      return null;

    }

  }
  // sign out
Future signOut() async{
    try {
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
}
}