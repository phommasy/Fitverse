import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitverse/components/dialogbox.dart';
import 'package:fitverse/components/snacbarbox.dart';
import 'package:flutter/material.dart';

class ForgotPwPage extends StatefulWidget {
  ForgotPwPage({Key key}) : super(key: key);

  @override
  _ForgotPwPageState createState() => _ForgotPwPageState();
}

class _ForgotPwPageState extends State<ForgotPwPage> {
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var emailCtrl = TextEditingController();
  String _email;

  void handleSubmit() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      resetPassword(_email);
    }
  }

  Future<void> resetPassword(String email) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.sendPasswordResetEmail(email: email);
      openDialog(context, 'Reset Password',
          'An email has been sent to $email. \n\nGo to that link & reset your password.');
    } catch (error) {
      openSnacbar(scaffoldKey, error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                child: IconButton(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.keyboard_backspace),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              Text('reset your password',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
              Text('Reset by email address',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey)),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: 'username@mail.com', labelText: 'Email Address'
                    //suffixIcon: IconButton(icon: Icon(Icons.email), onPressed: (){}),

                    ),
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                validator: (String value) {
                  if (value.length == 0) return "Email can't be empty";
                  return null;
                },
                onChanged: (String value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              SizedBox(
                height: 80,
              ),
              Container(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Theme.of(context).primaryColor)),
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onPressed: () {
                      handleSubmit();
                    }),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
