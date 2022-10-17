import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:marquee/marquee.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tasks_todo_app/Materials/deleteCheck.dart';
import 'package:tasks_todo_app/Screens/todoScreens/tasklistScreen.dart';

class FirestoreFunctions {
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference collectionReference;
  // final String value;

  // final String collectionId;
  var map;

  FirestoreFunctions({required this.collectionReference, this.map});

  Future<void> addItem() async {
    var generatedId = await collectionReference.add(map);

    collectionReference
        .doc(generatedId.id)
        .update({'id': generatedId.id}).then((value) => print('SUCCESS!'));
  }

  Future<void> deleteItem(String id) async {
    collectionReference
        .doc(id)
        .delete()
        .then((value) => print('Successfully Deleted'))
        .onError((error, stackTrace) => print(error));
  }

  Future<void> changeTaskStatus(dynamic item) async {
    bool status = (item['isDone']) ? false : true;
    collectionReference
        .doc(item.id)
        .update({'isDone': status}).then((value) => print('updated'));
  }

  List<dynamic> generateList(dynamic items) {
    List<dynamic> incompletedLists = [];
    List<dynamic> completedLists = [];

    for (var item in items) {
      if (item['isDone'] == false) {
        incompletedLists.add(item);
      } else {
        completedLists.add(item);
      }
    }

    List<dynamic> finalLists = [...incompletedLists, ...completedLists];
    return finalLists;
  }

  Future<bool?> dismissable(DismissDirection direction, dynamic item) async {
    if (direction == DismissDirection.startToEnd) {
      FirestoreFunctions(collectionReference: collectionReference, map: {})
          .changeTaskStatus(item);
      return false;
    } else {
      FirestoreFunctions(collectionReference: collectionReference, map: {})
          .deleteItem(item['id']);
      return true;
    }
  }

  Future<void> updateUserValue(dynamic item, String updatedValue) async {
    collectionReference.doc(item.id).update({'title': updatedValue}).then(
        (value) => print('User Value changed'));
  }

  void swapTasks(dynamic oldTask, dynamic newTask) {
    if (oldTask['isDone'] == true || newTask['isDone'] == true)
      return;
    else {
      String oldTitle = oldTask['title'];
      String newTitle = newTask['title'];
      String tempTitle = oldTask['title'];

      collectionReference
          .doc(oldTask.id)
          .update({'title': newTitle}).then((value) => print(newTitle));
      collectionReference
          .doc(newTask.id)
          .update({'title': tempTitle}).then((value) => print(tempTitle));
    }
  }
}

class ListStreams extends StatefulWidget {
  var parentId;
  final bool mainScreen;

  CollectionReference<Map<String, dynamic>> collectionReference;
  FirestoreFunctions firestoreFunctions;
  Function ontap;
  ListStreams(
      {this.parentId,
      required this.collectionReference,
      required this.firestoreFunctions,
      required this.ontap,
      required this.mainScreen});
  @override
  State<ListStreams> createState() =>
      _ListStreamsState(parentId, collectionReference, mainScreen, ontap);
}

class _ListStreamsState extends State<ListStreams> {
  final String parentId;
  final bool mainScreen;
  final Function ontap;

  final CollectionReference<Map<String, dynamic>> collectionReference;

  _ListStreamsState(
      this.parentId, this.collectionReference, this.mainScreen, this.ontap);

  @override
  Widget build(BuildContext context) {
    //onTap function

    //snapshot
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        collectionReference.snapshots();

    //collection reference
    FirestoreFunctions firestoreFunctions = FirestoreFunctions(
      collectionReference: collectionReference,
    );

    return StreamBuilder<QuerySnapshot>(
      stream: snapshot,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var items = snapshot.data!.docs;

          List<dynamic> finalLists = firestoreFunctions.generateList(items);
          
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Container(
              child: ReorderableListView.builder(
                
                dragStartBehavior: DragStartBehavior.start,
                onReorder: ((oldIndex, newIndex) async {
                  final finalIndex =
                      newIndex > oldIndex ? newIndex - 1 : newIndex;

                  print('oldIndex : $oldIndex');
                  print('newIndex : $finalIndex');

                  firestoreFunctions.swapTasks(
                      finalLists[oldIndex], finalLists[finalIndex]);
                }),
                itemCount: finalLists.length,
                itemBuilder: (context, index) {
                  final item = finalLists[index];
                  // int len = finalLists.length;
                  // int fraction = 255 ~/ (len);
                  // int val = (255 - (fraction * index));
                  // int cval = 9 - index;
                  // if (cval <= 0) cval = 0;
                  double cval = ((index + 3) * 0.1);
                  Color colorBlue =
                      Color.fromARGB(255, 0, 26, 255).withOpacity(cval);
                  Color colorOrange =
                      Color.fromARGB(255, 255, 72, 0).withOpacity(cval);
                  // Color colorBlue = Color.fromRGBO(0, 0, val, 1);
                  // Color colorOrange = Color.fromRGBO(255, val, 0, 1);
                  Color color = mainScreen ? colorBlue : colorOrange;
                  String title = item['title'];

                  return listTile(
                    item,
                    color,
                    index,
                    context,
                    title,
                    item['isDone'],
                    firestoreFunctions,
                    () {},
                    mainScreen,
                  );
                },
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget listTile(
    dynamic item,
    Color color,
    int index,
    BuildContext context,
    String title,
    bool isDone,
    FirestoreFunctions firestoreFunctions,
    Function ontap,
    bool mainScreen,
  ) {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = title;

    bool editIcon = false;
    return Dismissible(
      key: ValueKey(item.id),
      confirmDismiss: ((direction) async {
        return firestoreFunctions.dismissable(direction, item);
      }),
      background: DeleteOrCheck.checkContainer,
      secondaryBackground: DeleteOrCheck.deleteContainer,
      child: InkWell(
        onTap: () {
          if (mainScreen) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => NewTaskList(
                  parentId: (item.id),
                  title: item['title'],
                ),
              ),
            );
          } else {
            return;
          }
        },
        child: Container(
          color: isDone ? Colors.grey[700] : color,
          padding: EdgeInsets.only(left: 15),
          width: MediaQuery.of(context).size.width * 1,
          // width: double.infinity,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // color: Colors.red,
                width: MediaQuery.of(context).size.width * 0.8,
                // height: MediaQuery.of(context).size.width * 0.1,
                child: TextFormField(
                  decoration:
                      InputDecoration(isDense: true, border: InputBorder.none),
                  onFieldSubmitted: (value) {
                    title = value;
                    print(title);
                    FirebaseFirestore.instance
                        .collection('tasksCollection')
                        .doc(item.id)
                        .update({'title': title}).then((value) {
                      setState(() {});
                    });
                    //   print('complete');
                  },
                  initialValue: title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      decoration: isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}














 //   key: ValueKey(item.id),
          //   child: Container(
          //     padding: EdgeInsets.all(20),
          //     color: isDone ? Colors.grey[700] : color,
          //     alignment: Alignment.topCenter,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Container(
          //           // color: Colors.green,
          //           width: MediaQuery.of(context).size.width * 0.5,
          //           height: MediaQuery.of(context).size.width * 0.1,
          //           child: (title.length < 15)
          //               ? Text(
          //                   title,
          //                   style: TextStyle(
          //                       color: Colors.white,
          //                       fontSize: 30,
          //                       decoration: isDone
          //                           ? TextDecoration.lineThrough
          //                           : TextDecoration.none),
          //                 )
          //               : Marquee(
          //                   showFadingOnlyWhenScrolling: true,
          //                   startAfter: Duration(seconds: 5),
          //                   pauseAfterRound: Duration(seconds: 5),
          //                   fadingEdgeEndFraction: 0.3,
          //                   blankSpace: 100,
          //                   velocity: 50,
          //                   text: title,
          //                   style: TextStyle(
          //                       color: Colors.white,
          //                       fontSize: 25,
          //                       decoration: isDone
          //                           ? TextDecoration.lineThrough
          //                           : TextDecoration.none)),

          //         ),
          //         Icon(
          //           Icons.drag_indicator_sharp,
          //           color: Colors.white,
          //         ),
          //       ],
          //     ),

          //   ),
          // ),