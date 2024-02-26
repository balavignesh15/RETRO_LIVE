import 'dart:convert';
import 'package:flutter/material.dart';
import 'cat.dart';
import 'package:http/http.dart'as http;

import 'category/catdelete.dart';
import 'category/catgets.dart';
import 'category/catupdate.dart';



class showcat extends StatefulWidget {
  const showcat({Key? key}) : super(key: key);

  @override
  State<showcat> createState() => _showcatState();
}

class _showcatState extends State<showcat> {
  List cat=[];
  String name = "";
  String? payid;

  Future<List<catactive>>? _future;

  Future<catupdate> update(String category, String id) async{
    var a=await http.post(Uri.parse("http://turf.gtcollege.in/api/category/update/$id"),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },body: jsonEncode(<String,dynamic>{
          "expense_category":category,
          "admin_id":"A17",
          "admin_name":"prabha"
        })
    );
    return catupdate.fromJson(jsonDecode(a.body));
  }

  Future<List<catactive>>caget()async{
    var get=await http.get(Uri.parse("http://turf.gtcollege.in/api/category/active"));
    var data=jsonDecode(get.body);
    return (data as List).map((e) => catactive.fromJson(e)).toList();
  }

  Future<catdelete>del(String id)async{
    var a=await http.post(Uri.parse("http://turf.gtcollege.in/api/category/delete/$id"),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String,dynamic>{
          "admin_id": "A17",
          "admin_name": "prabha"
        }));
    var res = catdelete.fromJson(jsonDecode(a.body));
    print(res);
    return res;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Details",style: TextStyle(
            color: Colors.black,
            fontFamily: "Outfit",fontWeight: FontWeight.w100,
            fontSize: 20
        ),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  side: BorderSide(width:3, color:Colors.white), //border width and color
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.circular(10)
                  )
              ),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => exppage(),
                  ),
                );
                // Update dataList with the returned data
                if (result != null) {
                  setState(() {
                    cat.add(result);
                  });
                }
              },
              child:Text("Add",style: TextStyle(
                  fontSize: 25,fontFamily: "Outfit",fontWeight: FontWeight.w100
              ),),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: caget(),
        builder: (context,snapshot){
          if (snapshot.hasData){
            List<catactive>data=snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                var items = data[index];
                TextEditingController nameController =
                TextEditingController(text: items.expenseCategory);
                return Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        // ListTile(title: Text("${items.categoryId}")),
                        ListTile(
                          title: Text("Category:${items.expenseCategory}",style: TextStyle(
                              color: Colors.black,fontFamily: "Outfit",fontWeight: FontWeight.w100
                          ),),
                          trailing: SizedBox(
                            height: 50,
                            width: 100,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: IconButton(
                                    color: Colors.black,
                                    onPressed: () {
                                      setState(() {
                                        payid=items.categoryId;
                                        nameController.text;
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
                                                  controller: nameController,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      name = value;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    labelText: "Name",
                                                    labelStyle: TextStyle(
                                                      fontFamily: "Outfit",
                                                      fontWeight: FontWeight.w100,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.black,
                                                      foregroundColor: Colors.white,
                                                      minimumSize: Size(
                                                          MediaQuery.of(context).size.width * 0.3, 40),
                                                    ),
                                                    onPressed: () async{
                                                      await update(nameController.text,payid!);
                                                      setState(() {
                                                        // _future = caget();
                                                        Navigator.pop(context);

                                                      });
                                                    },
                                                    child: Text("Update"),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "Close",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontFamily:
                                                          "Outfit",
                                                          fontWeight:
                                                          FontWeight
                                                              .w100),
                                                    ),
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor:
                                                        Colors.black,
                                                        foregroundColor:
                                                        Colors.white,
                                                        minimumSize: Size(
                                                            MediaQuery.of(
                                                                context)
                                                                .size
                                                                .width *
                                                                0.3,
                                                            40),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                10))),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon((Icons.edit)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: IconButton(
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
                                                await del(items.categoryId!);
                                                setState(() {
                                                  data.remove(items);
                                                });
                                                Navigator.pop(context);
                                              }, child: Text("Delete"))
                                            ],));
                                    },
                                    icon: Icon(Icons.delete, color: Colors.black,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],

                    ),
                  ),
                );
              },
            );
          }else if(snapshot.hasError){
            return Text("${snapshot.hasError}");
          }return CircularProgressIndicator();
        },
      ),
    );
  }
}