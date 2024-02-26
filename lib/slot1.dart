import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liveretro_project/slot2.dart';

import 'package:shared_preferences/shared_preferences.dart';


typedef DataUpdateCallback = void Function(List<Map<String, String>> updatedDataList);

class NextPage extends StatefulWidget {
  final DataUpdateCallback dataUpdateCallback;

  NextPage({Key? key, required this.dataUpdateCallback}) : super(key: key);

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  List<Map<String, String>> datas = [];
  String name="";
  String date="";
  String from="";
  String to="";
  String dec="";
  String total="";
  String advance="";
  String balance="";
  String phone="";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString('datas') ?? '[]';
    setState(() {
      datas = List<Map<String, String>>.from(
        (json.decode(data) as List).map(
              (item1) => Map<String, String>.from(item1),
        ),
      );
    });
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('datas', json.encode(datas));
  }

  void addItemList() {
    // ... existing code

    // After processing the new data, call the callback function
    widget.dataUpdateCallback(datas);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Slots",
            style: TextStyle(
                fontFamily: "Outfit",fontWeight: FontWeight.w100
            ),
          ),
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
                    )),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Sample()),
                  );

                  if (result != null) {
                    setState(() {
                      datas.add(result);
                      saveData();
                    });
                    addItemList(); // Call the function to update the data
                  }
                },
                child: Text("Add",style: TextStyle(
                    fontFamily: "Outfit",fontWeight: FontWeight.w100,
                    fontSize: 20
                ),),
              ),
            )
          ],
        ),
        body:datas.isNotEmpty?  ListView.builder(
          itemCount: datas.length,
          itemBuilder: (BuildContext context, int index) {
            var item1 = datas[index];

            // Format the date using intl package
            String formattedDate = (item1["date"] != null)
                ? DateFormat('yyyy-MM-dd').format(DateTime.parse(item1["date"]!))
                : "";

            return Card(
              color: Colors.white,
              child: ExpansionTile(title: Text( "Name: ${(item1["name"])}",style: TextStyle(color: Colors.black,fontFamily: "Outfit",
                  fontWeight: FontWeight.w100),),
                children: [
                  ListTile(
                    title: Text(

                      "Name: ${(item1["name"])}\n"
                          "Phone: ${(item1["phone"])}\n"
                          "Description: ${(item1["description"])}\n"
                          "Total: ${(item1["total"])}\n"
                          "Advance: ${(item1["advance"])}\n"
                          "Balance: ${(item1["balance"])}\n"
                          "Date: $formattedDate\n"
                          "From: ${(item1["from"])}\n"
                          "To: ${(item1["to"])}\n",
                      style: TextStyle(color: Colors.black,
                          fontFamily: "Outfit",fontWeight: FontWeight.w100
                      ),
                    ),
                    trailing: SizedBox(
                      height: 50,
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              TextEditingController NameController =
                              TextEditingController(text: item1['name']);
                              TextEditingController phoneController =
                              TextEditingController(text: item1['phone']);
                              TextEditingController dateController =
                              TextEditingController(text: item1['date']);
                              TextEditingController descController =
                              TextEditingController(text: item1['description']);
                              TextEditingController fromController =
                              TextEditingController(text: item1['from']);
                              TextEditingController toController =
                              TextEditingController(text: item1['to']);
                              TextEditingController totalController =
                              TextEditingController(text: item1['total']);
                              TextEditingController advanceController =
                              TextEditingController(text: item1['advance']);
                              TextEditingController balanceController =
                              TextEditingController(text: item1['balance']);

                              showDialog(
                                context: context,
                                builder: (context) => Container(
                                  height: MediaQuery.of(context).size.height * 0.2,
                                  width: MediaQuery.of(context).size.width * 1,
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
                                          controller: NameController,
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
                                                  fontSize: 18)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: phoneController,
                                          onChanged: (value) {
                                            setState(() {
                                              phone = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                              labelText: "Phone number",
                                              labelStyle: TextStyle(
                                                  fontFamily: "Outfit",
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: 18)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: dateController,
                                          onChanged: (value) {
                                            setState(() {
                                              date = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: "Date",
                                            labelStyle: TextStyle(
                                                fontFamily: "Outfit",
                                                fontWeight: FontWeight.w100,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: fromController,
                                          onChanged: (value) {
                                            setState(() {
                                              from = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                              labelText: "From",
                                              labelStyle: TextStyle(
                                                  fontFamily: "Outfit",
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: 18)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: toController,
                                          onChanged: (value) {
                                            setState(() {
                                              to = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                              labelText: "To",
                                              labelStyle: TextStyle(
                                                  fontFamily: "Outfit",
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: 18)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: descController,
                                          onChanged: (value) {
                                            setState(() {
                                              dec = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: "Description",
                                            labelStyle: TextStyle(
                                                fontFamily: "Outfit",
                                                fontWeight: FontWeight.w100,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: totalController,
                                          onChanged: (value) {
                                            setState(() {
                                              total = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                              labelText: "Total",
                                              labelStyle: TextStyle(
                                                  fontFamily: "Outfit",
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: 18)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: advanceController,
                                          onChanged: (value) {
                                            setState(() {
                                              advance = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                              labelText: "Advance",
                                              labelStyle: TextStyle(
                                                  fontFamily: "Outfit",
                                                  fontWeight: FontWeight.w100,
                                                  fontSize: 18)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          controller: balanceController,
                                          onChanged: (value) {
                                            setState(() {
                                              balance = value;
                                            });
                                          },
                                          decoration: InputDecoration(
                                            labelText: "Balance",
                                            labelStyle: TextStyle(
                                                fontWeight: FontWeight.w100,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white,
                                          minimumSize: Size(
                                              MediaQuery.of(context).size.width * 0.3,
                                              55),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            datas[index]['name'] =
                                                NameController.text;
                                            datas[index]['phone'] =
                                                phoneController.text;
                                            datas[index]['date'] =
                                                dateController.text;
                                            datas[index]['from'] =
                                                fromController.text;
                                            datas[index]['to'] =
                                                toController.text;
                                            datas[index]['description'] =
                                                descController.text;
                                            datas[index]['total'] =
                                                totalController.text;
                                            datas[index]['advance'] =
                                                advanceController.text;
                                            datas[index]['balance'] =
                                                balanceController.text;

                                          });
                                          saveData(); // Save the updated data
                                          Navigator.pop(context);
                                        },
                                        child: Text("Update",style: TextStyle(
                                            fontFamily: "Outfit",fontWeight: FontWeight.w100
                                        ),),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit,color: Colors.black,),
                          ),
                          IconButton(onPressed: (){
                            setState(() {
                              datas.removeAt(index);
                              saveData();
                            });

                          }, icon: Icon(Icons.delete,color: Colors.black,))
                        ],
                      ),
                    ),
                  )
                ],),
            );
          },
        ) : Center(child: Image.asset("assets/norecords.png"))
    );
  }
}

