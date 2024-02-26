import 'package:flutter/material.dart';


class ExpenseData {
  DateTime? date;
  TimeOfDay? timeFrom;
  TimeOfDay? timeTo;

  ExpenseData({this.date, this.timeFrom, this.timeTo});
}

class Sample extends StatefulWidget {
  const Sample({Key? key}) : super(key: key);

  @override
  _SampleState createState() => _SampleState();
}

class _SampleState extends State<Sample> {
  late ExpenseData expenseData;
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay _time1 = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    expenseData = ExpenseData();
    _time = TimeOfDay.now();
  }


  final _key = GlobalKey<FormState>();

  void updateBalance() {
    double totalAmount = double.tryParse(total.text) ?? 0.0;
    double advanceAmount = double.tryParse(advance.text) ?? 0.0;
    double receivedAmount = double.tryParse(received.text) ?? 0.0;
    double balanceAmount = totalAmount - advanceAmount;
    if (selectedOption == 'Yes') {
      double balanceAmount = totalAmount - advanceAmount - receivedAmount;

      setState(() {
        balance.text = balanceAmount.toString();
      });

    }
    else{
      totalAmount=balanceAmount;
      setState(() {
        balance.text = balanceAmount.toString();
      });
    }

  }

  TextEditingController total = TextEditingController();
  TextEditingController advance = TextEditingController();
  TextEditingController balance = TextEditingController();
  TextEditingController received = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController yes =TextEditingController();
  TextEditingController no =TextEditingController();


  String selectedOption = "";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: expenseData.date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != expenseData.date) {
      setState(() {
        expenseData.date = picked;
        dateController.text = '${expenseData.date!.toLocal()}'.split(' ')[0];
      });
    }
  }

  DateTime? selectedTime;
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,

    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        timeController.text = '${_time.format(context)}';
        DateTime currentTime = DateTime.now();
        print("Current Time: ${currentTime.toLocal()}");
      });
    }
  }

  DateTime? selectedTimes;
  TextEditingController timesController = TextEditingController();

  Future<void> _selectTimes(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time1,
    );
    if (picked != null && picked != _time1) {
      setState(() {
        _time1 = picked;
        timesController.text = '${_time1.format(context)}';
      });
    }
  }

  void addItemList() {
    String text = phone.text;
    String text1 = name.text;
    String text2 = description.text;
    String text3 = total.text;
    String text4 = advance.text;
    String text5 = balance.text;
    String text6 = dateController.text;
    String text7 = timeController.text;
    String text8 = timesController.text;
    String text9=received.text;

    if (text.isNotEmpty &&
        text1.isNotEmpty &&
        text2.isNotEmpty &&
        text3.isNotEmpty &&
        // text4.isEmpty &&
        text5.isNotEmpty &&
        text6.isNotEmpty &&
        text7.isNotEmpty &&
        text8.isNotEmpty
    // text9.isNotEmpty

    ) {
      print("hi");
      setState(() {
        expenseData = ExpenseData(
          date: expenseData.date,
          timeFrom: _time,
          timeTo: _time1,
        );

        var items = {
          "phone": text,
          "name": text1,
          "description": text2,
          "total": text3,
          "advance": text4,
          "balance": text5,
          "date": text6,
          "from": text7,
          "to": text8,
          "received":text9,
        };
        Navigator.pop(context, items);
        print(items);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Slot Booking",  style: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100),),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,color: Colors.white),
                  controller: dateController,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: InputDecoration(

                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.payment,color: Colors.white,),
                    ),
                    labelText: "Date",
                    labelStyle:TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,color: Colors.white),
                  controller: phone,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.phone,color: Colors.white,),
                    ),
                    labelText: "Phone No",
                    labelStyle: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,color: Colors.white),
                  controller: name,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.person,color: Colors.white,),
                    ),
                    labelText: "Name",
                    labelStyle: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,color: Colors.white),
                  controller: description,
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,color: Colors.white),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.description,color: Colors.white,),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,color: Colors.white),
                  controller: timeController,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.timer,color: Colors.white,),
                    ),
                    labelText: "From",
                    labelStyle: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,color: Colors.white),
                  ),
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        timeController.text = pickedTime.format(context);
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,color: Colors.white),
                  controller: timesController,
                  readOnly: true,
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        timesController.text = pickedTime.format(context);
                      });
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.timer,color: Colors.white,),
                    ),
                    labelText: "To",
                    labelStyle: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white,fontFamily: "Outfit",fontWeight: FontWeight.w100),

                  onChanged: (value) {
                    updateBalance();
                  },
                  controller: total,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Total Amount ₹",
                    labelStyle: TextStyle(
                        color: Colors.white,
                        fontFamily: "Outfit",
                        fontWeight: FontWeight.w100
                    ),




                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.payment,color: Colors.white,),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Advance Received: $selectedOption', style: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,color: Colors.white),
              ),
              RadioListTile(
                title: Text('Yes', style: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,color: Colors.white),),
                value: 'Yes',
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value.toString();
                    updateBalance();
                  });
                },
              ),
              RadioListTile(
                title: Text('No' ,style: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,color: Colors.white),),
                value: 'No',
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() {
                    selectedOption = value.toString();
                    print(selectedOption);
                    updateBalance();

                  });
                },
              ),
              if (selectedOption == 'Yes')
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(
                            color: Colors.white,fontFamily: "Outfit",fontWeight: FontWeight.w100
                        ),

                        onChanged: (value) {
                          updateBalance();
                        },
                        controller: advance,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Advance Amount ₹",
                          labelStyle: TextStyle(
                              color: Colors.white,fontFamily: "Outfit",fontWeight: FontWeight.w100
                          ),

                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.payment,color: Colors.white,),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(
                            color: Colors.white,fontFamily: "Outfit",fontWeight: FontWeight.w100
                        ),

                        controller: balance,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Balance Amount ₹",
                          labelStyle: TextStyle(
                              color: Colors.white,fontFamily: "Outfit",fontWeight: FontWeight.w100
                          ),


                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.do_not_disturb_on_total_silence,color: Colors.white,),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        style: TextStyle(
                            color: Colors.white,fontFamily: "Outfit",fontWeight: FontWeight.w100
                        ),
                        onChanged: (value) {
                          updateBalance();
                        },
                        controller: received,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Received Amount ₹",
                          labelStyle: TextStyle(
                              color: Colors.white,fontFamily: "Outfit",fontWeight: FontWeight.w100
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.do_not_disturb_on_total_silence,color: Colors.white,),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ElevatedButton(style: ElevatedButton.styleFrom(
                  minimumSize: (Size(150, 50)),
                  primary: Colors.white,
                  onPrimary: Colors.white,
                  side: BorderSide(width:3, color:Colors.black), //border width and color
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  )),
                onPressed: () {
                  addItemList();
                },
                child: Text("Save", style: TextStyle(fontFamily: "Outfit",fontWeight: FontWeight.w100,
                    color: Colors.black),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


