import 'package:cloud_firestore/cloud_firestore.dart';

import '../modal/todo.dart';

class FirestoreService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //update task
  updatetask(String docid, Todo todo) async {
    var documentID = docid;
    await firestore.collection("tasks").doc(documentID).update(todo.toMap());
  }


  //remove task
  removetask(String taskId) async {
    var documentID = taskId;
    await firestore.collection('tasks').doc(taskId).delete();
  }
}
