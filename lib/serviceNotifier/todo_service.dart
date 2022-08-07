import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/modal/todo.dart';

import '../firebase/firestoreService.dart';

class TodoService with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static FirestoreService _firestoreService = FirestoreService();
  List<Todo> todos = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TodoService() {
    loadTasks();
  }


  //load task list from database
  loadTasks() async {
    final User? user = auth.currentUser;
    await firestore.collection("tasks").where("userid",isEqualTo:user?.uid ).get().then((docs) {
      docs.docs.forEach((doc) {
        print(docs);
        todos.add(Todo.fromMap(doc.data()));
      });
    });
    notifyListeners();
  }


  //add task in database
  addTodo(Todo todo) async {
    await firestore.collection('tasks').doc(todo.taskId).set({
      "type": todo.type,
      "email": todo.email,
      "description": todo.taskDescription,
      "place": todo.place,
      "time": DateTime.now(),
      "taskName": todo.taskName,
      "icon": todo.icon,
      "userid": todo.userId,
      "taskId": todo.taskId
    }).then((value) {
      todos.add(todo);
    });
    notifyListeners();
  }


  //update data in database
  updateTodo(Todo todo) async {
    int catIndex = todos.indexWhere((cat) => cat.taskId == todo.taskId);
    todos[catIndex].type = todo.type;
    todos[catIndex].taskName = todo.taskName;
    todos[catIndex].email = todo.email;
    todos[catIndex].taskDescription = todo.taskDescription;
    todos[catIndex].place = todo.place;
    todos[catIndex].icon = todo.icon;
    _firestoreService.updatetask(todo.taskId, todos[catIndex]);

    notifyListeners();
  }


  //delete task from database
  deleteTodo(String taskId) async {
    todos.removeWhere((cat) => cat.taskId == taskId);
    _firestoreService.removetask(taskId);
    notifyListeners();
  }
}
