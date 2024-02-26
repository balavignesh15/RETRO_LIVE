import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart' as picker;
import 'package:intl/intl.dart';
import 'package:liveretro_project/payment/payget.dart';
import 'package:provider/provider.dart';

import 'add expensive/catactive.dart';
import 'add expensive/expcreate.dart';
import 'class.dart';
import 'package:http/http.dart' as http;

import 'expshow.dart';
class date extends StatefulWidget {
  const date({super.key});

  @override
  State<date> createState() => _dateState();
}

class _dateState extends State<date> {

  TextEditingController date=TextEditingController();
  TextEditingController amount=TextEditingController();

  String? option;

  String ?category;

  Future<expcreate> ? _Create;

  List<String> categoryOptions = [];
  List<String> paymentOptions = [];
  String imgName = "";
  String pathTosave = "";
  File? billImage;

  final picker.ImagePicker _picker = picker.ImagePicker();

  Future<expcreate> Create(String Date,String exp, String Amount, String mode) async{
    var resp = await http.post(Uri.parse("http://turf.gtcollege.in/api/expenses/create"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "expense_date": Date,
        "category_id": "C01",
        "category_expense": exp,
        "expense_amount": Amount,
        "payment_id": "P01",
        "payment_mode": mode,
        "attachment": "path of attachment",
        "admin_id": "A17",
        "admin_name": "prabha"
      }),

    );
    print(resp.body);
    return expcreate.fromJson(jsonDecode(resp.body));
  }


  // Future<void> fetchDropdownOptions() async {
  //   // Replace "YOUR_DROPDOWN_API_URL" with the actual URL for your dropdown options API
  //   var response = await http.get(Uri.parse("http://turf.gtcollege.in/api/category/active"));
  //
  //   if (response.statusCode == 200) {
  //     // Assuming the API returns a List<String>
  //     List<String> options = List<String>.from(jsonDecode(response.body));
  //     setState(() {
  //       categoryOptions = options;
  //     });
  //   } else {
  //     // Handle API error
  //     print("Error fetching dropdown options: ${response.request}");
  //   }
  // }

  Future<List<Getall>> fetchPaymentOptions() async {
    // Replace "PAYMENT_API_URL" with the actual URL for payment options API
    var res = await http.get(Uri.parse("http://turf.gtcollege.in/api/payments/active"));
    var data = jsonDecode(res.body);
    print("http://turf.gtcollege.in/api/payments/active");
    print(res.body);
    return (data as List).map((e) => Getall.fromJson(e)).toList();
  }


  Future<List<catgetactive>> fetchcategoryOptions() async {
    // Replace "PAYMENT_API_URL" with the actual URL for payment options API
    var res = await http.get(Uri.parse("http://turf.gtcollege.in/api/category/active"));
    var data = jsonDecode(res.body);

    print("http://turf.gtcollege.in/api/category/active");
    print(data);
    return (data as List).map((e) => catgetactive.fromJson(e)).toList();
  }
  // @override
  // void initState() {
  //   super.initState();
  //   // fetchDropdownOptions();
  //   fetchPaymentOptions();
  // }

  // void _addItemToList()
  // {
  //   String text= date.text;
  //   String text1=amount.text;
  //   String ?options=option;
  //   String ? drop= category;
  //   if(text.isNotEmpty&&text1.isNotEmpty){
  //     setState(() {
  //       var values={
  //         "date":text,
  //         "amount":text1,
  //         "drop":drop??"",
  //         "options":options??"",
  //       };
  //       Navigator.pop(context,values);
  //     });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    // var catProvider = Provider.of<CatProvider>(context);
    // var payProvider = Provider.of<CatProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Add Expense"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body:
      SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(25),
            child: Container(
              alignment: Alignment.center,
              child: (_Create == null ? createColumn(): buildFutureBuilder()),
            )
        ),
      ),
    );
  }
  Column createColumn(){
    return
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontFamily: "Outfit",fontWeight: FontWeight.w100
                    ),
                    controller: date,
                    decoration: InputDecoration(
                      hintText: "Date",
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontFamily: "Outfit"
                      ),
                      prefixIcon: Icon(Icons.calendar_month),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        setState(() {
                          date.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                        });
                      }
                    },


                  ),
                ),
                FutureBuilder(
                  future: fetchcategoryOptions(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List<catgetactive> list2 = snapshot.data!;

                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: DropdownButtonFormField<String>(
                            dropdownColor: Colors.blue,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                            isExpanded: true,
                            value: category,
                            items: list2.map((catgetactive item) {
                              return DropdownMenuItem<String>(
                                value: item.expenseCategory,
                                child: ListTile(
                                    title: Text(item.expenseCategory!,style: TextStyle(color: Colors.white))),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                category = value!;
                              });
                              // Handle dropdown value change if needed
                            },
                            decoration: InputDecoration(
                              hintText: 'Select category',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                    }
                    return CircularProgressIndicator();
                  },
                ),



                // Padding(
                //     padding: const EdgeInsets.all(20),
                //     child: DropdownButtonFormField<String>(
                //       dropdownColor: Colors.blue,
                //       style: TextStyle(color: Colors.white, fontSize: 15),
                //       isExpanded: true,
                //       value: category,
                //       items: catProvider.cat
                //           .map<DropdownMenuItem<String>>(
                //             (Map<String, String> item) => DropdownMenuItem<String>(
                //           value: item['ABCD']!,
                //           child: Text(item['ABCD']!),
                //         ),
                //       ).toList(),
                //       onChanged: (String? value) {
                //         setState(() {
                //           category = value!;
                //         });
                //         // Handle dropdown value change if needed
                //       },
                //       decoration: InputDecoration(
                //         // You can customize the decoration as needed
                //           hintText: 'Select Category',
                //           hintStyle: TextStyle(
                //               color: Colors.white,
                //               fontFamily: "Outfit",
                //               fontWeight: FontWeight.w100
                //           )
                //       ),
                //     )
                //
                // ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontFamily: "Outfit",
                        fontWeight: FontWeight.w100
                    ),
                    controller: amount,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.date_range_rounded,),
                      labelText: 'Spent Amount',
                      labelStyle: TextStyle(fontWeight: FontWeight.w100,fontSize: 18,
                          fontFamily: "Outfit",color: Colors.white),),

                  ),
                ),

                FutureBuilder(
                  future: fetchPaymentOptions(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List<Getall> list1 = snapshot.data!;

                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: DropdownButtonFormField<String>(
                            dropdownColor: Colors.blue,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                            isExpanded: true,
                            value: option,
                            items: list1.map((Getall item) {
                              return DropdownMenuItem<String>(
                                value: item.paymentMode,
                                child: Text(item.paymentMode!),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                option = value!;
                              });
                              // Handle dropdown value change if needed
                            },
                            decoration: InputDecoration(
                              hintText: 'Select payment',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: "Outfit",
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                    }
                    return CircularProgressIndicator();
                  },
                ),

                // Padding(
                //     padding: const EdgeInsets.all(20),
                //     child: DropdownButtonFormField<String>(
                //       dropdownColor: Colors.blue,
                //       style: TextStyle(color: Colors.white, fontSize: 15),
                //       isExpanded: true,
                //       value: option,
                //       items: payProvider.pay
                //           .map<DropdownMenuItem<String>>(
                //             (Map<String, String> item) => DropdownMenuItem<String>(
                //           value: item['Paymentmode']!,
                //           child: Text(item['Paymentmode']!),
                //         ),
                //       ).toList(),
                //       onChanged: (String? value) {
                //         setState(() {
                //           option = value!;
                //         });
                //         // Handle dropdown value change if needed
                //       },
                //       decoration: InputDecoration(
                //         // You can customize the decoration as needed
                //           hintText: 'Select Payment',
                //           hintStyle: TextStyle(
                //               color: Colors.white,
                //               fontFamily: "Outfit",
                //               fontWeight: FontWeight.w100
                //           )
                //       ),
                //     )
                // ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(

                    children: [
                      Text('Attachment',style: TextStyle(fontWeight: FontWeight.w100,fontSize: 18,
                          fontFamily: "Outfit",color: Colors.white),),
                      Padding(
                        padding: const EdgeInsets.all(40),
                        // child: Center(
                        //   child: ElevatedButton(
                        //     onPressed: (){
                        //       // showImagePickerOption(context);
                        //     },
                        //     child: Text('Upload',style: TextStyle(color: Colors.black,fontFamily: "Outfit",fontWeight: FontWeight.w100),),
                        //     style: ElevatedButton.styleFrom(
                        //       primary: Colors.white,
                        //       onPrimary: Colors.white,
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(10)
                        //       ),
                        //     ),),
                        // ),
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Visibility(
                      visible: imgName.isEmpty,
                      child: GestureDetector(
                        onTap: () {
                          imageSelection();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.045,
                          width:  MediaQuery.of(context).size.width*0.3,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: Colors.white)),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.file_upload,
                                // color: mIconColor,
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                "Upload",
                                // style: mLabelTextStyle,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,

                    ),
                    Visibility(
                      visible: imgName.isNotEmpty,
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(imgName,style: TextStyle(color: Colors.white),)),
                          Visibility(
                            child: IconButton(
                              onPressed: () async {
                                if (billImage != null) {
                                  setState(() {
                                    Image.file(billImage!);
                                  });
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        // backgroundColor: mBackgroundColor,
                                        contentPadding:
                                        const EdgeInsets.all(20),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        title: Stack(
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                                  2.5,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: AspectRatio(
                                                  aspectRatio: 300 / 300,
                                                  child: Container(
                                                    child: billImage != null
                                                        ? Image.file(
                                                        billImage!)
                                                        : const Icon(
                                                        Icons
                                                            .image),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: InkWell(
                                                child: Container(
                                                  padding: EdgeInsets.all(
                                                      8.0), // Adjust the padding as needed
                                                  child: IconButton(
                                                    onPressed: () {
                                                      // Get.back();
                                                      // setState(() {
                                                      //   _controller!
                                                      //       .pause();
                                                      // });
                                                    },
                                                    icon: const Icon(
                                                        Icons.close),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  // EasyLoading.show(status: "Loading...");
                                }
                              },
                              icon: const Icon(
                                Icons.image,
                                size: 20,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Visibility(
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  imgName = "";
                                  pathTosave = "";
                                });
                              },
                              icon: const Icon(Icons.delete,
                                  size: 20, color: Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        Center(
                          child: MaterialButton(
                            minWidth: 150,
                            height: 50,
                            // color: mButtonColor,
                            onPressed: () async {
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text("Submit",),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: ElevatedButton(style: ElevatedButton.styleFrom(
                      minimumSize: (Size(150, 50)),
                      primary: Colors.white,
                      onPrimary: Colors.white,
                      side: BorderSide(width:3, color:Colors.black), //border width and color
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      )
                  ),onPressed: (){
                    setState(() {
                      _Create = Create(date.text,category.toString(),amount.text,option.toString());
                    });
                  }, child: Text("save",style: TextStyle(color: Colors.black,fontFamily: "Outfit",
                      fontWeight: FontWeight.w100,fontSize: 18),)),
                ),

              ],

            ),
          ),
        ],
      );



  }

  FutureBuilder<expcreate> buildFutureBuilder() {
    return FutureBuilder<expcreate>(
      future: _Create,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.expenseId != null) {
            Future.delayed(const Duration(milliseconds: 500), () {
              setState(() {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => expcat()),
                        (route) => false);
              });
            }
            );
          } else {
            return Text(style: TextStyle(color: Colors.white38), "Not Added");
          }
          // return Column(
          //   children: [
          //     Text(snapshot.data!.expenseDate!),
          //     Text(snapshot.data!.expenseAmount.toString()),
          //
          //   ],
          // );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }

  // Uint8List? _image;
  // File? selectedIMage;


  // ///image upload fuc
  // void showImagePickerOption(BuildContext context) {
  //   showModalBottomSheet(
  //       backgroundColor: Colors.blue[100],
  //       context: context,
  //       builder: (builder) {
  //         return Padding(
  //           padding: const EdgeInsets.all(18.0),
  //           child: SizedBox(
  //             width: MediaQuery.of(context).size.width,
  //             height: MediaQuery.of(context).size.height / 4.5,
  //             child: Row(
  //               children: [
  //                 Expanded(
  //                   child: InkWell(
  //                     onTap: () {
  //
  //                       _pickImageFromGallery();
  //                     },
  //                     child: const SizedBox(
  //                       child: Column(
  //                         children: [
  //                           Icon(
  //                             Icons.image,
  //                             size: 70,
  //                           ),
  //                           Text("Gallery")
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: InkWell(
  //                     onTap: () {
  //                       _pickImageFromCamera();
  //                     },
  //                     child: const SizedBox(
  //                       child: Column(
  //                         children: [
  //                           Icon(
  //                             Icons.camera_alt,
  //                             size: 70,
  //                           ),
  //                           Text("Camera")
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       });
  // }
  // Future _pickImageFromCamera() async {
  //   final returnImage =
  //   await ImagePicker().pickImage(source: ImageSource.camera);
  //   if (returnImage == null) return;
  //
  //   // setState(() {
  //   //   selectedIMage = File(returnImage.path);
  //   //   _image = File(returnImage.path).readAsBytesSync();
  //   // });
  //
  //   Navigator.of(context).pop();
  // }
  // Future _pickImageFromGallery() async {
  //   final returnImage =
  //   await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (returnImage == null) return;
  //
  //   // setState(() {
  //   //   selectedIMage = File(returnImage.path);
  //   //   _image = File(returnImage.path).readAsBytesSync();
  //   // });
  //
  //   Navigator.of(context).pop(); //close the model sheet
  // }

  void imageSelection() {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  pickImageFromGallery();
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  pickImageFromCamera();
                  // Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void pickImageFromCamera() async {
    picker.XFile? image = await _picker.pickImage(
        source: picker.ImageSource.camera, imageQuality: 100);
    if (image?.path != null) {
      billImage = File(image!.path);
      imgName = image.name;
    }
    if (mounted) setState(() {});
  }

  void pickImageFromGallery() async {
    picker.XFile? image = await _picker.pickImage(
        source: picker.ImageSource.gallery, imageQuality: 100);
    if (image?.path != null) {
      billImage = File(image!.path);
      imgName = image.name;
    }
    if (mounted) setState(() {});
  }


}
class ExpenseData {
  DateTime? date;
  String? category;
  String? amount;
  String? option;
  Uint8List? image;

  ExpenseData({this.date, this.category, this.amount,this.option, this.image});

}