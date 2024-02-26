import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart' as picker;
import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';

// import '../../Constants.dart';
// import '../Services/DashboardServices.dart';
// import '../Services/DropdownServices.dart';
// import '../Services/MainServices.dart';

class ReportServiceProvider extends StatefulWidget {
  const ReportServiceProvider({super.key});

  @override
  State<ReportServiceProvider> createState() => _ReportServiceProviderState();
}

class _ReportServiceProviderState extends State<ReportServiceProvider> {
  final reportServiceProvider = GlobalKey<FormState>();

  final picker.ImagePicker _picker = picker.ImagePicker();

  String id = "";
  File? billImage;
  bool viewAttachment = false;
  int selRTOId = 0;
  List selRTOList = [];
  String rtoName = "";
  String imgName = "";
  String pathTosave = "";
  String rtoOffice = "";
  String providerId = "";

  // VideoPlayerController? _controller;
  // bool isVideo = false;

  TextEditingController name = TextEditingController();
  TextEditingController remarks = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController rtooff = TextEditingController();

  @override
  void initState(){
    // name.text = Services.pref.getString("name").toString();
    // rtooff.text = Services.pref.getString("rtoOfficeName").toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // backgroundColor: mBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        // backgroundColor: mThemeColor,
        title: Text("Report Service Provider ", ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              // color: mWhiteColor,
            ),
            onPressed: () {
              // Get.back();
            }),
      ),
      body: Form(
        key: reportServiceProvider,
        child: ListView(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text("Upload Evidence ",),
                            Text("*",)
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Visibility(
                          visible: imgName.isEmpty,
                          child: GestureDetector(
                            onTap: () {
                              imageSelection();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 290),
                              child: Container(
                                height: 50,
                                width: 130,
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey.shade100,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Colors.grey.shade300)),
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
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible: imgName.isNotEmpty,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(imgName)),
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
              ListTile(
                leading: const Icon(Icons.video_camera_front),
                title: const Text(' Pick Video From Gallery'),
                onTap: () {
                  pickVideoFromGallery();
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.videocam),
                title: const Text(' Record video From Camera'),
                onTap: () {
                  pickVideoFromCamera();
                  Get.back();
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

  void pickVideoFromCamera() async {
    final XFile? photo = await _picker.pickVideo(source: ImageSource.camera);
    if (photo == null) {
      return;
    }
    setState(() {
      billImage = File(photo.path);
      // isVideo = true;
      imgName = photo.name;
    });
    // _controller = VideoPlayerController.file(billImage!);
    // _controller!.setLooping(true);
    // _controller!.initialize();
  }

  void pickVideoFromGallery() async {
    final XFile? photo = await _picker.pickVideo(source: ImageSource.gallery);
    if (photo == null) {
      return;
    }
    setState(() {
      billImage = File(photo.path);
      // isVideo = true;
      imgName = photo.name;
    });
    //
    // _controller = VideoPlayerController.file(billImage!);
    // _controller!.setLooping(true);
    // _controller!.initialize();
  }

  Widget inputFile(
      {label,
        hintText,
        controller,
        icon,
        keyboardType,
        validator,
        function,
        onChanged,
        color,
        focusNode,enabled}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
            visible: label.isNotEmpty,
            child: Row(
              children: [
                Text(label,
                    // style: color == "green"
                    //     ? mGreenLabelTextStyle
                    //     : mLabelTextStyle
              ),
                Visibility(
                  visible: validator != "",
                  child: Text(' *', ),
                ),
              ],
            )),
        const SizedBox(height: 5),
        TextFormField(
          focusNode: focusNode,
          enabled: enabled,
          // autofocus: true,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            errorMaxLines: 2,
            filled: true,
            // fillColor: mFillColor,
            prefixIcon: Icon(
              icon,
              // color: mIconColor,
            ),
            hintText: hintText,
            // hintStyle: mHintTextStyle,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            // enabledBorder: OutlineInputBorder(
            //     borderSide: BorderSide(color: mBorderSideColor)),
            // border: OutlineInputBorder(
            //     borderSide: BorderSide(color: mBorderSideColor)),
          ),
          onChanged: onChanged,
          validator: validator,

          onTap: () async {
            if (function != null) {
              function();
            }
          },
        ),
        const SizedBox(height: 5)
      ],
    );
  }
}