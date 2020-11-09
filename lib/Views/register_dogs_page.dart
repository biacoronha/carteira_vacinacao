import 'dart:io';

import 'package:carteira_vacinacao/Controllers/imageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/date_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class RegisterDogsPage extends StatefulWidget {
  @override
  _RegisterDogsPageState createState() => _RegisterDogsPageState();
}

class _RegisterDogsPageState extends State<RegisterDogsPage> {
  // static ImageController imageController = new ImageController();
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _raca;
  String _porte;
  String _cor;
  DateTime _data_nascimento;
  int _sexo;
  bool _castrado;
  File _image ;
  TextEditingController _textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar: AppBar(
          title: Text("Register Dogs"),
        ),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  new GestureDetector(
                    onTap: () {
                      showPicker(context);
                    },
                    child: _image != null
                    ? new CircleAvatar(
                      backgroundImage: FileImage(_image),
                      radius: 55,
                    )
                    : new Container(
                      decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)),
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              ),
                   ),                 
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                      onSaved: (value) => _name = value,
                      decoration: InputDecoration(labelText: "Nome do seu cachorro*")),
                  TextFormField(
                      onSaved: (value) => _raca = value,
                      decoration: InputDecoration(labelText: "Raça")),
                  SizedBox(height: 20.0),
                  TextFormField(
                      onSaved: (value) => _porte = value,
                      decoration: InputDecoration(labelText: "Porte")),
                  SizedBox(height: 20.0),
                  TextFormField(
                      onSaved: (value) => _cor = value,
                      decoration: InputDecoration(labelText: "Cor")),
                  SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () => _selectDate(),
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _textEditingController,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              hintText: 'Data de nascimento',
                            ),
                          ),
                        ),
                      ),

                  SizedBox(height: 20.0),

                  SizedBox(
                    width: 300,
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text("Register"),
                      shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () async {
                        // save the fields..
                        final form = _formKey.currentState;
                        form.save();

                        // Validate will return true if is valid, or false if invalid.
                        // if (form.validate()) {
                        //   try {
                            
                        //   };
                        //   } on AuthException catch (error) {
                        //     return _buildErrorDialog(context, error.message);
                        //   } on Exception catch (error) {
                        //     return _buildErrorDialog(context, error.toString());
                        //   }
                        }
                      
                    )
                  ),

                ]))));
  }

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2000),
        lastDate: new DateTime(2021)
    );
    if(picked != null) {
      _data_nascimento = picked;
      _textEditingController
        ..text = DateFormat.yMMMd().format(_data_nascimento)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
}

  _imgFromCamera() async
  {
    File image = await ImagePicker.pickImage(
      source: ImageSource.camera, imageQuality: 50
    );

  setState(() {
    _image = image;
  });
  }
  
  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );
    
  setState(() {
    _image = image;
  });
  }
         
  void showPicker(context)
  {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  File get image
  {
    return _image;
  }

  void set image(image)
  {
    _image = image;
  } 
}


