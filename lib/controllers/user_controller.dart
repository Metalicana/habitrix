import 'package:firebase_auth/firebase_auth.dart';
import 'package:habitrix/models/habitrix_user.dart';

class UserController{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user

  HabitrixUser? _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? HabitrixUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<HabitrixUser?> getUser() {
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      //print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future register(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      //print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      //print(error.toString());
      return null;
    }
  }
}