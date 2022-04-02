import 'package:flutter/material.dart';
import 'package:habitrix/services/auth.dart';
import 'components/background.dart';
import 'package:habitrix/constants.dart';

class RegisterScreen extends StatefulWidget {

  final Function toggleView;
  RegisterScreen({ required this.toggleView });

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Create a new account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Image.asset(
                "assets/images/achievements _ accomplishment, target, mountain, top, flag, man, people, achievement.png",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 300.0,
                      child: TextFormField(
                        cursorColor: Colors.green,
                        decoration: InputDecoration(
                            hintText: 'example@mail.com',
                            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(color: Colors.lightGreen, width: 2.0),

                            )

                        ),
                        onSaved: (String? value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Container(
                      width: 300.0,
                      child: TextFormField(
                        cursorColor: Colors.green,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'password',
                            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(color: Colors.lightGreenAccent, width: 2.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(color: Colors.lightGreen, width: 2.0),

                            )

                        ),
                        onSaved: (String? value) {},
                        validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Container(
                      width: 300.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),

                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[

                            Positioned.fill(

                              child: Container(
                                decoration: const BoxDecoration(
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical : 10.0, horizontal: 10.0 ),
                                primary: Colors.white,
                                textStyle: const TextStyle(fontSize: 20),

                              ),
                              onPressed: () async{
                                if(_formKey.currentState!.validate()){
                                  setState(() => loading = true);
                                  dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                                  print(result);
                                  if(result == null) {
                                    setState(() {
                                      loading = false;
                                      error = 'Please supply a valid email and password';
                                    });
                                  }
                                }
                              },
                              child: const Text('Register'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: size.height * 0.01),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 14),
                ),
                onPressed: () {
                  widget.toggleView();
                },
                child: const Text(
                  'Already have an account? Login',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


