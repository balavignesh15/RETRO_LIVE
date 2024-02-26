import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'CustomerAdd.dart';
import 'Customer_class/cusactive.dart';
import 'Customer_class/cusdelete.dart';
import 'Customer_class/cusupdate.dart';


class Customer1 extends StatefulWidget {
  const Customer1({Key? key});


  @override
  State<Customer1> createState() => _Customer1State();
}

class _Customer1State extends State<Customer1> {

  TextEditingController namecontroller = TextEditingController();

  Future<List<cusactive>> Details1() async {
    var resp = await http.get(Uri.parse("http://turf.gtcollege.in/api/customers/active"));
    var result = jsonDecode(resp.body);
    print(resp.body);
    return (result as List).map((e) => cusactive.fromJson(e)).toList();
  }

  Future<Delete> delete(String id)  async {
    var resp = await http.post(Uri.parse("http://turf.gtcollege.in/api/customers/delete/$id"),
        headers: <String, String> {
          'content-Type' : 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "admin_id": "A17",
          "admin_name": "prabha",
        })
    );
    // Log the response
    print(resp.body);
    return Delete.fromJson(jsonDecode(resp.body));
  }

  Future<cusupdate> update(String name5, String cusid) async {
    var resp = await http.post(Uri.parse("http://turf.gtcollege.in/api/customers/update/$cusid"),
        headers: <String, String> {
          'content-Type' : 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "customer_name": name5,
          "admin_id": "A17",
          "admin_name": "prabha",
        })
    );
    // Log the response
    print(resp.body);
    return cusupdate.fromJson(jsonDecode(resp.body));
  }

  String name ="";
  Future<List<cusactive>>? _future;

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
                    MaterialPageRoute(builder: (context) => customer()),
                  );
                  if (result != null) {
                    setState(() {
                      // Update dataList with result
                    });
                    // Update dataList with the returned data
                  };
                }, child: Text("Add",style: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,
                fontSize: 25),)),
          )
        ],
      ),
      body:
      FutureBuilder(
        key: UniqueKey(),
        future: Details1(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<cusactive> list = snapshot.data!;
            return
              ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = list[index];
                  return Card(
                    color: Colors.white,
                    child: ListTile(

                      title: Text(
                        "Customer Name: ${list[index].customerName}\n"
                            "Phone Number: ${list[index].phonenumber}\n"
                            "Description: ${list[index].description}",
                        style:TextStyle(color: Colors.black,fontFamily: "Outfit",
                            fontWeight: FontWeight.w100) ,),
                      trailing: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {

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
                                            controller: namecontroller,
                                            onChanged: (value) {
                                              setState(() {
                                                name = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                hintText: "Customer name: ${list[index].customerName}",
                                                hintStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: "Outfit",
                                                    fontWeight: FontWeight.w100,
                                                    fontSize: 18)),
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
                                                    MediaQuery.of(context).size.width * 0.3, 40),),
                                              onPressed: ()  async {
                                                await update(namecontroller.text, list[index].customerId!);
                                                setState(() {
                                                  _future = Details1();
                                                });
                                                // saveData(); // Save the updated data
                                                Navigator.pop(context);
                                              },
                                              child: Text("Update",style: TextStyle(
                                                  fontFamily: "Outfit",fontWeight: FontWeight.w100,
                                                  fontSize: 16
                                              ),),
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
                                          // var c = await del(items.expenseId!);
                                          await delete(item.customerId!);
                                          setState(() {
                                            list.remove(item);
                                          });
                                          Navigator.pop(context);
                                        }, child: Text("Delete"))
                                      ],));
                              },
                              icon: Icon(Icons.delete, color: Colors.black,),
                            ),
                            // IconButton(
                            //   onPressed: () async {
                            //     await delete(item.customerId!);
                            //     setState(() {
                            //       list.remove(item);
                            //     });
                            //   },
                            //   icon: Icon(Icons.delete,color: Colors.black,),
                            //
                            // ),

                          ],
                        ),
                      ),

                    ),
                  );
                },
              );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }

          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}