import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth.dart';
import 'signup_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String _password;
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Page"),
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
                  SizedBox(height: 20.0),

                  SizedBox(
                    width: 300,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text("LOGIN"),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () async {
                        // save the fields..
                        final form = _formKey.currentState;
                        form.save();

                        // Validate will return true if is valid, or false if invalid.
                        if (form.validate()) {
                          try {
                            FirebaseUser result =
                                await Provider.of<AuthService>(context).loginUser(
                                    email: _email, password: _password);
                            print(result);
                              Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage(result)),
                        );
                          } on AuthException catch (error) {
                            return _buildErrorDialog(context, error.message);
                          } on Exception catch (error) {
                            return _buildErrorDialog(context, error.toString());
                          }
                        }
                      },
                    )
                  ),

                  Divider(
                    color: Colors.black,
                    height: 50,
                    indent: 30,
                    endIndent: 30
                  ),

                  FutureBuilder(
                    future: googleSignIn.isSignedIn(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                          return SignInButton(
                              Buttons.Google,
                              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                              onPressed: () async {
                                final GoogleSignInAccount googleUser = await googleSignIn.signIn();
                                final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
                              final AuthCredential credential = GoogleAuthProvider.getCredential(
                                  accessToken: googleAuth.accessToken,
                                  idToken: googleAuth.idToken
                              );
                            FirebaseUser user = (await _auth.signInWithCredential(credential)).user;

                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage(user)),
                              );
                              });
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),

                  Divider(
                    color: Colors.black,
                    height: 80,
                    indent: 110,
                    endIndent: 110
                  ),

                   SizedBox(
                    width: 150,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.red,
                      child: Text("SIGN UP"),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpPage()),
                          );
                        }
                        
                      )
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