import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:firebase_image/firebase_image.dart';

import '../auth.dart';
import 'login_page.dart';
import 'register_dogs_page.dart';

import 'dart:math' as math;

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
       title: Text('My App'),
        actions: <Widget>[
          Transform.rotate(
            angle: 180 * math.pi / 180,
            child: IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
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
              },
            )),
        ],
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),

  );
 }

Widget _buildBody(BuildContext context) {
 return StreamBuilder<QuerySnapshot>(
   stream: Firestore.instance.collection('users').document(widget.currentUser.uid).collection('dogs').snapshots(),
   builder: (context, snapshot) {
     if (!snapshot.hasData) return LinearProgressIndicator();

     return _buildList(context, snapshot.data.documents);
   },
 );
}
Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
   return Center(
     child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 200.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children:snapshot.map((data) => _buildListItem(context, data)).toList(),
          ),
   ));
     
    
 }

 Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
 final record = Record.fromSnapshot(data);

   return Center (
     child: Container(
     key: ValueKey(record.nome),
     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
     child: Container(
       width: 350.0,
       decoration: BoxDecoration(
         border: Border.all(color: Colors.grey),
         borderRadius: BorderRadius.circular(5.0),
       ),
       child: ListTile(
         title: Text(record.nome),
         trailing: Text(record.nome.toString()),
         onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterDogsPage())),
                      )

       ),
     ),
   );
 }

  rotate(int i, deg) {}
}

class Record {
 final String nome;
 final DocumentReference reference;

 Record.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['nome'] != null),
       nome = map['nome'];

 Record.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$nome>";

}

