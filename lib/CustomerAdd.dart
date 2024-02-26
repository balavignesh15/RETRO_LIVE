import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Customer_class/cuscreate.dart';
import 'display.dart';

class customer extends StatefulWidget {
  const customer({super.key});

  @override
  State<customer> createState() => _customerState();
}

class _customerState extends State<customer> {

  final key1 = GlobalKey<FormState>();

  int index=0;
  String dropdown="Admin";

  List <String>datalist=[];

  Future<cuscreate>? Data;
  var size,height,width;
  TextEditingController name=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController description=TextEditingController();

  void addItems(){
    String one = name.text;
    String two = phone.text;
    String three = description.text;
    if(one.isNotEmpty && two.isNotEmpty && three.isNotEmpty){
      setState(() {
        var items = {
          "customer_name": one,
          "phonenumber": two,
          "description": three,
          "admin_id":"A17",
          "admin_name":"prabha",
        };
        Navigator.pop(context,items);
      });
    }
  }




  Future<cuscreate> create(String name1,int number1,String description1)  async {
    var resp = await http.post(Uri.parse("http://turf.gtcollege.in/api/customers/create"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "customer_name": name1,
        "phonenumber": number1,
        "description": description1,
        "admin_id":"A17",
        "admin_name":"prabha",
      }),
    );
    return cuscreate.fromJson(jsonDecode(resp.body));
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: key1,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(

          title: Text("Retro Station",style: TextStyle(color: Colors.black,
              fontFamily: "Outfit",fontWeight: FontWeight.w100,fontSize: 20

          ),),centerTitle: true,
          backgroundColor:Colors.white,

        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height*2,
            width: MediaQuery.of(context).size.width*1,
            child: Column(
              children: [SizedBox(height:MediaQuery.of(context).size.height*0,),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.white
                    ),
                    controller: name,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,color: Colors.white,),
                        hintText: "Enter Customer Name",
                        hintStyle: TextStyle(color: Colors.white,
                            fontFamily: "Outfit",fontWeight: FontWeight.w100,
                            fontSize: 18
                        )
                    ),
                    validator: (value){
                      if (value == null || value.isEmpty){
                        return "please enter Customer Name";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(

                      style: TextStyle(
                          color: Colors.white
                      ),
                      controller: phone,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.contact_mail_sharp,color: Colors.white,),
                          hintText: "Enter Phone Number",
                          hintStyle: TextStyle(color: Colors.white,
                              fontFamily: "Outfit",fontWeight: FontWeight.w100,
                              fontSize: 18)
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter valid Phone number";
                        }
                        return null;
                      }
                  ),
                ),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                      style: TextStyle(
                          color: Colors.white
                      ),
                      controller: description,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password_outlined,color: Colors.white,),
                          hintText: "Enter Description",
                          hintStyle: TextStyle(color: Colors.white,
                              fontFamily: "Outfit",fontWeight: FontWeight.w100,
                              fontSize: 18)
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter Description";
                        }
                        return null;
                      }
                  ),
                ),
                SizedBox(height: 30,),
                ElevatedButton(style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: Size(MediaQuery.of(context).size.width*0.6,45)
                ),
                    onPressed: (){
                      if (key1.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                      setState(() {
                        Data = create(name.text,int.parse(phone.text),description.text);
                        addItems();
                      });
                    },
                    child: Text("Save",style: TextStyle(color: Colors.black,
                        fontFamily: "Outfit",fontWeight: FontWeight.w100,
                        fontSize: 18))),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}