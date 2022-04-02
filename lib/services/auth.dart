import 'package:habitrix/models/habitrixUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:habitrix/models/task.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user

  HabitrixUser? _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? HabitrixUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<HabitrixUser?> get user {
    return _auth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Stream<List<Task>> get tasks
  {
    DateTime date = DateTime(1999);
    Task a = Task(taskId: '1202', taskName: 'Hello', deadline: date, importance: 5 ,difficulty:  5);
    Task b = Task(taskId: '21', taskName: 'Hello', deadline: date, importance: 5 ,difficulty:  5);
    Task c = Task(taskId: '413', taskName: 'Hello', deadline: date, importance: 5 ,difficulty:  5);
    Stream<List<Task>> ok = [a,b,c] as Stream<List<Task>>;
    return ok;
  }

}
