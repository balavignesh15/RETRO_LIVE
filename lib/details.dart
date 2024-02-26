import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:liveretro_project/user/create.dart';


class details extends StatefulWidget {
  const details({super.key});

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {
  final _key = GlobalKey<FormState>();
  int index = 0;
  String dropdown = "Admin";
  String drpId = "U01";

  List <String>datalist = [];

  var size, height, width;
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<create>? _future;

  Future<create> fetch(String id, String name, String user, String pass) async {
    var a = await http.post(Uri.parse("http://turf.gtcollege.in/api/users"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }, body: jsonEncode(<String, dynamic>{
        "user_id": id,
        "user_type": "admin",
        "name": name,
        "username": user,
        "password": pass,
        "admin_id": "A17",
        "admin_name": "prabha"
      }),
    );
    return create.fromJson(jsonDecode(a.body));
  }

  void additemList() {
    String text = name.text;
    String user = username.text;
    String pass = password.text;
    String usertype = dropdown;
    if (text.isNotEmpty && user.isNotEmpty && pass.isNotEmpty) {
      setState(() {
        var newItem = {
          'Name': text,
          'Username': user,
          'Password': pass,
          "Dropdown": usertype,
        };
        // Pass data back to the show screen
        Navigator.pop(context, newItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Retro Station", style: TextStyle(color: Colors.black,
            fontFamily: "Outfit", fontWeight: FontWeight.w100, fontSize: 20
        ),), centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: buildmodes()
        ),
      ),
    );
  }

  Column buildmodes() {
    return Column(
      children: [
        Form(
          key: _key,
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height * 2,
            width: MediaQuery
                .of(context)
                .size
                .width * 1,
            child: Column(
              children: [SizedBox(height: MediaQuery
                  .of(context)
                  .size
                  .height * 0,),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text("Usertype:", style: TextStyle(color: Colors
                            .white,
                            fontFamily: "Outfit", fontWeight: FontWeight.w100,
                            fontSize: 18),),
                      ),
                      SizedBox(width: 10,),
                      DropdownButton<String>(
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: Colors.blue,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                        value: dropdown,

                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: <String>["User", "Admin",].map<DropdownMenuItem<
                            String>>((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item, style: TextStyle(color: Colors.white),),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdown = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.white
                    ),
                    controller: name,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Colors.white,),
                        hintText: "Enter Name",
                        hintStyle: TextStyle(color: Colors.white,
                            fontFamily: "Outfit", fontWeight: FontWeight.w100,
                            fontSize: 18
                        )
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 4) {
                        return 'plesae enter valid name';
                      }
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
                    controller: username,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.contact_mail_sharp, color: Colors.white,),
                        hintText: "Enter UserName",
                        hintStyle: TextStyle(color: Colors.white,
                            fontFamily: "Outfit", fontWeight: FontWeight.w100,
                            fontSize: 18)
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 4) {
                        return 'plesae enter valid username';
                      }
                    },
                  ),
                ),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.white
                    ),
                    controller: password,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.password_outlined, color: Colors.white,),
                        hintText: "Enter Password",
                        hintStyle: TextStyle(color: Colors.white,
                            fontFamily: "Outfit", fontWeight: FontWeight.w100,
                            fontSize: 18)
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 4) {
                        return 'plesae enter valid password';
                      }
                    },
                  ),
                ),
                SizedBox(height: 30,),
                ElevatedButton(style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    minimumSize: Size(MediaQuery
                        .of(context)
                        .size
                        .width * 0.6,
                        45)
                ), onPressed: () async {
                  if (_key.currentState!.validate()) {
                    await fetch(
                        drpId,
                        name.text,
                        username.text,
                        password.text
                    );
                    setState(() {
                      additemList();
                    });
                  }
                }, child: Text("Enter", style: TextStyle(color: Colors.black,
                    fontFamily: "Outfit", fontWeight: FontWeight.w100,
                    fontSize: 18))),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
//   FutureBuilder<create> buildFutureBuilder() {
//     return FutureBuilder<create>(
//       future: _future,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return Column(
//             children: [
//               Text(snapshot.data!.name.toString()),
//               Text(snapshot.data!.username.toString()),
//               Text(snapshot.data!.password.toString()),
//             ],
//           );
//         } else if (snapshot.hasError) {
//           return Text('${snapshot.error}');
//         }
//         return const CircularProgressIndicator();
//       },
//     );
//   }
// }
}


