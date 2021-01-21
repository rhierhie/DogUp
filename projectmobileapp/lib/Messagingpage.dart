import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NewMessages extends StatefulWidget {
  NewMessages({Key key, this.title, this.userreceiverid, this.userid}) : super(key: key);


  final String title;
  final String userreceiverid;
  final String userid;

  @override

  _NewMessagesState createState() => _NewMessagesState(userreceiverid: userreceiverid, userid: userid);
}

class _NewMessagesState extends State<NewMessages> {
  _NewMessagesState({this.userreceiverid, this.userid});
  final String userreceiverid;
  final String userid;

final messages = TextEditingController();


  void sendmessage() {
    print(userid);
    print(userreceiverid);
    var url = "http://192.168.2.115/LoginAPI/addmessage.php";

    http.post(url, body: {
      "messages": messages.text,
      "userreceiverid": userreceiverid,
      "sender": userid,
    });
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
     
        title: Text("Messages"),
      ),
      body: Center(

        child: Column(
           
          children: <Widget>[
            new Container (
              padding: EdgeInsets.only(top: 40)
            ),
            new Container(
              child: Text("RECEIVER" + "  " + userreceiverid ,
              style: TextStyle(
                decoration: TextDecoration.underline,
                  letterSpacing: 2,
                  fontSize: 30,
                  color: Colors.black54,
              )),
            ),
            new Container(
              child: Text("SENDER" + "  " + userid ,
              style: TextStyle(
                decoration: TextDecoration.underline,
                  letterSpacing: 2,
                  fontSize: 30,
                  color: Colors.black54,
              )),
            ),
           new Container(
             height: 300,
             margin: EdgeInsets.all(10),
             padding: EdgeInsets.only(bottom: 50.0),
             child: TextField(
              controller: messages, // controller of comments contains the value of the comments of the user.
              maxLines: 90,
              decoration: InputDecoration(
                hintText: "   Leave a Message",
                border: OutlineInputBorder(),
              ),
             ),
           ),
           new Container(
             child: RaisedButton(
               child: Text("Send", 
               ),
                shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0)),
               onPressed: () {
               sendmessage();
               }
               ),
           ),
          ],
        ),
      ),
    );
  }
}

class Inboxpage extends StatefulWidget {
   Inboxpage({Key key, this.title,  this.userid}) : super(key: key);
  final String title;
  final String userid;

  @override
  _InboxpageState createState() => _InboxpageState(userid: userid);
}

class _InboxpageState extends State<Inboxpage> { 
  _InboxpageState({ this.userid});
  final String userid;


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     
        title: Text("Inbox"),
      ),
      body: Container(
        child: FutureBuilder<List<Post>>(
          future: inboxmessages(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Container();
            List<Post> posts = snapshot.data;
            return new ListView(
              // children: posts.map((post) => Text(post.username)).toList(),
              children: posts.map((post) => new Container(
                      height: 150,
                      child: Card(
                        elevation: 10,
                        margin: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ListTile(
                          title: Text("From: " +  post.sender,
                              style: TextStyle(
                                fontSize: 30.0,
                                fontFamily: "tangerine",
                                color: Colors.blueGrey,
                              )),
                          subtitle: Text(post.messages,
                              style: TextStyle(
                                fontSize: 12.0,
                                fontFamily: "Ubuntu",
                                color: Colors.black87,
                              )),
                          leading: new Container(
                            width: 50,
                            alignment: FractionalOffset(0, 1),
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[300],
                              child: Text(post.sender[0],
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: "Ubuntu",
                                    color: Colors.black,
                                  )),
                            ),
                          ),
                          trailing: Container(
                            padding: EdgeInsets.only(top:25),
                             child: Icon(Icons.reply),),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReplyMessages(userid: userid, userreceiverid: post.sender)));
                          },
                        ),
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
     
    );
  }

  Future<List<Post>> inboxmessages() async {
    print(userid);
  http.Response response =
      await http.post("http://192.168.2.115/LoginAPI/getmessage.php", body: {
        "userreceiverid": userid,
      });
  List responseJson = json.decode(response.body);
  return responseJson.map((m) => new Post.fromJson(m)).toList();
}

}

class Post {
  final String userid;
  final String userreceiverid;
  final String sender;
  final String messages;
  

  Post({this.userid,this.userreceiverid,this.sender,this.messages});

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      messages: json['messages'].toString(),
      userid: json['userid'].toString(),
      userreceiverid: json['userreceiverid'].toString(),
      sender: json['sender'].toString(),
    );
  }
}



class ReplyMessages extends StatefulWidget {
   ReplyMessages({Key key, this.title,  this.userid, this.userreceiverid}) : super(key: key);
  final String title;
  final String userid;
  final String userreceiverid;

  @override
  _ReplyMessagesState createState() => _ReplyMessagesState(userid: userid, userreceiverid: userreceiverid);
}

class _ReplyMessagesState extends State<ReplyMessages> {
  _ReplyMessagesState({ this.userid, this.userreceiverid});
  final String userid;
  final String userreceiverid;

final reply = TextEditingController();

void replymessage() {
    print(userid);
    print(userreceiverid);
    var url = "http://192.168.2.115/LoginAPI/addmessage.php";

    http.post(url, body: {
      "messages": reply.text,
      "userreceiverid": userreceiverid,
      "sender": userid,
    });
  }



 @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
     
        title: Text("Messages"),
        
      ),
      body: Column(
      children: <Widget>[
        new Container (
              padding: EdgeInsets.only(top: 40)
            ),
            new Container(
              child: Text("REPLY TO RECEIVER" + "  " + userreceiverid ,
              style: TextStyle(
                decoration: TextDecoration.underline,
                  letterSpacing: 2,
                  fontSize: 30,
                  color: Colors.black54,
              )),
            ),
            new Container(
              child: Text("SENDER" + "  " + userid ,
              style: TextStyle(
                decoration: TextDecoration.underline,
                  letterSpacing: 2,
                  fontSize: 30,
                  color: Colors.black54,
              )),
            ),
            new Container(
             height: 300,
             margin: EdgeInsets.all(10),
             padding: EdgeInsets.only(bottom: 50.0),
             child: TextField(
              controller: reply, // controller of comments contains the value of the comments of the user.
              maxLines: 90,
              decoration: InputDecoration(
                hintText: "   Leave a Message",
                border: OutlineInputBorder(),
              ),
             ),
           ),
           new Container(
             child: RaisedButton(
               child: Text("Send", 
               ),
                shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0)),
               onPressed: () {
               replymessage();
               }
               ),
           ),

      ],
      )
    );
  }
}
