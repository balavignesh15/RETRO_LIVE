import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:liveretro_project/payment/paydelete.dart';
import 'package:liveretro_project/user/getall.dart';
import 'package:liveretro_project/user/up%5Bdate.dart';

import 'details.dart';
import 'package:http/http.dart'as http;

class show extends StatefulWidget {
  const show({Key? key});

  @override
  State<show> createState() => _showState();
}

class _showState extends State<show> {

  List dataList = [];
  String name = "";
  String Username = "";
  String password = "";
  String userid = "";
  String? payid;

  Future<updates>? niyas;

  Future<updates> up(String name,String users,String pss,String id) async{
    var a=await http.post(Uri.parse("http://turf.gtcollege.in/api/users/update/$id"),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },body: jsonEncode(<String,dynamic>{
          "name": name,
          "username":users,
          "password": pss,
          "admin_id":"A17",
          "admin_name":"Sam",
        })
    );
    return updates.fromJson(jsonDecode(a.body));
  }

  Future<List<getall1>>get()async{
    var a=await http.get(Uri.parse("http://turf.gtcollege.in/api/users/active"));
    var data=jsonDecode(a.body);
    return (data as List).map((e) =>getall1.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Details",style:TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,
            fontSize: 18,color: Colors.black),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                style:  ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    side: BorderSide(width:3, color:Colors.white), //border width and color
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(10)
                    )),
                onPressed: () async {
                  // Navigate to details screen and get data back
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => details()),
                  );
                  // Update dataList with the returned data
                  if (result != null) {
                    setState(() {
                      dataList.add(result);// Save the updated data
                    });
                  }
                }, child: Text("Add",style: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,
                fontSize: 25),)),
          )
        ],
      ),
      body: FutureBuilder(
        future: get(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            List<getall1>datalist=snapshot.data!;
            return ListView.builder(
              itemCount: datalist.length,
              itemBuilder: (BuildContext context, int index) {
                var item = datalist[index];
                TextEditingController names=TextEditingController(text: item.name);
                TextEditingController user=TextEditingController(text: item.username);
                TextEditingController pass=TextEditingController(text: item.password);

                return Card(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Name: ${item.name}\n"
                              "Username:${item.username}\n"
                              "Password: ${item.password}",
                          style:TextStyle(color: Colors.black,fontFamily: "Outfit",
                              fontWeight: FontWeight.w100) ,),
                        trailing: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: (){
                                  setState(() {
                                    payid=item.userId;
                                    names.text;
                                    user.text;
                                    pass.text;
                                  });
                                  showDialog(
                                    context: context,
                                    builder: (context) => Container(
                                      height: MediaQuery.of(context).size.height * 0.2,
                                      width: MediaQuery.of(context).size.width * 0.3,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: SimpleDialog(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: names,
                                              onChanged: (value) {
                                                setState(() {
                                                  name = value;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                  hintText: "Name",
                                                  hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: "Outfit",
                                                      fontWeight: FontWeight.w100,
                                                      fontSize: 18)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: user,
                                              onChanged: (value) {
                                                setState(() {
                                                  Username = value;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                  hintText: "username",
                                                  hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: "Outfit",
                                                      fontWeight: FontWeight.w100,
                                                      fontSize: 18)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              controller: pass,
                                              onChanged: (value) {
                                                setState(() {
                                                  password = value;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                hintText: "password",
                                                hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Outfit",
                                                    fontWeight: FontWeight.w100,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.black,
                                                  foregroundColor: Colors.white,
                                                  minimumSize: Size(
                                                      MediaQuery.of(context).size.width * 0.3, 55),
                                                ),
                                                onPressed: () async{
                                                  await up(names.text,user.text, pass.text, payid!);
                                                  setState(() {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                child: Text("Update", style: TextStyle(
                                                  fontFamily: "Outfit", fontWeight: FontWeight.w100,
                                                  fontSize: 16,
                                                )),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.black,
                                                  foregroundColor: Colors.white,
                                                  minimumSize: Size(
                                                      MediaQuery.of(context).size.width * 0.3, 55),),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Close",style: TextStyle(
                                                    fontFamily: "Outfit",fontWeight: FontWeight.w100,
                                                    fontSize: 16
                                                ),),
                                              ),],
                                          )

                                        ],
                                      ),
                                    ),
                                  );

                                },
                                icon: Icon(Icons.edit,color: Colors.black,),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context, builder: (context) =>
                                      AlertDialog(
                                        title: Text("Confirm Delete"),
                                        content: Text(
                                            "Are you sure you want to delete this item?"),
                                        actions: [
                                          TextButton(onPressed: () {
                                            Navigator.pop(context);
                                          }, child: Text("Cancel")),
                                          TextButton(onPressed: () async {
                                            await del(item.userId!);
                                            setState(() {
                                              datalist.remove(item);
                                            });
                                            Navigator.pop(context);
                                          }, child: Text("Delete"))
                                        ],));
                                },
                                icon: Icon(Icons.delete, color: Colors.black,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }else if(snapshot.hasError){
            return Text("${snapshot.hasError}");
          }return Center(child: CircularProgressIndicator());
        },

      ),
    );
  }
  Future<delete>del(String id)async{
    var a=await http.post(Uri.parse("http://turf.gtcollege.in/api/users/delete/$id"),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },body: jsonEncode(<String,dynamic>{
          "admin_id":"A17",
          "admin_name":"Sam",
        })
    );
    return delete.fromJson(jsonDecode(a.body));
  }
}

