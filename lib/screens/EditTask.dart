import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:todo/screens/sign_in.dart';
import 'package:todo/home.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../modal/todo.dart';
import '../serviceNotifier/todo_service.dart';

class EditTask extends StatefulWidget {
  String selected;
  String email;
  String taskName;
  String taskDesc;
  String place;
  String icon;
  String taskid;
  String userid;

  EditTask({
    required this.selected,
    required this.email,
    required this.taskName,
    required this.taskDesc,
    required this.place,
    required this.icon,
    required this.taskid,
    required this.userid,
  });

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController email = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController place = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController taskName = TextEditingController();
  String selectedValue = "Business";
  String icon = "";

  final List<String> items = [
    'Business',
    'Personal',
  ];

  @override
  void initState() {
    // TODO: implement initState
    email.text = widget.email;
    description.text = widget.taskDesc;
    place.text = widget.place;
    taskName.text = widget.taskName;
    selectedValue = widget.selected;
    icon = widget.icon;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.blueAccent, //change your color here
        ),
        backgroundColor: Colors.deepPurpleAccent,
        //foregroundColor: Colors.black,
        title: const Text(
          'Edit Task',
          style: TextStyle(
              fontSize: 18,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              CupertinoIcons.slider_horizontal_3,
              color: Colors.blueAccent,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.blueAccent,
                    ),
                    Container(
                      height: 75,
                      width: 75,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return VisibilityDetector(
                            key: Key("unique key"),
                            onVisibilityChanged: (VisibilityInfo info) {
                              debugPrint(
                                  "${info.visibleFraction} of my widget is visible");
                              print(index);
                              icon = index.toString();
                            },
                            child: Container(
                                height: 75,
                                width: 75,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50))),
                                child: icon == "0"
                                    ? Icon(
                                        CupertinoIcons.double_music_note,
                                        color: Colors.blueAccent,
                                      )
                                    : icon == "1"
                                        ? Icon(
                                            CupertinoIcons.pencil,
                                            color: Colors.blueAccent,
                                          )
                                        : icon == "2"
                                            ? Icon(
                                                CupertinoIcons
                                                    .arrow_2_circlepath_circle_fill,
                                                color: Colors.blueAccent,
                                              )
                                            : icon == "3"
                                                ? Icon(
                                                    CupertinoIcons
                                                        .app_badge_fill,
                                                    color: Colors.blueAccent,
                                                  )
                                                : Icon(
                                                    CupertinoIcons
                                                        .double_music_note,
                                                    color: Colors.blueAccent,
                                                  )),
                          );
                        },
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.blueAccent)
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  //controller: this._emailController,
                  cursorColor: Colors.grey,

                  decoration: InputDecoration(
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),

                      //  labelText: n,
                      label: Text(
                        selectedValue,
                        style: TextStyle(
                            color: Colors.white, fontFamily: "Poppins"),
                      ),
                      suffixIcon: Container(
                        width: 20,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,

                            items: items
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value.toString();
                                print(selectedValue);
                              });
                            },
                            // value: selectedValue,

                            icon: const Icon(
                              Icons.arrow_drop_down_outlined,
                            ),
                            iconSize: 14,
                            iconEnabledColor: Colors.yellow,
                            iconDisabledColor: Colors.grey,
                            buttonHeight: 60,
                            buttonWidth: MediaQuery.of(context).size.width,
                            buttonPadding: EdgeInsets.only(left: 0, right: 14),
                            // buttonDecoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(14),
                            //   border: Border.all(
                            //     color: Colors.black26,
                            //   ),
                            //   color: Colors.redAccent,
                            // ),
                            buttonElevation: 2,
                            itemHeight: 40,
                            itemPadding:
                                const EdgeInsets.only(left: 14, right: 14),
                            dropdownMaxHeight: 200,
                            dropdownWidth: 200,
                            dropdownPadding: null,
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.deepPurpleAccent,
                            ),
                            dropdownElevation: 8,
                            scrollbarRadius: const Radius.circular(40),
                            scrollbarThickness: 6,
                            scrollbarAlwaysShow: true,
                            offset: const Offset(-20, 0),
                          ),
                        ),
                      ),
                      hintStyle: const TextStyle(
                          fontSize: 15,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      labelStyle: const TextStyle(color: Color(0xFF424242))),
                ),
                SizedBox(
                  height: 8,
                ),
                textfield("Enter your email", email),
                SizedBox(
                  height: 8,
                ),
                textfield("Enter Task Name", taskName),
                SizedBox(
                  height: 8,
                ),
                textfield("Enter Task Description", description),
                SizedBox(
                  height: 8,
                ),
                textfield("Enter Place", place),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width / 1,
                  child: ElevatedButton(
                    child: Text("Add your thing".toUpperCase(),
                        style: TextStyle(fontSize: 14)),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide(color: Colors.blue)))),
                    onPressed: () async {
                      try {
                        String selected1;
                        String email1;
                        String taskname1;
                        String desc1;
                        String place1;
                        String icon1;
                        if (email.text == widget.email) {
                          email1 = widget.email;
                        } else {
                          email1 = email.text;
                        }

                        if (taskName.text == widget.taskName) {
                          taskname1 = widget.taskName;
                        } else {
                          taskname1 = taskName.text;
                        }

                        if (description.text == widget.taskDesc) {
                          desc1 = widget.taskDesc;
                        } else {
                          desc1 = description.text;
                        }

                        if (place.text == widget.place) {
                          place1 = widget.place;
                        } else {
                          place1 = place.text;
                        }

                        if (selectedValue == widget.selected) {
                          selected1 = widget.selected;
                        } else {
                          selected1 = selectedValue;
                        }

                        if (icon == widget.icon) {
                          icon1 = widget.icon;
                        } else {
                          icon1 = icon;
                        }

                        if (email.text != null &&
                            description.text != null &&
                            place.text != null &&
                            email.text != "" &&
                            description.text != "" &&
                            place.text != "") {

                          //loader true
                          circularProgress(context, "Editing Task", true);


                          //use of provider
                          context.read<TodoService>().updateTodo(Todo(
                              icon: icon1,
                              taskDescription: desc1,
                              email: email1,
                              place: place1,
                              taskName: taskname1,
                              taskTime: Timestamp.now(),
                              type: selected1,
                              taskId: widget.taskid,
                              userId: widget.userid));

                          Timer(Duration(seconds: 2), () {

                            //loader false
                            circularProgress(context, "Adding Task", false);


                            //navigate to home screen
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                              (Route<dynamic> route) => false,
                            );
                          });
                        } else {
                          Fluttertoast.showToast(
                            msg: "Enter Valid Details",
                            toastLength: Toast.LENGTH_SHORT,
                            backgroundColor: Colors.red,
                            gravity: ToastGravity.BOTTOM,
                          );
                        }
                      } catch (e) {
                        print(e.toString());

                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  //textfield widget
  Widget textfield(String hint, TextEditingController c) {
    return TextField(
      controller: c,
      style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
      //controller: this._emailController,
      cursorColor: Colors.grey,

      decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          hintText: hint,
          suffixIcon: IconButton(
            onPressed: () {
              c.clear();
            },
            icon: Container(
              height: 18,
              width: 18,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: const Icon(
                Icons.clear,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          hintStyle: const TextStyle(
              fontSize: 15,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
              color: Colors.grey),
          labelStyle:
              const TextStyle(color: Colors.white, fontFamily: "Poppins")),
    );
  }
}
