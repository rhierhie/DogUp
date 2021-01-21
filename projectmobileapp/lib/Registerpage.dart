import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';


class Registerpage extends StatefulWidget {
  @override
  RegisterpageState createState() {
    return RegisterpageState();
  }
}

class RegisterpageState extends State<Registerpage> {
  String address = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
            child: Text(
          "Registration",
          style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Tangerine"),
        )),
      ),
      resizeToAvoidBottomPadding: false,
      body: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.green.withOpacity(0.4), BlendMode.dstATop),
            image: AssetImage("images/dogimages.jpg"),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: <Widget>[
              new Container(
             padding: EdgeInsets.only( top: 80),
            child: new Text(" Dog Up  ",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  letterSpacing: 10,
                  fontFamily: "Pacifico",
                  fontSize: 70,
                  color: Colors.black54,

              ),
            ),
          ),
              new Padding(
                padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 50),
                child: new TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "please enter username";
                    }
                    return null;
                  },
                  controller: email,
                  decoration: new InputDecoration(
                    labelText: 'Create new email',
                    prefixIcon: Icon(Icons.email),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                ),
              ),
              new Container(
                child: new Text(
                  "   ",
                  style: TextStyle(),
                ),
              ),
              new Padding(
                padding: EdgeInsets.only(left: 50.0, right: 50.0),
                child: new TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "please enter password";
                    }
                    return null;
                  },
                  controller: password,
                  decoration: new InputDecoration(
                    labelText: 'Create new password',
                    prefixIcon: Icon(Icons.lock),
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                ),
              ),
              new Container(
                child: new Text(
                  "   ",
                  style: TextStyle(),
                ),
              ),
              DropdownButton<String>(
                            
                            value: address,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            hint: Text(" Input Address",
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                            style: TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              width: 5,
                              color: Colors.grey,
                            ),
                            isExpanded: false,
                            onChanged: (String newValue) {
                              setState(() {
                                address = newValue;
                              });
                            },
                            items: <String>['','Limketkai Center', 'Shopwise','Department Of Environment And Natural Resources','Grand Caprice', 'Security Bank','Travelers Pod','M.Lhuilier Osmena, CDO']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
              new Container(
                child: new Text(
                  "   ",
                  style: TextStyle(),
                ),
              ),
              new Container (
                padding: EdgeInsets.only(top: 50),
                child: ButtonTheme(
                minWidth: 305.0,
                height: 60.0,
                child: new RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      insertdata();

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Tangerine",
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
          ),
              new Container(
                child: new Text(
                  "  ",
                ),
              ),
              new Container(
                child: new Text(
                  "  ",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final password = TextEditingController();
  final email = TextEditingController();
  final usertype = String;
  

  void insertdata() {
    var url = "http://172.20.41.130/LoginAPI/addData.php";

    http.post(url, body: {
      "password": password.text,
      "email": email.text,
      "usertype": "member",
      "address": address,
    });
  }
}
