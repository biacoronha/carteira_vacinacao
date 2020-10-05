import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_page.dart';
import 'auth.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser currentUser;
  HomePage(this.currentUser);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Flutter Firebase"),
        //actions: <Widget>[LogoutButton()],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'Home Page Flutter Firebase  Content',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text(
              'Welcome ${widget.currentUser.email}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 20.0),
            RaisedButton(
                child: Text("LOGOUT"),
                onPressed: () async {
                  googleSignIn.signOut();
                  if(widget.currentUser.email == null){
                    await Provider.of<AuthService>(context).logout();
                  }
                  else{
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                  }
                  
                  //Navigator.pushReplacementNamed(context, "/");
                })
          ],
        ),
      ),
    );
  }
}