import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

  void setState(Null Function() param0) {}
}

class _HomePageState extends State<HomePage> {
  List userData;
  String title;

  bool isloading = true;
  final String url = "https://randomuser.me/api/?results=50";
  @override
  void initState() {
    super.initState();

    this.getData();
  }

  Future<String> getData() async {
    var response =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    var data = jsonDecode(response.body)['results'];
    setState(() {
      userData = data;
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("User Details"),
      ),
     body:Container(
       child: Center(
         child: isloading ? CircularProgressIndicator() : ListView.builder(
            itemCount: userData == null ? 0 : userData.length,
            itemBuilder: (BuildContext context ,int index ){
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20.0),
                      child: Image(
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          userData[index]['picture']['thumbnail']
                        ),
                      ),

                    ),
                    Expanded(
                      
                      child: Column(
                        
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget> [
                          
                          Text(userData[index]['name']['first'] + " " + userData[index]['name']['last'] ,
                           style: TextStyle(
                             fontSize: 20.0,
                             fontWeight:FontWeight.bold
                            ),
                           ) ,
                           Row(children: [
                              Icon(Icons.phone ),
                           Text( " ${userData[index]['phone']}"),
                           ],),
                           
                           Text("Gender : ${userData[index]['gender']}"),
                           Text("Age: ${userData[index]['dob']['age']}"),
                            Text("${userData[index]['email']}",style: TextStyle(
                             fontWeight:FontWeight.bold,
                             fontFamily: 'Raleway'
                                 )
                               ),
                          
                           
                        
                        ],
                      ),
                          )
                      
                  ],
                  
                ),
              
              );
            },

         ),
       ),
     ) ,
    );
  }
}
