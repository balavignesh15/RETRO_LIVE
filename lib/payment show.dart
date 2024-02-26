import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:liveretro_project/payment.dart';
import 'package:liveretro_project/payment/paydelete.dart';
import 'package:liveretro_project/payment/payget.dart';
import 'package:liveretro_project/payment/payupdate.dart';
import 'package:provider/provider.dart';

import 'class.dart';
import 'package:http/http.dart' as http;

class second1 extends StatefulWidget {
  const second1({super.key});

  @override
  State<second1> createState() => _second1State();
}
Future<update>? _update;

class _second1State extends State<second1> {
  Future<update>? _update;
  String? selPayId;
  Future<List<Getall>>? _future;

  Future<update> Update(String mode, String payId) async {
    print(payId);
    print("http://turf.gtcollege.in/api/payments/update/$payId");
    var resp = await http.post(
      Uri.parse("http://turf.gtcollege.in/api/payments/update/$payId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "payment_mode": mode,
        "admin_id": "A17",
        "admin_name": "prabha"
      }),
    );
    return update.fromJson(jsonDecode(resp.body));
  }

  // Future<Getall> GetbyId(String id) async{
  //   var resp = await http.get(Uri.parse("http://turf.gtcollege.in/api/payments/active/P02/$id"));
  //   return  Getall.fromJson(jsonDecode(resp.body));
  // }
  //

  Future<List<Getall>> Payment() async {
    var resp = await http
        .get(Uri.parse("http://turf.gtcollege.in/api/payments/active"));
    var a = jsonDecode(resp.body);
    return (a as List).map((e) => Getall.fromJson(e)).toList();
  }

  Future<delete>? _delete;

  List<Map<String, dynamic>> data = [];

  Future<delete> Delete(String id) async {
    var resp = await http.post(
      Uri.parse("http://turf.gtcollege.in/api/payments/delete/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{
            "admin_id": "A17",
            "admin_name": "prabha"
          }),
    );
    return delete.fromJson(jsonDecode(resp.body));
  }

  String name = "";
  //
  @override
  void initState() {
    // print("init state");
    super.initState();
    //loadData();
    _future = Payment();
  }


  @override
  Widget build(BuildContext context) {
    var payProvider = Provider.of<CatProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // leading: GestureDetector(
        //     onTap: (){
        //       //Navigator.push(context, MaterialPageRoute(builder: (context) => bottomsample()));
        //     Navigator.pop(context);
        //     },
        //     child: Icon(Icons.arrow_back)),
        backgroundColor: Colors.white,
        title: Text(
          "Details",
          style: TextStyle(fontFamily: "Outfit", fontWeight: FontWeight.w100),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  side: BorderSide(width: 3, color: Colors.white),
                  //border width and color
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => turf(),
                  ),
                ).then((result) {
                  // Handle the result, which contains the newly added item
                  if (result != null && result is Map<String, dynamic>) {
                    setState(()  {
                      // data.add(result);
                      _future = Payment(); // Fetch updated data from the server
                    });
                  }
                });
              },
              child: Text(
                "Add",
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: "Outfit",
                    fontWeight: FontWeight.w100),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<Getall> data = snapshot.data!;
                  return
                    ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var items = data[index];
                        // print(items.toJson());
                        TextEditingController nameController =
                        TextEditingController(text: items.paymentMode);
                        return Card(
                          color: Colors.white,
                          child: Column(
                            children: [
                              // Text(items.paymentId!),
                              ListTile(
                                title: Text(
                                  "Paymentmode: ${data[index].paymentMode}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: "Outfit",
                                      fontWeight: FontWeight.w100),
                                ),
                                trailing: SizedBox(
                                  height: 80,
                                  width: 100,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          // Getall item = await GetbyId(items["id"]!);
                                          setState(() {
                                            selPayId = items.paymentId;
                                          });

                                          print(selPayId);
                                          showDialog(
                                            context: context,
                                            builder: (context) => Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.3,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.4,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(20),
                                              ),
                                              child: SimpleDialog(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                ),
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: TextField(
                                                      controller: nameController,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          name = value;
                                                        });
                                                      },
                                                      decoration: InputDecoration(
                                                        hintText: "Name",
                                                        hintStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "Outfit",
                                                          fontWeight:
                                                          FontWeight.w100,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          print("Hello");
                                                          print(selPayId);

                                                          // payProvider
                                                          //     .pay[index]['Paymentmode'] =
                                                          //     nameController.text;

                                                          await Update(nameController.text, selPayId!);

                                                          //save();

                                                          setState(() {
                                                            // _future = Payment();
                                                          });
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text(
                                                          "Update",
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
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text("Confirm Delete"),
                                                content: Text(
                                                    "Are you sure you want to delete this item?"),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Cancel"),
                                                  ),
                                                  TextButton(
                                                      onPressed: () async {
                                                        await Delete(
                                                            items.paymentId!);

                                                        setState(() {
                                                          data.remove(items);
                                                        });
                                                        Navigator.pop(
                                                            context); // Close the dialog
                                                      },
                                                      child: Text("Delete"))
                                                ],
                                              ));
                                          // setState(() {
                                          //   payProvider.pay.removeAt(index);
                                          // });
                                          //save();// Save the updated data
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                        ),
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
                } else if (snapshot.hasError) {
                  return Text("${snapshot.hasError}");
                }
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
