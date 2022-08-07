import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:todo/screens/EditTask.dart';
import 'package:todo/screens/addTask.dart';
import 'package:todo/screens/sign_in.dart';
import 'package:todo/screens/splash.dart';
import 'package:todo/serviceNotifier/todo_service.dart';

import 'modal/todo.dart';

//Home Screen is stateless widget so you can check there is no use of setstate and purely use of provider

class Home extends StatelessWidget {
  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Do you want to exit?"),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            exit(0);
                          },
                          child: Text("Yes"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurpleAccent),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          print('no selected');
                          Navigator.of(context).pop();
                        },
                        child:
                            Text("No", style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String sdata = 'April 20, 2020';
    final User? user = auth.currentUser;
    final uid = user?.uid;
    List months = [
      'jan',
      'feb',
      'mar',
      'april',
      'may',
      'jun',
      'july',
      'aug',
      'Sep',
      'oct',
      'nov',
      'dec'
    ];
    var someDateTime = new DateTime.now();
    var mon = someDateTime.month;

    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTasks()),
          );
        },
      ),
      body: WillPopScope(
        onWillPop: () {
          return showExitPopup(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/home_mountain.png"),
                  fit: BoxFit.cover,
                ),
              ),
              height: 280,
              child: Row(
                children: [
                  Container(
                    width: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 35, 0, 0),
                          child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        //this right here
                                        child: Container(
                                          height: 180,
                                          width: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // TextField(
                                                //   decoration: InputDecoration(
                                                //       border: InputBorder.none,
                                                //       hintText: 'What do you want to remember?'),
                                                // ),
                                                SizedBox(
                                                  width: 320.0,
                                                  child: RaisedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    AddTasks()),
                                                      );
                                                    },
                                                    child: Text(
                                                      "Add Tasks",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 320.0,
                                                  child: RaisedButton(
                                                    onPressed: () {
                                                      Navigator
                                                          .pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SplashScreen()),
                                                        (Route<dynamic>
                                                                route) =>
                                                            false,
                                                      );
                                                    },
                                                    child: Text(
                                                      "Logout",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 320.0,
                                                  child: RaisedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "Close",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Icon(
                                CupertinoIcons.text_justifyleft,
                                color: Colors.white,
                              )),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Your ',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontFamily: "Poppins",
                                      color: Colors.white),
                                ),
                                TextSpan(
                                  text: '\nThings',
                                  style: TextStyle(
                                      fontSize: 35,
                                      fontFamily: "Poppins",
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 0, 10),
                          child: Text(
                              months[mon] +
                                  " " +
                                  DateTime.now().day.toString() +
                                  ", " +
                                  DateTime.now().year.toString(),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Poppins",
                                  color: Colors.grey)),
                        ),
                        LinearProgressIndicator()
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "27",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: "BalooBhai2",
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    TextSpan(
                                      text: '\nPersonal',
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "11",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: "BalooBhai2",
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    TextSpan(
                                      text: '\nBusiness',
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                  height: 30,
                                  width: 40,
                                  child: _buildRangePointerExampleGauge()),
                              Text(
                                '65% done',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: Text(
                      'INBOX',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: Consumer<TodoService>(
                      builder: (context, value, child) {
                        if (value.todos.length > 0)
                          return ListView.builder(
                            itemCount: value.todos.length,
                            itemBuilder: (context, index) {
                              var outputFormat = DateFormat('hh a');
                              var outputDate = outputFormat
                                  .format(value.todos[index].taskTime.toDate());
                              print(outputDate);

                              return Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                child: ListTile(
                                  leading: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: value.todos[index].icon == ""
                                          ? Icon(
                                              CupertinoIcons.double_music_note,
                                              color: Colors.blueAccent,
                                            )
                                          : value.todos[index].icon == "0"
                                              ? Icon(
                                                  CupertinoIcons
                                                      .double_music_note,
                                                  color: Colors.blueAccent,
                                                )
                                              : value.todos[index].icon == "1"
                                                  ? Icon(
                                                      CupertinoIcons.pencil,
                                                      color: Colors.blueAccent,
                                                    )
                                                  : value.todos[index].icon ==
                                                          "2"
                                                      ? Icon(
                                                          CupertinoIcons
                                                              .arrow_2_circlepath_circle_fill,
                                                          color:
                                                              Colors.blueAccent,
                                                        )
                                                      : value.todos[index]
                                                                  .icon ==
                                                              "3"
                                                          ? Icon(
                                                              CupertinoIcons
                                                                  .app_badge_fill,
                                                              color: Colors
                                                                  .blueAccent,
                                                            )
                                                          : Icon(
                                                              CupertinoIcons
                                                                  .double_music_note,
                                                              color: Colors
                                                                  .blueAccent,
                                                            )),
                                  title: Text(
                                    value.todos[index].taskName,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    value.todos[index].taskDescription,
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  trailing: Text(
                                    outputDate,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            //this right here
                                            child: Container(
                                              height: 180,
                                              width: 100,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // TextField(
                                                    //   decoration: InputDecoration(
                                                    //       border: InputBorder.none,
                                                    //       hintText: 'What do you want to remember?'),
                                                    // ),
                                                    SizedBox(
                                                      width: 320.0,
                                                      child: RaisedButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        EditTask(
                                                                          email: value
                                                                              .todos[index]
                                                                              .email,
                                                                          place: value
                                                                              .todos[index]
                                                                              .place,
                                                                          selected: value
                                                                              .todos[index]
                                                                              .type,
                                                                          taskDesc: value
                                                                              .todos[index]
                                                                              .taskDescription,
                                                                          taskName: value
                                                                              .todos[index]
                                                                              .taskName,
                                                                          icon: value
                                                                              .todos[index]
                                                                              .icon,
                                                                          taskid: value
                                                                              .todos[index]
                                                                              .taskId,
                                                                          userid: value
                                                                              .todos[index]
                                                                              .userId,
                                                                        )),
                                                          );
                                                        },
                                                        child: Text(
                                                          "Edit Task",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        color: Colors
                                                            .deepPurpleAccent,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 320.0,
                                                      child: RaisedButton(
                                                        onPressed: () async {
                                                          circularProgress(
                                                              context,
                                                              "Deleting Task",
                                                              true);


                                                          //delete task using provider
                                                          context
                                                              .read<
                                                                  TodoService>()
                                                              .deleteTodo(value
                                                                  .todos[index]
                                                                  .taskId);

                                                          Timer(
                                                              Duration(
                                                                  seconds: 2),
                                                              () {
                                                            circularProgress(
                                                                context,
                                                                "Deleting Task",
                                                                false);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          });

                                                          // circularProgress(
                                                          //     context,
                                                          //     "Deleting Task",
                                                          //     true);
                                                          //
                                                          //
                                                          // await FirebaseFirestore.instance.collection('tasks')
                                                          //     .doc(snapshot.data!.docs[index].reference.id.toString()).delete().whenComplete(()  {
                                                          //   circularProgress(
                                                          //       context,
                                                          //       "Deleting Task",
                                                          //       false);
                                                          //   Navigator.pop(context);
                                                          // });
                                                        },
                                                        child: Text(
                                                          "Delete Task",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        color: Colors
                                                            .deepPurpleAccent,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 320.0,
                                                      child: RaisedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          "Close",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        color: Colors
                                                            .deepPurpleAccent,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  selected: true,
                                ),
                              );
                            },
                          );
                        else
                          return Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "No Task in list",
                                  style: TextStyle(
                                      fontFamily: "Poppins", fontSize: 15),
                                )),
                          );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  SfRadialGauge _buildRangePointerExampleGauge() {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
            showLabels: false,
            showTicks: false,
            startAngle: 270,
            endAngle: 270,
            radiusFactor: 0.8,
            axisLineStyle: const AxisLineStyle(
                thicknessUnit: GaugeSizeUnit.factor, thickness: 0.15),
            pointers: const <GaugePointer>[
              RangePointer(
                  value: 50,
                  cornerStyle: CornerStyle.bothCurve,
                  enableAnimation: true,
                  animationDuration: 1200,
                  sizeUnit: GaugeSizeUnit.factor,
                  gradient: SweepGradient(
                      colors: <Color>[Color(0xFF6A6EF6), Colors.blueAccent],
                      stops: <double>[0.25, 0.75]),
                  color: Color(0xFF00A8B5),
                  width: 0.15),
            ]),
      ],
    );
  }
}

// showAddTodo(context) {
//   String inputText;
//   GlobalKey<FormState> _formKey = GlobalKey();
//   showDialog(
//     context: context,
//     builder: (context) => Form(
//       key: _formKey,
//       child: AlertDialog(
//         title: Text("Add Todo"),
//         content: TextFormField(
//           onSaved: (text) {
//             inputText = text;
//           },
//           validator: (text) {
//             if (text.isEmpty) return "Todo can't be empty";
//             return null;
//           },
//           decoration: InputDecoration(hintText: "eg. brings apple"),
//         ),
//         actions: [
//           FlatButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text(
//               "Cancel",
//               style: TextStyle(
//                 color: Colors.grey,
//               ),
//             ),
//           ),
//           FlatButton(
//             onPressed: () {
//               if (_formKey.currentState.validate()) {
//                 _formKey.currentState.save();
//                 var read = context.read<TodoProvider>();
//                 read.addTodo(
//                   read.categoris[read.currentCategoryIndex].id,
//                   Todo(
//                     id: UniqueKey().toString(),
//                     title: inputText,
//                   ),
//                 );
//                 Navigator.pop(context);
//               }
//             },
//             child: Text("Add"),
//           ),
//         ],
//       ),
//     ),
//   );
// }
