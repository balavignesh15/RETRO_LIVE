import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'add expensive/cusdelete.dart';
import 'add expensive/expupdate.dart';
import 'add expensive/payactive.dart';
import 'bottom.dart';
import 'exp.dart';
import 'package:http/http.dart' as http;



class expcat extends StatefulWidget {
  const expcat({super.key});

  @override
  State<expcat> createState() => _expcatState();
}

class _expcatState extends State<expcat> {


  Future<List<Getallactive>> ? _getall;
  String? expenId;

  Future<List<Getallactive>> Get()async{
    var resp = await http.get(Uri.parse("http://turf.gtcollege.in/api/expenses/active"));
    var a = jsonDecode(resp.body);
    return (a as List).map((e) => Getallactive.fromJson(e)).toList();
  }

  Future<expupdate> Update(String one,String two,String Date , String Amount, String id) async{
    var resp = await http.post(Uri.parse("http://turf.gtcollege.in/api/expenses/update/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "expense_date": Date,
        "category_id": "C01",
        "category_expense": one,
        "expense_amount": Amount,
        "payment_id": "P01",
        "payment_mode":two,
        "attachment": "path of attachment",
        "admin_id": "A17",
        "admin_name": "prabha"
      }),
    );
    return expupdate.fromJson(jsonDecode(resp.body));
  }

  Future<expdelete> delete(String id) async{
    var resp = await http.post(Uri.parse("http://turf.gtcollege.in/api/expenses/delete/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{
            "admin_id": "A17",
            "admin_name": "prabha"
          }),
    );
    return expdelete.fromJson(jsonDecode(resp.body));
  }

  String dates = "";
  String caters = "";
  String spents = "";
  String payments="";


  List<Map<String, String>> datetime = [];
  @override
  void initState() {
    super.initState();
    // loadData();
    _getall = Get();

  }
  void loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.getString('datetime') ?? '[]';
    setState(() {
      datetime = List<Map<String, String>>.from(
        (json.decode(data) as List).map(
              (values) => Map<String, String>.from(values),
        ),
      );
    });
  }
  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('datetime', json.encode(datetime));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> bottomsample()));
            },
            child: Icon(Icons.arrow_back_rounded)),
        title: Text("Details",style: TextStyle(
            fontFamily: "Outfit",fontSize: 20,
            fontWeight: FontWeight.w100
        ),),
        backgroundColor: Colors.white,

        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(style:ElevatedButton.styleFrom(

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
                      builder: (context) => date(),
                    ),
                  );

                  // Update dataList with the returned data
                  if (result != null) {
                    setState(() {
                      datetime.add(result);
                      saveData();
                    });
                  }
                }, child: Text("Add",style: TextStyle(
                    fontFamily: "Outfit",fontWeight: FontWeight.w100,
                    color: Colors.white
                ),)),
          ),
        ],
      ),
      body: Center(
        child:
        FutureBuilder(
            future: _getall,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<Getallactive> data = snapshot.data!;
                  return
                    ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          var items = data[index];
                          TextEditingController(text: items.expenseDate);
                          TextEditingController(text: items.expenseAmount.toString());

                          return Card(
                            color:Colors.white,
                            child: ListTile(
                              title: Text( data[index].expenseCategory !=null ?
                              "date:${items.expenseDate}\n"
                                  "Category: ${data[index].expenseCategory!.categoryExpense}\n"
                                  "SpentAmount:${items.expenseAmount}\n"
                                  "options:${items.spendMode!.paymentMode}" : "",
                                style: TextStyle(color: Colors.black,fontFamily: "Outfit",
                                    fontWeight: FontWeight.w100),
                              ),
                              trailing: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          expenId = items.expenseId;
                                        });
                                        TextEditingController dateController =
                                        TextEditingController(text: items.expenseDate);
                                        TextEditingController cater =
                                        TextEditingController(text: items.expenseCategory!.categoryExpense.toString());
                                        TextEditingController spentController =
                                        TextEditingController(text: items.expenseAmount.toString());
                                        TextEditingController option =
                                        TextEditingController(text: items.spendMode!.paymentMode.toString());
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
                                                    controller: dateController,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        dates = value;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                        labelText: "Date",
                                                        labelStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily: "Outfit",
                                                            fontWeight: FontWeight.w100,
                                                            fontSize: 18)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    controller: cater,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        caters = value;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText: "Category",
                                                      labelStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "Outfit",
                                                          fontWeight: FontWeight.w100,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    controller: spentController,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        spents = value;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                        labelText: "SpentAmount",
                                                        labelStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily: "Outfit",
                                                            fontWeight: FontWeight.w100,
                                                            fontSize: 18)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    controller: option,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        payments = value;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                      labelText: "payment mode",
                                                      labelStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontFamily: "Outfit",
                                                          fontWeight: FontWeight.w100,
                                                          fontSize: 18),
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
                                                            MediaQuery.of(context).size.width * 0.3, 40),),
                                                      onPressed: () async{
                                                        await Update(cater.text,option.text,dateController.text,spentController.text,expenId!);
                                                        setState(() {
                                                          _getall = Get();
                                                          // datetime[index]['date'] =
                                                          //     dateController.text;
                                                          // datetime[index]['drop'] =
                                                          //     cater.text;
                                                          // datetime[index]['amount'] =
                                                          //     spentController.text;
                                                          // datetime[index]['options'] =
                                                          //     option.text;
                                                        });
                                                        saveData(); // Save the updated data
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
                                                ),
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
                                            context: context,
                                            builder: (context)=> AlertDialog(
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
                                                      await delete(
                                                          items.expenseId!);

                                                      setState(() {
                                                        data.remove(items);
                                                      });
                                                      Navigator.pop(
                                                          context); // Close the dialog
                                                    },
                                                    child: Text("Delete"))
                                              ],
                                            ));

                                      },
                                      icon: Icon(Icons.delete,color: Colors.black,),
                                    ),
                                  ],
                                ),
                              ),


                            ),
                          );
                        });

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