// ignore_for_file: prefer_const_constructors,prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, unused_import, avoid_print, prefer_typing_uninitialized_variables, unused_element, must_be_immutable, unused_field, avoid_unnecessary_containers, unused_local_variable, no_logic_in_create_state, todo, recursive_getters, override_on_non_overriding_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:tasks_todo_app/Materials/addListComponent.dart';
import 'package:tasks_todo_app/Materials/deleteCheck.dart';
import 'package:tasks_todo_app/Materials/newSubtask.dart';
import 'package:tasks_todo_app/Models/lists.dart';
import 'package:tasks_todo_app/Screens/todoScreens/taskScreen.dart';
import 'package:tasks_todo_app/Utils/fireStoreFunctions.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewTaskList extends StatefulWidget {
  NewTaskList({Key? key, required this.title, required this.parentId})
      : super(key: key);
  String parentId;
  static const String id = 'newTaskList';
  final String title;
  @override
  _NewTaskListState createState() =>
      _NewTaskListState(parentId: parentId, title: title);
}

class _NewTaskListState extends State<NewTaskList> {
  String parentId;
  _NewTaskListState({required this.parentId, required this.title});
  bool _isVisible = false;
  final String title;
  @override
  Widget build(BuildContext context) {
    //collection reference :
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance
            .collection('tasksCollection')
            .doc(parentId)
            .collection('subItems');

    //firestorefunctions :
    FirestoreFunctions firestoreFunctions = FirestoreFunctions(
        collectionReference: FirebaseFirestore.instance
            .collection('tasksCollection')
            .doc(parentId)
            .collection('subItems'),
        map: {});

    //snapshot
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        collectionReference.snapshots();

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          onVerticalDragStart: (_) async {
            setState(() {
              _isVisible = _isVisible ? false : true;
            });
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              Visibility(
                visible: _isVisible,
                child: Expanded(
                  flex: 1,
                  child: AddSubListWidget(
                    buttonFunction: () async {
                      FirestoreFunctions(
                          collectionReference: collectionReference,
                          map: {
                            'id': '',
                            'title': userGeneratedValue,
                            'isDone': false,
                            'reminder': ''
                          }).addItem().then((value) {
                        setState(() {
                          _isVisible = (_isVisible) ? false : true;
                        });
                      });
                    },
                    title: 'Create new item',
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: StreamBuilder<QuerySnapshot>(
                  stream: snapshot,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var items = snapshot.data!.docs;
                      List<dynamic> finalLists =
                          firestoreFunctions.generateList(items);
                      return ReorderableListView.builder(
                        itemCount: finalLists.length,
                        onReorder: ((oldIndex, newIndex) async {
                          final finalIndex =
                              newIndex > oldIndex ? newIndex - 1 : newIndex;
                          firestoreFunctions.swapTasks(
                              finalLists[oldIndex], finalLists[finalIndex]);
                        }),
                        itemBuilder: (context, index) {
                          final item = finalLists[index];
                          int cval = 9 - index;
                          // double cval = ((index) * 0.1);
                          Color? color = Colors.deepOrange[cval * 100];
                          String title = item['title'];
                          String reminder = item['reminder'];
                          bool isDone = item['isDone'];
                          TextEditingController textEditingController =
                              TextEditingController(text: title);
                          return NewWidget(
                              textEditingController: textEditingController,
                              item: item,
                              firestoreFunctions: firestoreFunctions,
                              isDone: isDone,
                              color: color,
                              title: title,
                              key: ValueKey(item['id']),
                              reminder: reminder,
                              parentId: parentId);
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewWidget extends StatefulWidget {
  NewWidget(
      {required this.item,
      required this.firestoreFunctions,
      required this.isDone,
      required this.color,
      required this.title,
      required this.key,
      required this.reminder,
      required this.parentId,
      required this.textEditingController});

  final item;
  final FirestoreFunctions firestoreFunctions;
  final bool isDone;
  final Color? color;
  final String title;
  final Key key;
  String reminder;
  final String parentId;
  final TextEditingController textEditingController;

  @override
  State<NewWidget> createState() => _NewWidgetState(
      reminder: reminder, textEditingController: textEditingController);
}

class _NewWidgetState extends State<NewWidget> {
  bool visibility = false;
  String? reminder;
  String updatedTime = '';
  final TextEditingController textEditingController;
  String reminderText = 'Add reminder';
  _NewWidgetState(
      {required this.reminder, required this.textEditingController});
  DateTime dateTime = DateTime.now();

  FocusNode myfocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.item.id),
      confirmDismiss: (direction) async {
        return widget.firestoreFunctions.dismissable(direction, widget.item);
      },
      background: DeleteOrCheck.checkContainer,
      secondaryBackground: DeleteOrCheck.deleteContainer,
      child: InkWell(
        onTap: () {
          setState(() {
            if (visibility) {
              visibility = false;
            } else {
              visibility = true;
            }
          });
        },
        child: Container(
          color: widget.isDone ? Colors.grey[700] : widget.color,
          padding: EdgeInsets.only(left: 15),
          width: MediaQuery.of(context).size.width * 1,
          alignment: Alignment.centerLeft,
          height: 80,
          // duration: Duration(seconds: 5),
          // curve: Curves.fastOutSlowIn,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EditableText(
                  onSubmitted: (value) {
                    FocusScope.of(context).unfocus();
                    FirebaseFirestore.instance
                        .collection('TasksCollection')
                        .doc(widget.parentId)
                        .collection('subItems')
                        .doc(widget.item['id'])
                        .update({'title': textEditingController.text}).then(
                            (value) {
                      setState(() {});
                    });
                  },
                  controller: textEditingController,
                  focusNode: myfocus,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    decoration:
                        (widget.isDone) ? TextDecoration.lineThrough : null,
                  ),
                  cursorColor: Colors.white,
                  backgroundCursorColor: Colors.black),
              Visibility(
                visible: visibility,
                child: InkWell(
                  onTap: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return CupertinoActionSheet(
                            actions: [
                              SizedBox(
                                height: 180,
                                child: CupertinoDatePicker(
                                  onDateTimeChanged: (dateTime) {
                                    setState(() {
                                      var hour = dateTime.hour;
                                      var minute = dateTime.minute;
                                      var day = dateTime.day;
                                      var month = dateTime.month;
                                      var year = dateTime.year;
                                      reminderText =
                                          '$day-$month-$year at $hour : $minute';
                                      updatedTime = reminderText;
                                      reminder = reminderText;
                                    });
                                  },
                                ),
                              )
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('tasksCollection')
                                    .doc(widget.parentId)
                                    .collection('subItems')
                                    .doc(widget.item['id'])
                                    .update({'reminder': updatedTime}).then(
                                        (value) {
                                  setState(() {});
                                });
                                Navigator.pop(context);
                              },
                              child: Text('Done'),
                            ),
                          );
                        });
                  },
                  child: Text(
                    (checkReminderValue()) ? reminderText : reminder!,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkReminderValue() {
    if (reminder!.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
