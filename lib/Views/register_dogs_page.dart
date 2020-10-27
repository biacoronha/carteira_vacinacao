import 'package:flutter/material.dart';
import 'package:flutter/src/material/date_picker.dart';

class RegisterDogsPage extends StatefulWidget {
  @override
  _RegisterDogsPageState createState() => _RegisterDogsPageState();
}

class _RegisterDogsPageState extends State<RegisterDogsPage> {
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _raca;
  String _porte;
  String _cor;
  String _data_nascimento;
  int _sexo;
  bool _castrado;

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
                  // new Container(
                  //   width: 190.0,
                  //   height: 190.0,
                  //   decoration: new BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       image: new DecorationImage(
                  //           fit: BoxFit.fill,
                  //           image: AssetImage('assets/images/dog.png')
                  //       )
                  //   )), aqui vai ser pra escolher a foto 
                  SizedBox(height: 20.0),
                  TextFormField(
                      onSaved: (value) => _name = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: "Nome do seu cachorro")),
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
                      InkWell(
                        onTap: () {
                          _selectDate();   // Call Function that has showDatePicker()
                        },
                        child: IgnorePointer(
                          child: new TextFormField(
                            decoration: new InputDecoration(hintText: 'Data de nascimento '),
                            maxLength: 10,
                            // validator: validateDob,
                            onSaved: (String val) {},
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
    if(picked != null) setState(() => _data_nascimento = picked.toString());
}
}


