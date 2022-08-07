import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Todo {
  String taskDescription;
  String email;
  String icon;
  String place;
  String taskName;
  String taskId;
  Timestamp taskTime;
  String type;
  String userId;

  Todo({
    required this.icon,
    required this.taskDescription,
    required this.email,
    required this.place,
    required this.taskName,
    required this.taskId,
    required this.taskTime,
    required this.type,
    required this.userId,
  });


  //converting doc from map
  static Todo fromMap(Map<String, dynamic> map) {
    return Todo(
        type: map['type'],
        email: map['email'],
        taskDescription: map['description'],
        place: map['place'],
        taskTime: map['time'],
        icon: map['icon'],
        userId: map['uderid'],
        taskId: map["taskId"],
        taskName: map['taskName']);
  }


  //converting doc to map
  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "email": email,
      "description": taskDescription,
      "place": place,
      "time": DateTime.now(),
      "taskName": taskName,
      "icon": icon,
      "userid": userId,
      "taskId": taskId
    };
  }

  //converting doc to json(When using APIs)
  String toJson() => json.encode(toMap());

  //converting doc from json(When using APIs)
  static Todo fromJson(String source) => fromMap(json.decode(source));
}
