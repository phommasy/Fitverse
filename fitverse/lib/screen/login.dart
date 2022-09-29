import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitverse/screen/homemenu.dart';
import 'package:fitverse/screen/register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../components/curve_cliper.dart';
import '../model/profile.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  Profile profile = Profile();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Material(
                  color: Colors.grey[200],
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.grey[200],
                    child: Column(
                      children: [
                        ClipPath(
                          clipper: CurveCliper(),
                          child: Image(
                            height: MediaQuery.of(context).size.height / 2.5,
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "assets/images/login_background.jpg"),
                          ),
                        ),
                        Text(
                          "Fitverse",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 37,
                              color: Colors.deepOrange,
                              letterSpacing: 4),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Please input your email!"),
                              EmailValidator(
                                  errorText: "Email format not correct!"),
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String email) {
                              profile.email = email;
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(Icons.email),
                                hintText: "Email"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            validator: RequiredValidator(
                                errorText: "Please input email!"),
                            obscureText: true,
                            onSaved: (String password) {
                              profile.password = password;
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(Icons.lock),
                                hintText: "Password"),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 60),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.orange[800],
                            ),
                            child: MaterialButton(
                              height: 50,
                              onPressed: () async {
                                if (formkey.currentState.validate()) {
                                  formkey.currentState.save();
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: profile.email,
                                            password: profile.password)
                                        .then((value) {
                                      formkey.currentState.reset();
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return HomeScreen();
                                      }));
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    String messagealerts;
                                    if (e.code == 'user-not-found') {
                                      messagealerts = "Email not found";
                                    } else if (e.code == 'wrong-password') {
                                      messagealerts = "Incorrect password";
                                    } else {
                                      messagealerts = e.message;
                                    }
                                    // print(e.message);
                                    //print(e.code);
                                    Fluttertoast.showToast(
                                        msg: messagealerts,
                                        gravity: ToastGravity.CENTER);
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.login,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    " Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 19,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Container(
                              height: 80,
                              width: double.infinity,
                              color: Colors.blue,
                              child: ElevatedButton(
                                child: Center(
                                  child: Text(
                                    "Do not have an account",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 23,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  //  Navigator.push(context,
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return RegisterScreen();
                                  }));
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
            // return Scaffold(
            //   appBar: AppBar(
            //     title: Text("Login Form"),
            //   ),
            //   body: Container(
            //     child: Padding(
            //       padding: const EdgeInsets.all(20.0),
            //       child: Form(
            //         key: formkey,
            //         child: SingleChildScrollView(
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text("Email", style: TextStyle(fontSize: 20)),
            //               TextFormField(
            //                 validator: MultiValidator([
            //                   RequiredValidator(
            //                       errorText: "Please input your email!"),
            //                   EmailValidator(
            //                       errorText: "Email format not correct!"),
            //                 ]),
            //                 keyboardType: TextInputType.emailAddress,
            //                 onSaved: (String email) {
            //                   profile.email = email;
            //                 },
            //               ),
            //               SizedBox(
            //                 height: 15,
            //               ),
            //               Text("Password", style: TextStyle(fontSize: 20)),
            //               TextFormField(
            //                 validator: RequiredValidator(
            //                     errorText: "Please input email!"),
            //                 obscureText: true,
            //                 onSaved: (String password) {
            //                   profile.password = password;
            //                 },
            //               ),
            //               SizedBox(
            //                 width: double.infinity,
            //                 child: ElevatedButton(
            //                   child:
            //                       Text("Login", style: TextStyle(fontSize: 20)),
            //                   onPressed: () async {
            //                     if (formkey.currentState.validate()) {
            //                       formkey.currentState.save();
            //                       try {
            //                         await FirebaseAuth.instance
            //                             .signInWithEmailAndPassword(
            //                                 email: profile.email,
            //                                 password: profile.password)
            //                             .then((value) {
            //                           formkey.currentState.reset();
            //                           Navigator.pushReplacement(context,
            //                               MaterialPageRoute(builder: (context) {
            //                             return WelcomeScreen();
            //                           }));
            //                         });
            //                       } on FirebaseAuthException catch (e) {
            //                         String messagealerts;
            //                         if (e.code == 'user-not-found') {
            //                           messagealerts = "Email not found";
            //                         } else if (e.code == 'wrong-password') {
            //                           messagealerts = "Incorrect password";
            //                         } else {
            //                           messagealerts = e.message;
            //                         }
            //                         // print(e.message);
            //                         //print(e.code);
            //                         Fluttertoast.showToast(
            //                             msg: messagealerts,
            //                             gravity: ToastGravity.CENTER);
            //                       }
            //                     }
            //                   },
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
