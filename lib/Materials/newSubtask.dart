// import 'package:tasks_todo_app/Screens/mainSubScreen.dart';
import 'package:tasks_todo_app/Screens/todoScreens/taskScreen.dart';

import '../Models/lists.dart';
import 'package:flutter/material.dart';

class AddSubListWidget extends StatefulWidget {
  final String title;
  final Function buttonFunction;
  final Color? containerCol;
  
  
  AddSubListWidget({required this.title, required this.buttonFunction, this.containerCol});

  @override
  State<AddSubListWidget> createState() => _AddSubListWidgetState();
}

class _AddSubListWidgetState extends State<AddSubListWidget> {
  String userValue = '';
  TextEditingController searchController = TextEditingController();

  void addListItem() {
    userGeneratedValue = userValue;
    widget.buttonFunction();
    setState(() {
      searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 8,
          child: Container(
            alignment: Alignment.center,
            color:Colors.orange,
            child: TextField(
              
              cursorColor: Colors.deepOrange,
              controller: searchController,
              onChanged: (value) {
                userValue = value;
              },
              cursorHeight: 50,
              onSubmitted: (value) => addListItem(),
              style: TextStyle(color: Colors.white,fontSize: 25),
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Expanded(
        //   flex: 1,
        //   child: InkWell(
        //     onTap: () {
        //       userGeneratedValue = userValue;
        //       widget.buttonFunction();
        //       setState(() {
        //         searchController.clear();
        //       });
        //     },
        //     child: Container(
        //       child: Container(
        //         color: Colors.blue,
        //         child: Icon(
        //           Icons.add,
        //           color: Colors.white,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
