import 'package:flutter/material.dart';

class DeleteOrCheck {
  
  static Container deleteContainer = Container(
    color: Colors.black,
    alignment: Alignment.centerRight,
    padding: EdgeInsets.only(right: 10),
    child: Icon(
      Icons.delete,
      color: Colors.white,
    ),
  );

  static Container checkContainer = Container(
    color: Colors.green,
    child: Icon(
      Icons.check,
      color: Colors.white,
    ),
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(left: 10),
  );
}
