// import 'package:tasks_todo_app/Screens/mainSubScreen.dart';
import 'package:tasks_todo_app/Screens/todoScreens/taskScreen.dart';

import '../Models/lists.dart';
import 'package:flutter/material.dart';

class AddListWidget extends StatefulWidget {
  final String title;
  final Function buttonFunction;
  final Color? containerCol;
  AddListWidget(
      {required this.title, required this.buttonFunction, this.containerCol});

  @override
  State<AddListWidget> createState() => _AddListWidgetState();
}

class _AddListWidgetState extends State<AddListWidget> {
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
            color: Colors.blue,
            child: TextField(
              cursorColor: Colors.blue[900],
              controller: searchController,
              onChanged: (value) {
                userValue = value;
              },
              cursorHeight: 50,
              onSubmitted: (value) => addListItem(),
              style: TextStyle(color: Colors.white, fontSize: 30),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
