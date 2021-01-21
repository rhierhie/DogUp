import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projectmobileapp/Searchpage.dart';
import 'Registerpage.dart';
import 'Searchpage.dart';
import 'Userprofile.dart';
import 'Messagingpage.dart';


void main() {
 
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}


String email='';
String userid='';
String dogtype= '';
String address= '';

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String,WidgetBuilder>{
        '/Adminpage': (BuildContext context)=> new Adminpage(),
        '/Memberpage': (BuildContext context)=> new Memberpage(),
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController emailinput = new TextEditingController();
  TextEditingController password = new TextEditingController();
  

  String msg='';

  Future<dynamic> _login() async{
   
   final response = await http.post("http://192.168.2.115/LoginAPI/login.php", body: {
    "email": emailinput.text,
    "password": password.text,
   });

   var datauser = json.decode(response.body);

   if(datauser.length== 0){
     setState(() {
       msg="Login fail";
     });
   }else{
     if(datauser[0]['usertype'] == 'admin'){
       Navigator.push(context, MaterialPageRoute(builder: (context) => Adminpage()));

     }else if(datauser[0]['usertype'] == 'member'){
       Navigator.push(context, MaterialPageRoute(builder: (context) => Memberpage(email: email, address: address, userid: userid)));
       
     }
     setState(() {
       email = datauser[0]['email'];
       userid = datauser[0]['userid'];
       address = datauser[0]['address'];
      
     });
   }
   return datauser;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      
      resizeToAvoidBottomPadding: false,
      body: Container( 
         decoration: BoxDecoration(
            image: DecorationImage(
            colorFilter: new ColorFilter.mode(Colors.green.withOpacity(0.4), BlendMode.dstATop),
            image: AssetImage("images/dogimages.jpg"),
            fit: BoxFit.cover,
          )
        ),
        child: Column(
        children: <Widget>[
           new Container(
            child: new Text("   ",
                style: TextStyle(
              ),),
          ),
           new Container(
             padding: EdgeInsets.only( top: 100),
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
          new Container(
            child: new Text("   ",
                style: TextStyle(
              ),),
          ),
          new Container(
            padding: EdgeInsets.only(top: 70),
            child: new Text(" love dogs  ",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: "pacifico",
                  color: Colors.black54,
              ),),
          ),
          
         
          


         new Padding(
           padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 20),
            child: new TextField(
              controller: emailinput,
              decoration: new InputDecoration(
                labelText: 'Enter email',
                prefixIcon: Icon(Icons.email),
                border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
              ),
              
            ),
          ), 
         
          new Container(
            child: new Text("   ",
                style: TextStyle(
              ),),
          ),

//TEXTFIELD FOR THE PASSWORD
          
          new Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0),
            child: new TextField(
              
              controller: password,
              decoration: new InputDecoration(
               
                labelText: 'Enter password',
                prefixIcon: Icon(Icons.lock),
                 border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(
                          ),
                        ),
              ),
              obscureText: true,
            ),
          ),
          new Container(
            child: new Text("   ",
                style: TextStyle(
              ),),
          ),
          new Container(
            child: new Text("   ",
                style: TextStyle(
              ),),
          ),
          new Container(
            child: new Text("   ",
                style: TextStyle(
              ),),
          ),
          new Row(
            children: <Widget>[
              
          
           new Container(
            child: new Padding(
              padding: EdgeInsets.all(30.0),
               
              ),
          ),
           new Container(
            child: new Text("  ",
               
              ),
          ),
           new Container(
            child: new Text("  ",
               
              ),
          ),
          new ButtonTheme(
            minWidth: 100.0,
            height: 50.0,
            child: new RaisedButton(
                  
               onPressed: (){
                 _login();
                 
               },
               shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
               color: Colors.white70,
               child: Text("Login",
                style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "pacifico",
              ),
              
              ),
            ),
            
          ),
          new Container(
            child: new Padding(
              padding: EdgeInsets.all(30.0),
               
              ),
          ),
          new ButtonTheme(
            minWidth: 100.0,
            height: 50.0,
            child: new RaisedButton(
                  
               onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Registerpage()));
                 
               },
               shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
               color: Colors.white70,
               child: Text("Sign-up",
                style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "pacifico",
               ),
              ),
            ),
            
          ),

            ],),
         
          new Container(
            child: new Text("   "

            ),
          ),
          new Container(
            child: new Text("   "
   
            ),
          ),
          new Container(
            child: new Text("   "
   
            ),
          ),
          new Container(
            child: new Text(msg,style:
            TextStyle(
              fontFamily: "pacifico",
              color: Colors.red,
              fontSize: 20.0,
            )
                
            ),
          ),
        ],
      ),
    ),
    );
  }
}

class Adminpage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("ADMIN PAGE",
        style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                fontFamily: "Pacifico"
              ),),
      ),
      body: Column(
        children: <Widget>[
          new Container(
            child: new Text("  ",
               
              ),
          ),
          
          new Center(
            child: new Text(" Hi My Beatiful  ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                fontWeight: FontWeight.bold,
                fontFamily: "kaushanScript"
              ),),
          ),
          new Center(
            child: new Text('L💜vely Admin ',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 25.0,
                fontWeight: FontWeight.bold,
                fontFamily: "AlexBrush"
              ),),
          ),
          new Center(
            child: new Text(" Adrian Benedict S. Tulang  ",
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 25.0,
                fontWeight: FontWeight.bold,
                fontFamily: "kaushanScript"
              ),),
          ),
          new Center(
            child: new Text("💜",
                style: TextStyle(
                fontSize: 150.0,
                fontWeight: FontWeight.bold,
                fontFamily: "Pacifico"
              ),
            ),
          ),
          new Container(
            child: new RaisedButton(
              onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
               },
               shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
               color: Colors.purple,
               child: Text("LOGOUT",
                style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: "AlexBrush",
                color: Colors.white,
              ),
              
              ),
               
              ),
          ),
        ]
        
        
      ), 
    );
    
  }
}
class Memberpage extends StatelessWidget {
Memberpage({this.email, this.address, this.userid});
final String email;
final String address;
final String userid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text("Dog🖤Up ",
        style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontFamily: "Pacifico",
                letterSpacing: 5,
              ),),
      ),
      body: Container ( 
        decoration: BoxDecoration(
            image: DecorationImage(
            colorFilter: new ColorFilter.mode(Colors.green.withOpacity(0.4), BlendMode.dstATop),
            image: AssetImage("images/dogimages.jpg"),
            fit: BoxFit.cover,
          )
        ),
        child:Column(
        children: <Widget>[
          
          new Container(
            child: new Text("  ",
               
              ),
          ),

          new Center(
            child: new Text("  ",
                style: TextStyle(
                  color: Colors.black,
                
              ),),
          ),
          
          
          new ButtonTheme(
            
            minWidth: 350.0,
             height: 180.0,
             
            child: new Opacity ( 
            
               opacity: 0.4,
              child: OutlineButton(
                borderSide: BorderSide(
                  color: Colors.black26,
                  style: BorderStyle.solid,
                  width: 10,
                  ),
              
               onPressed: (){
                 getdata();
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Displayhusky(userid: userid)));
               },
               shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
               color: Colors.grey,
               child: Text("Husky",
                style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "Tangerine",
              ),
              
              ),
            ),
          ),
            
          ),
          new Container(
            child: new Text("  ",
               
              ),
          ),
          new ButtonTheme(
            
            minWidth: 350.0,
             height: 180.0,
             
            child: new Opacity ( 
            
               opacity: 0.4,
              child: OutlineButton(
                borderSide: BorderSide(
                  color: Colors.black26,
                  style: BorderStyle.solid,
                  width: 10,
                  ),
              
               onPressed: (){
                 getdatapom();
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Displaypom(userid: userid)));
               },
               shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
               color: Colors.grey,
               child: Text("Pomeranian",
                style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "Tangerine"
              ),
              
              ),
            ),
          ),
            
          ),
           new Container(
            child: new Text("   ",
                style: TextStyle(
              ),),
          ),
          new ButtonTheme(
            
            minWidth: 350.0,
             height: 180.0,
             
            child: new Opacity ( 
            
               opacity: 0.4,
              child: OutlineButton(
                borderSide: BorderSide(
                  color: Colors.black26,
                  style: BorderStyle.solid,
                  width: 10,
                  ),
              
               onPressed: (){
                 getdatagolden();
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Displaygolden(userid: userid)));
               },
               shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
               color: Colors.grey,
               child: Text("Golden Retriever",
                style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: "Tangerine"
              ),
              
              ),
            ),
          ),
            
          ),
          // new RaisedButton(
          //   onPressed: (){
          //      Navigator.push(context, MaterialPageRoute(builder: (context) => MyMapPage()));
          //   }
          // )
        ] 
      ),
    ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Hi  $email 🖤 '+ "  "+ address,
               style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'tangerine',
                color: Colors.white,
              ),),
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
            ),
            new Card (
              child:ListTile(
              title: Text('Profile',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'tangerine',
                color: Colors.black54,
                
              ),),
              trailing: Icon(Icons.person),
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfile(email: email,address: address, userid: userid)));
                },
              )
            ),
            new Card ( 
              child:ListTile(
              title: Text('Add  Dog',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'tangerine',
                color: Colors.black54,
                ),
              ),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddDogpage(email: email, userid: userid,address: address )));
              },
            ),
        ),
         new Card (
              child:ListTile(
              title: Text('Inbox',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'tangerine',
                color: Colors.black54,
                ),
              ),
              trailing: Icon(Icons.inbox),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Inboxpage(userid: userid)));
              },
            ),
        ),
            new Card (
              child:ListTile(
              title: Text('Log Out',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'tangerine',
                color: Colors.black54,
                ),
              ),
              trailing: Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
              },
            ),
        ),
            
          ],
        ),
      ),
    );
  }
}






class AddDogpage extends StatelessWidget {


AddDogpage({this.userid, this.email, this.address});
final String userid;
final String email;
final String address;
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        
        title: Center(
          child: Text("Dog Registration ",
            style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                fontFamily: "tangerine"
        ),)
        ),
      ),
      resizeToAvoidBottomPadding: false,
      body: Container( 
        decoration: BoxDecoration(
              image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.green.withOpacity(0.4), BlendMode.dstATop),
            image: AssetImage("images/dogimages.jpg"),
            fit: BoxFit.cover,
          )),
        child: Column(
        children: <Widget>[
          // new Center(
            
          //   child: new Text(" $userid ",
          //       style: TextStyle(
          //     ),
          //   ),
          // ),
          new Center(
            
            child: new Text(address,
                style: TextStyle(
              ),
            ),
          ),
          new Container( 
            padding: EdgeInsets.only(top: 20),
            child:Material(
                elevation: 4.0,
                shape: CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Ink.image(
                  image: AssetImage('images/huskylogo.jpg'),
                  fit: BoxFit.cover,
                  width: 120.0,
                  height: 120.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Huskypage(email: email, address: address, userid: userid)));
                    },
                  ),
                ),
            ),
        ), 
            new Container( 
              child: Center(
                child: Text("Husky",
                style: TextStyle(
                  fontSize: 60,
                  fontFamily: "tangerine"
              ),),)
            ),
            new Container( 
            padding: EdgeInsets.only(top: 20),
            child:Material(
                elevation: 4.0,
                shape: CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Ink.image(
                  image: AssetImage('images/Pomeranianlogo.jpg'),
                  fit: BoxFit.cover,
                  width: 120.0,
                  height: 120.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Pomerpage(email:email, address: address, userid: userid)));
                    },
                  ),
                ),
            ),
        ),
        new Container( 
              child: Center(
                child: Text("Pomeranian",
                style: TextStyle(
                  fontSize: 60,
                  fontFamily: "tangerine"
              ),),)
            ),
        new Container( 
            padding: EdgeInsets.only(top: 20),
            child:Material(
                elevation: 4.0,
                shape: CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Ink.image(
                  image: AssetImage('images/Goldentrieverlogo.jpg'),
                  fit: BoxFit.cover,
                  width: 120.0,
                  height: 120.0,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Goldenpage(email: email, address: address, userid :userid)));
                    },
                  ),
                ),
            ),
        ),
        new Container( 
              child: Center(
                child: Text("Golden Retriever",
                style: TextStyle(
                  fontSize: 60,
                  fontFamily: "tangerine"
              ),),)
            ),        
        ],
      ),
    ),
       
    );
  }
}

class Huskypage extends StatelessWidget {
  Huskypage({this.email, this.address, this.userid});
final String email;
final String address;
final String userid;

  final color = TextEditingController();
  final height = TextEditingController();
  final weight = TextEditingController();
  final dogtype = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container( 
        decoration: BoxDecoration(
              image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.green.withOpacity(0.4), BlendMode.dstATop),
            image: AssetImage("images/dogimages.jpg"),
            fit: BoxFit.cover,
          )),
        child: Container (
          margin: EdgeInsets.only(top:90.0, bottom: 100, left: 50, right: 50),
          decoration: new BoxDecoration(
            color: Colors.grey[300],
            borderRadius: new BorderRadius.only(
              topLeft:  const  Radius.circular(40.0),
              bottomRight: const Radius.circular(40.0),
            )
          ),
        child: Column(
          
        children: <Widget>[
          new Container(
            child: Text(address + userid ),
          ),
          new Container(
            padding: EdgeInsets.only(top:30),
            child: Center(child: Text("Husky",
            style: TextStyle(
              color: Colors.black45,
              fontFamily: "tangerine",
              fontSize: 70,
              decoration: TextDecoration.underline,
            )),),
          ),
          new Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 30),
            child: new TextField(
              controller: dogtype,
              decoration: new InputDecoration(
                labelText: 'Enter dogtype',
                prefixIcon: Icon(Icons.details),
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0),
            child: new TextField(
              controller: color,
              decoration: new InputDecoration(
                labelText: 'Enter color',
                prefixIcon: Icon(Icons.details),
                 
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0),
            child: new TextField(
              controller: height,
              decoration: new InputDecoration(
                labelText: 'Enter height',
                prefixIcon: Icon(Icons.details),
                //  border: new OutlineInputBorder(
                //           borderRadius: new BorderRadius.circular(25.0),
                //           borderSide: new BorderSide(
                //           ),
                //         ),
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0),
            child: new TextField(
              controller: weight,
              decoration: new InputDecoration(
                labelText: 'Enter weight',
                prefixIcon: Icon(Icons.details),
                
              ),
            ),
          ),
          new Container( 
            padding: EdgeInsets.only(top: 40),
            child: ButtonTheme(
            minWidth: 200.0,
             height: 60.0,
            child: new RaisedButton(
 
               onPressed: (){
                 insertdoghusky();
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Memberpage(email: email, address: address, userid: userid)));
                 
               },
               shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
               color: Colors.grey,
               child: Text("Save",
                style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                fontFamily: "tangerine",
                color: Colors.white,
              ),
              
              ),
            ),
            
          ),
        ),
          
          
        ],
      
      ),
      ),
    ),
    );
  }
  void insertdoghusky(){
    
    var url="http://192.168.2.115/LoginAPI/registerdog.php";
    http.post(url, body: {
      
      "color": color.text,
      "height": height.text,
      "weight": weight.text,
      "dogtype": dogtype.text,
      "address": address,
      "userreceiverid" : userid,
    });
  }
}
class Pomerpage extends StatelessWidget {
  Pomerpage({this.email, this.address, this.userid});
  final String userid;
  final String email;
  final String address;

  final color = TextEditingController();
  final height = TextEditingController();
  final weight = TextEditingController();
  final dogtype = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
       body: Container( 
        decoration: BoxDecoration(
              image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.green.withOpacity(0.4), BlendMode.dstATop),
            image: AssetImage("images/dogimages.jpg"),
            fit: BoxFit.cover,
          )),
        child: Container (
          margin: EdgeInsets.only(top:90.0, bottom: 100, left: 50, right: 50),
          decoration: new BoxDecoration(
            color: Colors.grey[300],
            borderRadius: new BorderRadius.only(
              topLeft:  const  Radius.circular(40.0),
              bottomRight: const Radius.circular(40.0),
            )
          ),
        child: Column(
          
        children: <Widget>[
          new Container(
            child: Text(address),
          ),
          new Container(
            padding: EdgeInsets.only(top:30),
            child: Center(child: Text("Pomeranian",
            style: TextStyle(
              color: Colors.black45,
              fontFamily: "tangerine",
              fontSize: 70,
              decoration: TextDecoration.underline,
            )),),
          ),
          new Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 30),
            child: new TextField(
              controller: dogtype,
              decoration: new InputDecoration(
                labelText: 'Enter dogtype',
                prefixIcon: Icon(Icons.details),
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0),
            child: new TextField(
              controller: color,
              decoration: new InputDecoration(
                labelText: 'Enter color',
                prefixIcon: Icon(Icons.details),
                 
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0),
            child: new TextField(
              controller: height,
              decoration: new InputDecoration(
                labelText: 'Enter height',
                prefixIcon: Icon(Icons.details),
                //  border: new OutlineInputBorder(
                //           borderRadius: new BorderRadius.circular(25.0),
                //           borderSide: new BorderSide(
                //           ),
                //         ),
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0),
            child: new TextField(
              controller: weight,
              decoration: new InputDecoration(
                labelText: 'Enter weight',
                prefixIcon: Icon(Icons.details),
                
              ),
            ),
          ),
          new Container( 
            padding: EdgeInsets.only(top: 40),
            child: ButtonTheme(
            minWidth: 200.0,
             height: 60.0,
            child: new RaisedButton(
 
               onPressed: (){
                 insertdogpom();
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Memberpage(email:email, address: address,userid: userid)));
                 
               },
               shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
               color: Colors.grey,
               child: Text("Save",
                style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                fontFamily: "tangerine",
                color: Colors.white,
              ),
              
              ),
            ),
            
          ),
        ),
          
          
        ],
      
      ),
      ),
    ),
    );
  }
   void insertdogpom(){
    
    var url="http://192.168.2.115/LoginAPI/registerdogpom.php";
    http.post(url, body: {
      "color": color.text,
      "height": height.text,
      "weight": weight.text,
      "dogtype": dogtype.text,
      "address": address,
      "userreceiverid" : userid,
    });
  }


}



class Goldenpage extends StatelessWidget {
  Goldenpage({this.email, this.address, this.userid});
  final String userid;
  final String email;
  final String address;

  final color = TextEditingController();
  final height = TextEditingController();
  final weight = TextEditingController();
  final dogtype = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
       body: Container( 
        decoration: BoxDecoration(
              image: DecorationImage(
            colorFilter: new ColorFilter.mode(
                Colors.green.withOpacity(0.4), BlendMode.dstATop),
            image: AssetImage("images/dogimages.jpg"),
            fit: BoxFit.cover,
          )),
        child: Container (
          margin: EdgeInsets.only(top:90.0, bottom: 100, left: 50, right: 50),
          decoration: new BoxDecoration(
            color: Colors.grey[300],
            borderRadius: new BorderRadius.only(
              topLeft:  const  Radius.circular(40.0),
              bottomRight: const Radius.circular(40.0),
            )
          ),
        child: Column(
          
        children: <Widget>[
          new Container(
            child: Text(address),
            ),
          new Container(
            padding: EdgeInsets.only(top:30),
            child: Center(child: Text("Golden Retriever",
            style: TextStyle(
              color: Colors.black45,
              fontFamily: "tangerine",
              fontSize: 70,
              decoration: TextDecoration.underline,
            )),),
          ),
          new Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 30),
            child: new TextField(
              controller: dogtype,
              decoration: new InputDecoration(
                labelText: 'Enter dogtype',
                prefixIcon: Icon(Icons.details),
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0),
            child: new TextField(
              controller: color,
              decoration: new InputDecoration(
                labelText: 'Enter color',
                prefixIcon: Icon(Icons.details),
                 
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0),
            child: new TextField(
              controller: height,
              decoration: new InputDecoration(
                labelText: 'Enter height',
                prefixIcon: Icon(Icons.details),
                //  border: new OutlineInputBorder(
                //           borderRadius: new BorderRadius.circular(25.0),
                //           borderSide: new BorderSide(
                //           ),
                //         ),
              ),
            ),
          ),
          new Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0),
            child: new TextField(
              controller: weight,
              decoration: new InputDecoration(
                labelText: 'Enter weight',
                prefixIcon: Icon(Icons.details),
                
              ),
            ),
          ),
          new Container( 
            padding: EdgeInsets.only(top: 40),
            child: ButtonTheme(
            minWidth: 200.0,
             height: 60.0,
            child: new RaisedButton(
 
               onPressed: (){
                 insertdoggolden();
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Memberpage(email: email, address: address, userid: userid)));
                 
               },
               shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
               color: Colors.grey,
               child: Text("Save",
                style: TextStyle(
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
                fontFamily: "tangerine",
                color: Colors.white,
              ),
              
              ),
            ),
            
          ),
        ),
          
          
        ],
      
      ),
      ),
    ),
    );
  }
   void insertdoggolden(){
    
    var url="http://192.168.2.115/LoginAPI/registerdoggolden.php";
    http.post(url, body: {
      "color": color.text,
      "height": height.text,
      "weight": weight.text,
      "dogtype": dogtype.text,
      "address": address,
      "userreceiverid" : userid,
    });
  }


}