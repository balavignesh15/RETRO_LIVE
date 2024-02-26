import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liveretro_project/payment%20show.dart';
import 'package:liveretro_project/show%20cat.dart';
import 'package:liveretro_project/slot1.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


// import 'Customer.dart';
import 'Customer.dart';
import 'class.dart';
import 'display.dart';
import 'expshow.dart';

class bottomsample extends StatefulWidget {
  const bottomsample({
    Key? key,
  });

  @override
  State<bottomsample> createState() => _bottomsampleState();
}

class _bottomsampleState extends State<bottomsample> {
  TextEditingController total1 = TextEditingController();
  TextEditingController paid = TextEditingController();
  TextEditingController balance1 = TextEditingController();
  TextEditingController received = TextEditingController();
  TextEditingController payment = TextEditingController();




  void updateBalanceInDialog(
      TextEditingController total1,
      TextEditingController paid,
      TextEditingController balance1,
      TextEditingController received,
      ) {
    double totalAmount = double.parse(total1.text);
    double advanceAmount = double.parse(paid.text);
    double receivedAmount = double.parse(received.text);

    double balanceAmount = totalAmount - advanceAmount - receivedAmount;

    balance1.text = balanceAmount.toStringAsFixed(2);
  }





  String? option;

  void _addItemToList() {
    String?options=option;
    Map<String, String> newItem = {
      'Total': total1.text,
      'Advance': paid.text,
      'Balance': balance1.text,
      'Received': received.text,
      "payment":options??"",
    };

    itemList.add(newItem);

    total1.clear();
    paid.clear();
    balance1.clear();
    received.clear();

    Navigator.pop(context);
  }

  List<Map<String, String>> itemList = [];
  List<Map<String, String>> datas = [];
  List<Map<String, String>> dataList = [];
  String name = "";
  String date = "";
  String from = "";
  String to = "";
  String dec = "";
  String total = "";
  String advance = "";
  String balance = "";
  String phone = "";

  @override
  void initState() {
    super.initState();
    loadData();
    initializeDropdownValues();
  }

  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString('datas') ?? '[]';
    setState(() {
      dataList = List<Map<String, String>>.from(
        (json.decode(data) as List).map(
              (item1) => Map<String, String>.from(item1),
        ),
      );
      datas = List<Map<String, String>>.from(dataList);
    });
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('datas', json.encode(dataList));
  }

  ///Function to handle data changes and trigger save
  void handleDataChange(List<Map<String, String>> updatedDataList) {
    setState(() {
      dataList = updatedDataList;
      datas = List<Map<String, String>>.from(updatedDataList);
    });
    saveData(); // Save data when the list is updated
  }

  void initializeDropdownValues() async {
    var catProvider = Provider.of<CatProvider>(context, listen: false);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Load pay values
    String payData = prefs.getString("pay") ?? "[]";
    catProvider.updatePay(List<Map<String, String>>.from(
      (json.decode(payData) as List).map(
            (items) => Map<String, String>.from(items),
      ),
    ));

    // Set default values if necessary

  }



  @override
  Widget build(BuildContext context) {
    var payProvider = Provider.of<CatProvider>(context);
    List<Map<String, String>> todayDataList = dataList
        .where((item) =>
    item["date"] != null &&
        DateFormat('yyyy-MM-dd').format(DateTime.parse(item["date"]!)) ==
            DateFormat('yyyy-MM-dd').format(DateTime.now()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "RETRO STATION",
          style: TextStyle(fontSize: 30,fontFamily: "Outfit",
              fontWeight: FontWeight.w100),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Create Customer"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Customer1()));
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Create User"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => show()));
                },
              ),
              ListTile(
                leading: Icon(Icons.payment),
                title: Text("Add Payment"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => second1()));
                },

              ),
              ListTile(
                leading: Icon(Icons.payment),
                title: Text("Add Category"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => showcat()));
                },
              )],
          )
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    RawChip(
                      backgroundColor: Colors.white,
                      label: Text("Add Expenses",
                        style: TextStyle(fontSize: 20,fontFamily: "Outfit",
                            fontWeight: FontWeight.w100),),
                      avatar: Icon(Icons.payments_outlined
                        ,color: Colors.black,),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => expcat()));
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    RawChip(
                      backgroundColor: Colors.white,
                      label: Text("Slot Booking",
                        style: TextStyle(fontSize: 20,fontFamily: "Outfit",
                            fontWeight: FontWeight.w100),),
                      avatar: Icon(Icons.create,color: Colors.black,),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NextPage(
                              dataUpdateCallback: handleDataChange,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Container(
                    height: 700,
                    child:datas.isNotEmpty?  ListView.builder(
                      itemCount: todayDataList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item1 = todayDataList[index];

                        // Format the date using intl package
                        String formattedDate = (item1["date"] != null)
                            ? DateFormat('dd-MM-yyyy')
                            .format(DateTime.parse(item1["date"]!))
                            : "";

                        return Card(
                          color: Colors.white,
                          child: ExpansionTile(
                            title: Text(
                              "Details: ${(item1["name"])}",
                              style: TextStyle(color: Colors.black,
                                  fontFamily: "Outfit",fontWeight: FontWeight.w100),
                            ),
                            children: [
                              Text("Before Play",style: TextStyle(color: Colors.black,fontSize: 30,
                                  fontFamily: "Outfit",fontWeight: FontWeight.w100),),
                              ListTile(
                                title: Text(
                                  "Phone: ${(item1["phone"])}\n"
                                      "Name: ${(item1["name"])}\n"
                                      "Description: ${(item1["description"])}\n"
                                      "Total: ${(item1["total"])}\n"
                                      "Advance: ${(item1["advance"])}\n"
                                      "Balance: ${(item1["balance"])}\n"
                                      "Date: $formattedDate\n"
                                      "From: ${(item1["from"])}\n"
                                      "To: ${(item1["to"])}",
                                  style: TextStyle(color: Colors.black,
                                      fontFamily: "Outfit",fontWeight: FontWeight.w100),
                                ),
                                trailing: SizedBox(
                                  height: 100,
                                  width: 200,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          TextEditingController NameController =
                                          TextEditingController(
                                              text: item1['name']);
                                          TextEditingController phoneController =
                                          TextEditingController(
                                              text: item1['phone']);
                                          TextEditingController dateController =
                                          TextEditingController(
                                              text: item1['date']);
                                          TextEditingController descController =
                                          TextEditingController(
                                              text: item1['description']);
                                          TextEditingController fromController =
                                          TextEditingController(
                                              text: item1['from']);
                                          TextEditingController toController =
                                          TextEditingController(
                                              text: item1['to']);
                                          TextEditingController totalController =
                                          TextEditingController(
                                              text: item1['total']);
                                          TextEditingController
                                          advanceController =
                                          TextEditingController(
                                              text: item1['advance']);
                                          TextEditingController
                                          balanceController =
                                          TextEditingController(
                                              text: item1['balance']);

                                          showDialog(
                                            context: context,
                                            builder: (context) => Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                                  0.2,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  1,
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
                                                      controller: NameController,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          name = value;
                                                        });
                                                      },
                                                      decoration: InputDecoration(
                                                          labelText: "Name",
                                                          labelStyle: TextStyle(
                                                              fontFamily:
                                                              "Outfit",
                                                              fontWeight:
                                                              FontWeight.w100,
                                                              fontSize: 18)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: TextField(
                                                      style: TextStyle(
                                                          fontWeight:FontWeight.w100,
                                                          fontFamily: "Outfit"
                                                      ),
                                                      controller: phoneController,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          phone = value;
                                                        });
                                                      },
                                                      decoration: InputDecoration(
                                                          labelText: "Phone",
                                                          labelStyle: TextStyle(
                                                              fontFamily:
                                                              "Outfit",
                                                              fontWeight:
                                                              FontWeight.w100,
                                                              fontSize: 18)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: TextField(
                                                      style: TextStyle(
                                                          fontWeight:FontWeight.w100,
                                                          fontFamily: "Outfit"
                                                      ),
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
                                                            fontWeight:
                                                            FontWeight.w100,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: TextField(
                                                      style: TextStyle(
                                                          fontWeight:FontWeight.w100,
                                                          fontFamily: "Outfit"
                                                      ),
                                                      controller: fromController,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          from = value;
                                                        });
                                                      },
                                                      decoration: InputDecoration(
                                                          labelText: "From",
                                                          labelStyle: TextStyle(
                                                              fontFamily:
                                                              "Outfit",
                                                              fontWeight:
                                                              FontWeight.w100,
                                                              fontSize: 18)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: TextField(
                                                      style: TextStyle(
                                                          fontWeight:FontWeight.w100,
                                                          fontFamily: "Outfit"
                                                      ),
                                                      controller: toController,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          to = value;
                                                        });
                                                      },
                                                      decoration: InputDecoration(
                                                          labelText: "To",
                                                          labelStyle: TextStyle(
                                                              fontFamily:
                                                              "Outfit",
                                                              fontWeight:
                                                              FontWeight.w100,
                                                              fontSize: 18)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: TextField(
                                                      style: TextStyle(
                                                          fontWeight:FontWeight.w100,
                                                          fontFamily: "Outfit"
                                                      ),
                                                      controller: descController,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          dec = value;
                                                        });
                                                      },
                                                      decoration: InputDecoration(
                                                        labelText: "Deccription",
                                                        labelStyle: TextStyle(
                                                            fontFamily: "Outfit",
                                                            fontWeight:
                                                            FontWeight.w100,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: TextField(
                                                      style: TextStyle(
                                                          fontWeight:FontWeight.w100,
                                                          fontFamily: "Outfit"
                                                      ),
                                                      controller: totalController,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          total = value;
                                                        });
                                                      },
                                                      decoration: InputDecoration(
                                                          labelText: "Total",
                                                          labelStyle: TextStyle(
                                                              fontFamily:
                                                              "Outfit",
                                                              fontWeight:
                                                              FontWeight.w100,
                                                              fontSize: 18)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: TextField(
                                                      style: TextStyle(
                                                          fontWeight:FontWeight.w100,
                                                          fontFamily: "Outfit"
                                                      ),
                                                      controller:
                                                      advanceController,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          advance = value;
                                                        });
                                                      },
                                                      decoration: InputDecoration(
                                                          labelText: "Advance",
                                                          labelStyle: TextStyle(
                                                              fontFamily:
                                                              "Outfit",
                                                              fontWeight:
                                                              FontWeight.w100,
                                                              fontSize: 18)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: TextField(
                                                      style: TextStyle(
                                                          fontWeight:FontWeight.w100,
                                                          fontFamily: "Outfit"
                                                      ),
                                                      controller:
                                                      balanceController,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          balance = value;
                                                        });
                                                      },
                                                      decoration: InputDecoration(
                                                        labelText: "Balance",
                                                        labelStyle: TextStyle(
                                                            fontFamily: "Outfit",
                                                            fontWeight: FontWeight.w100,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    style:
                                                    ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                      Colors.black,
                                                      foregroundColor:
                                                      Colors.white,
                                                      minimumSize: Size(
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                              0.3,
                                                          55),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        dataList[index]['name'] =
                                                            NameController.text;
                                                        dataList[index]['phone'] =
                                                            phoneController.text;
                                                        dataList[index]['date'] =
                                                            dateController.text;
                                                        dataList[index]['from'] =
                                                            fromController.text;
                                                        dataList[index]['to'] =
                                                            toController.text;
                                                        dataList[index]
                                                        ['description'] =
                                                            descController.text;
                                                        dataList[index]['total'] =
                                                            totalController.text;
                                                        dataList[index]
                                                        ['advance'] =
                                                            advanceController
                                                                .text;
                                                        dataList[index]
                                                        ['balance'] =
                                                            balanceController
                                                                .text;
                                                      });
                                                      saveData(); // Save the updated data
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Update",
                                                      style: TextStyle(
                                                          fontFamily: "Outfit",fontWeight: FontWeight.w100
                                                      ),

                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        icon:
                                        Icon(Icons.edit, color: Colors.black),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            dataList.removeAt(index);
                                          });
                                          saveData(); // Save the updated data
                                        },
                                        icon: Icon(Icons.delete,
                                            color: Colors.black),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          TextEditingController total1 = TextEditingController(text: item1['total']);
                                          TextEditingController paid = TextEditingController(text: item1['advance']);
                                          TextEditingController balance1 = TextEditingController(text: item1['balance']);
                                          TextEditingController received = TextEditingController(text: item1['received']);
                                          AlertDialog alert = AlertDialog(
                                            title: Text("Collect",style: TextStyle(
                                                fontFamily: "Outfit",fontWeight: FontWeight.w100
                                            ),),
                                            actions: [
                                              TextFormField(
                                                style: TextStyle(
                                                    fontWeight:FontWeight.w100,
                                                    fontFamily: "Outfit"
                                                ),
                                                onChanged: (value) {
                                                  updateBalanceInDialog(   total1,
                                                    paid,
                                                    balance1,
                                                    received,);
                                                },
                                                controller: total1,
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: "Total",
                                                  labelStyle: TextStyle(
                                                      fontFamily: "Outfit",
                                                      fontWeight: FontWeight.w100
                                                  ),


                                                  prefixIcon: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Icon(Icons.description),
                                                  ),
                                                ),
                                              ),
                                              TextFormField(
                                                style: TextStyle(
                                                    fontWeight:FontWeight.w100,
                                                    fontFamily: "Outfit"
                                                ),

                                                onChanged: (value) {
                                                  updateBalanceInDialog(
                                                    total1,
                                                    paid,
                                                    balance1,
                                                    received,
                                                  );
                                                },
                                                controller: paid,
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: "Advance Amount ₹",
                                                  labelStyle: TextStyle(
                                                      fontFamily: "Outfit",
                                                      fontWeight: FontWeight.w100

                                                  ),
                                                  prefixIcon: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Icon(Icons.payment),
                                                  ),
                                                ),
                                              ),
                                              TextFormField(
                                                style: TextStyle(
                                                    fontWeight:FontWeight.w100,
                                                    fontFamily: "Outfit"
                                                ),
                                                onChanged: (value) {
                                                  updateBalanceInDialog(
                                                    total1,
                                                    paid,
                                                    balance1,
                                                    received,
                                                  );
                                                },
                                                controller: balance1,
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: "Balance",
                                                  labelStyle: TextStyle(
                                                      fontFamily: "Outfit",
                                                      fontWeight: FontWeight.w100
                                                  ),
                                                  prefixIcon: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Icon(Icons.description),
                                                  ),
                                                ),
                                              ),
                                              TextFormField(
                                                style: TextStyle(
                                                    fontWeight:FontWeight.w100,
                                                    fontFamily: "Outfit"
                                                ),
                                                controller: received,
                                                onChanged: (value) {
                                                  updateBalanceInDialog(
                                                    total1,
                                                    paid,
                                                    balance1,
                                                    received,
                                                  );
                                                },
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                  labelText: "Received",
                                                  labelStyle: TextStyle(
                                                      fontFamily: "Outfit",
                                                      fontWeight: FontWeight.w100
                                                  ),
                                                  prefixIcon: Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Icon(Icons.description),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: DropdownButtonFormField<String>(
                                                  decoration: InputDecoration(
                                                    labelText: 'Select Payment Mode', // Set your label text here
                                                  ),
                                                  dropdownColor: Colors.blue,
                                                  style: TextStyle(color: Colors.black, fontSize: 15,
                                                      fontFamily: "Outfit",fontWeight: FontWeight.w100
                                                  ),
                                                  isExpanded: true,
                                                  value: option,
                                                  items: payProvider.pay.map<DropdownMenuItem<String>>(
                                                        (Map<String, String> item) => DropdownMenuItem<String>(
                                                      value: item['Paymentmode']!,
                                                      child: Text(item['Paymentmode']!),
                                                    ),
                                                  ).toList(),
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      option = value!;
                                                    });
                                                    // Handle dropdown value change if needed
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ElevatedButton(

                                                  style:ElevatedButton.styleFrom(

                                                      backgroundColor: Colors.black,
                                                      foregroundColor: Colors.white,
                                                      side: BorderSide(width:3, color:Colors.white), //border width and color
                                                      elevation: 5,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:BorderRadius.circular(10)
                                                      ) ),
                                                  onPressed: () {
                                                    updateBalanceInDialog(
                                                      total1,
                                                      paid,
                                                      balance1,
                                                      received,
                                                    );
                                                    setState(() {
                                                      dataList[index]["total"]=total1.text;
                                                      dataList[index]["advance"]=paid.text;
                                                      dataList[index]["balance"]=balance1.text;
                                                      dataList[index]["received"]=received.text;
                                                      dataList[index]["option"]=option!;

                                                    });
                                                    _addItemToList();
                                                    saveData();
                                                  },
                                                  child: Text("Save",style: TextStyle(
                                                      fontFamily: "Outfit",fontWeight: FontWeight.w100
                                                  ),),
                                                ),
                                              ),
                                            ],
                                          );

                                          // show the dialog
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alert;
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.add, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Text(
                                      "After Play",
                                      style: TextStyle(color: Colors.black,fontSize: 30,
                                          fontFamily: "Outfit",fontWeight: FontWeight.w100),

                                    ),
                                    ListTile(
                                      title:Text("Total: ${(item1["total"])}\n"
                                          "Advance: ${(item1["advance"])}\n"
                                          "Received:${(item1["received"])}\n"
                                          "Balance: ${(item1["balance"])}\n"
                                          "Payment Methods:${(item1)["option"]}",
                                        style: TextStyle(color: Colors.black,
                                            fontFamily: "Outfit",fontWeight: FontWeight.w100

                                        ),),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ): Center(child:Image.asset("assets/norecords.png"))

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


