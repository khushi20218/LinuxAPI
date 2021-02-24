import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';



var command, data;
  class MyApp extends StatefulWidget {
    @override
    _MyAppState createState() => _MyAppState();
  }
  
  class _MyAppState extends State<MyApp> {
     var connection = FirebaseFirestore.instance;
      var i,z,final_output;
 
  mydate() async {
    
  var url = "http://192.168.99.101/cgi-bin/date.py?x=$command";
  var r = await http.get(url);
  // var sc = r.statusCode;
  setState(() {
    data = r.body;
  });
     

  connection.collection("Linux_API").add({
               "cmd": command,
               "output": data
              });
}
 myget() async{
    var info= await connection.collection("Linux_API").get();
    for(i in info.docs){
    z=i.data();
    if (z["cmd"]==command){
      setState(() {
         final_output=(z["output"]);
      });
     
    }
    
    }
    
  }
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
    centerTitle: true,
    title: Text(
      'Linux API', style: TextStyle(
            fontWeight: FontWeight.bold
      ),
  )),
        body: Center(child:Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage("https://cdn.wallpapersafari.com/95/41/hGkO64.jpg"),
      ),
      color: Colors.black,
      border: Border.all(
        color: Colors.blueGrey.shade700,
        width:10
      )
    ),
    child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  child: TextField(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,

                    ),
                      decoration: InputDecoration(

                      hintText: "Enter your Command",
                      prefixIcon: Icon(Icons.bookmark_border),
                     
                    ),
                    onChanged: (value){
                      command=value;
                    },
                  ),
                ),
                RaisedButton(onPressed: mydate, child: Text("STORE YOUR OUTPUT")),
                RaisedButton(onPressed: myget, child: Text("GET YOUR OUTPUT")),
                Text( final_output ?? "Here is your Output", style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              ]
)),
    ),
  ));
    }
  }