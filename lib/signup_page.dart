import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageeState createState() => _SignUpPageeState();
}

class _SignUpPageeState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _confirmedPassword;
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign Up Page Flutter Firebase"),
        ),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  new Container(
                    width: 190.0,
                    height: 190.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/images/dog.png')
                        )
                    )),
                  SizedBox(height: 20.0),
                  TextFormField(
                      onSaved: (value) => _email = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Email Address")),
                  TextFormField(
                      onSaved: (value) => _password = value,
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Password")),
                  TextFormField(
                      onSaved: (value) => _confirmedPassword = value,
                      obscureText: true,
                      decoration: InputDecoration(labelText: "Confirm your password")),   
                  SizedBox(height: 20.0),
                  RaisedButton(
                    child: Text("SIGN UP"),
                    onPressed: () async {
                      final form = _formKey.currentState;
                      form.save();

                      if(_password != _confirmedPassword){
                        return _buildErrorDialog(context, "Senhas não batem");
                      }
                      try {
                        FirebaseUser user = (await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: _email,
                                password: _password,)).user;

                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                      } catch (e) {
                        print(e);
                        return _buildErrorDialog(context, e.toString());
                      }
                    },
                  ),
                ]))));
  }

  Future _buildErrorDialog(BuildContext context, _message) {
    return showDialog(
      builder: (context) {
        return AlertDialog(
          title: Text('Error Message'),
          content: Text(_message),
          actions: <Widget>[
            FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
      },
      context: context,
    );
  }
}