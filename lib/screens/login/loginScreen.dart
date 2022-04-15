import 'package:flutter/material.dart';
import 'package:habitrix/services/auth.dart';
import '../loading.dart';
import 'components/background.dart';
import 'package:habitrix/constants.dart';



class LoginScreen extends StatefulWidget {
  final Function toggleView;
  LoginScreen({ required this.toggleView });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  String error = '';

  bool loading = false;

  // text field state
  String email = '';

  String password = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading? Loading() : Scaffold(
        body: Background(

          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Login to Habitrix",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Image.asset(
                  "assets/images/business _ graph, chart, analytics, statistics, presentation, project, woman, people.png",
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
                          onChanged: (val) {
                              setState(() => email = val);
                            },
                          onSaved: (String? value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                          validator: (val) => val!.isEmpty ? 'Enter an email' : val.contains('@') ? null : 'Enter a valid email',
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
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          onSaved: (String? value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                          validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
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
                                onPressed: () async {
                                  if(_formKey.currentState!.validate()){
                                    setState(() => loading = true);
                                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                                    if(result == null) {
                                      setState(() {
                                        loading = false;
                                        error = 'bad auth';

                                      });
                                    }
                                  }
                                },
                                child: Container(
                                    width: 300.0,
                                    height: 30.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: kPrimaryColor,

                                    ),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0
                                      ),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                )
                ,
                SizedBox(height: size.height * 0.01),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  onPressed: () {
                    widget.toggleView();
                  },
                  child: const Text(
                    'Don\'t have an account? Register',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
                Container(
                  child: error == '' ? Container() : ErrorScreen()
                )

              ],
            ),
          ),
        ),
    );
  }
}

class ErrorScreen extends StatelessWidget {


  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        'Incorrect credentials. please try again',
        style: TextStyle(
          color: Colors.red[500]
        ),
      ),
    );
    // Size size = MediaQuery
    //     .of(context)
    //     .size;
    // return Scaffold(
    //   body: Background(
    //
    //     child: SingleChildScrollView(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           TextButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //             child: Text(
    //               "Incorrect credentials. Try again?",
    //               style: TextStyle(
    //                 fontWeight: FontWeight.bold,
    //                 color: kPrimaryColor,
    //                 fontSize: 20,
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: size.height * 0.03),
    //           Image.asset(
    //             "assets/images/settings, maintenance _ options, preferences, configuration, man, repair, fix, people@2x.png",
    //             height: size.height * 0.35,
    //           ),
    //           SizedBox(height: size.height * 0.03),
    //
    //
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
