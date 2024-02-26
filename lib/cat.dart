import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'category/category.dart';

class exppage extends StatefulWidget {
  const exppage({super.key});

  @override
  State<exppage> createState() => _exppageState();
}

class _exppageState extends State<exppage> {

  TextEditingController cnt= TextEditingController();

  Future<category>ca(String c)async {
    var cats=await http.post(Uri.parse("http://turf.gtcollege.in/api/category/create"),
        headers: <String,String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String,dynamic>{
          "expense_category":c,
          "admin_id":"A17",
          "admin_name":"prabha"
        })
    );
    return category.fromJson(jsonDecode(cats.body));
  }

  void _addItemToList()
  {
    String text= cnt.text;
    if(text.isNotEmpty){
      setState(() {
        var items={
          "ABCD":text,
        };
        Navigator.pop(context,items);
      });

    }
  }
  String text1="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor:Colors.white,
        title: Text("Expense Category",style: TextStyle(
            color: Colors.black,
            fontFamily: "Outfit",fontWeight: FontWeight.w100,
            fontSize: 22
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Category",style: TextStyle(
                    fontFamily: "Outfit",fontWeight: FontWeight.w100,
                    fontSize: 24,
                    color: Colors.white
                ),),

                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    height: 80,
                    width: 180,
                    child: TextFormField(
                      controller: cnt,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Enter your Expense",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: 160,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: (Size(150, 50)),
                      primary: Colors.white,
                      onPrimary: Colors.white,
                      side: BorderSide(width:3, color:Colors.black), //border width and color
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),
                  onPressed: ()async{
                    await ca(cnt.text);
                    setState(() {
                      _addItemToList();
                    });
                  },
                  child: Text("Save",style: TextStyle(fontWeight: FontWeight.w100,
                      color: Colors.black,fontFamily: "Outfit",fontSize: 18
                  ),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
