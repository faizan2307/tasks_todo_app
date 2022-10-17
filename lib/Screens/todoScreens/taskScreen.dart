import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:tasks_todo_app/Materials/addListComponent.dart';
import 'package:tasks_todo_app/Models/lists.dart';

import 'package:tasks_todo_app/Utils/fireStoreFunctions.dart';

class NewMainScreenFirebase extends StatefulWidget {
  static const String id = 'NewMainScreenFirebaseFirebase';

  @override
  _NewMainScreenFirebaseState createState() => _NewMainScreenFirebaseState();
}

class _NewMainScreenFirebaseState extends State<NewMainScreenFirebase> {
  FirestoreFunctions firestoreFunctions = FirestoreFunctions(
      collectionReference:
          FirebaseFirestore.instance.collection('tasksCollection'));
  CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance.collection('tasksCollection');
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragStart: (_) async{
            setState(() {
              isVisible = isVisible ? false : true;
            });
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Center(
                  child: Text(
                    'My List',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              Visibility(
                visible: isVisible,
                child: Expanded(
                  flex: 1,
                  child: AddListWidget(
                    containerCol: Colors.blue,
                    buttonFunction: () async {
                      FirestoreFunctions(
                          collectionReference: FirebaseFirestore.instance
                              .collection('tasksCollection'),
                          map: {
                            'id': '',
                            'title': userGeneratedValue,
                            'isDone': false
                          }).addItem().then((value) {
                        setState(
                          () {
                            isVisible = (isVisible) ? false : true;
                          },
                        );
                      });
                    },
                    title: 'Create new item',
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: ListStreams(
                  collectionReference: collectionReference,
                  parentId: '',
                  firestoreFunctions: firestoreFunctions,
                  mainScreen: true,
                  ontap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
