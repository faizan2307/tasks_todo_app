import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasks_todo_app/Models/menuModel.dart';
// import 'package:tasks_todo_app/Screens/mainPage.dart';
// import 'package:tasks_todo_app/Screens/mainSubScreen.dart';
import 'package:tasks_todo_app/Screens/menuScreen.dart';
import 'package:tasks_todo_app/Screens/todoScreens/taskScreen.dart';

Expanded image(i) => Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Image.asset(
            'assets/images/page${i}.png',
            height: 400,
          ),
        ),
      ),
    );

Text boldTxt(text) => Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 27,
      ),
      textAlign: TextAlign.center,
    );
Text normalText(text) => Text(
      text,
      style: TextStyle(
        fontSize: 27,
      ),
      textAlign: TextAlign.center,
    );

SizedBox utilbutton(text, onpressed) => SizedBox(
      width: 150,
      height: 60,
      child: OutlinedButton(
        // shape: RoundedRectangleBorder(
        //     borderRadius: new BorderRadius.circular(10.0)),
        onPressed: onpressed,
        child: Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: 23),
        ),
        // borderSide: BorderSide(
        //     color: Colors.black, style: BorderStyle.solid, width: 1.5),
      ),
    );

class FirstPage extends StatelessWidget {
  const FirstPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to ',
                style: TextStyle(fontSize: 35),
              ),
              Text(
                'Clear',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(10.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              boldTxt('Tap or swipe '),
              normalText('to begin'),
            ],
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: HexColor('#E9E3DE'),
      child: Padding(
        padding: EdgeInsets.only(top: 100.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Clear sorts items by ',
                  style: TextStyle(fontSize: 27),
                ),
                Text(
                  'priority.',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Text(
              'Important items are highlighted at the top...',
              style: TextStyle(fontSize: 27),
              textAlign: TextAlign.center,
            ),
            image(2)
          ],
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: HexColor('#E9E3DE'),
      child: Padding(
        padding: EdgeInsets.only(top: 150.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                boldTxt('Tap and hold '),
                normalText('to pick an item up.')
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 10, right: 10),
              child: normalText('Drag it up or down to change its priority'),
            ),
            image(3),
          ],
        ),
      ),
    );
  }
}

class FourthPage extends StatelessWidget {
  const FourthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 150.0),
          ),
          normalText('There are three navigation levels...'),
          image(4)
        ],
      ),
    );
  }
}

class FifthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 150)),
          boldTxt('Pinch together vertically '),
          normalText('to collapse your current level and navigate up.'),
          image(5),
        ],
      ),
    );
  }
}

class SixthPage extends StatelessWidget {
  const SixthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 150),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              boldTxt('Tap on a list '),
              normalText('to see its content.'),
            ],
          ),
          Padding(padding: EdgeInsets.all(8)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              boldTxt('Tap on a list title '),
              normalText('to edit it...'),
            ],
          ),
          image(6)
        ],
      ),
    );
  }
}

class SeventhPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 150)),
          Image.asset(
            'assets/images/cloud.png',
          ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Use ',
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
                TextSpan(
                  text: 'iCloud?',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 10)),
          normalText(
              'Storing your lists in iCloud allows you to keep your data in sync across your iPhone, iPad and Mac.'),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              utilbutton('Not Now', () {}),
              Padding(padding: EdgeInsets.all(15.0)),
              utilbutton('Use iCloud', () {}),
            ],
          )
        ],
      ),
    );
  }
}

class LastPage extends StatelessWidget {
  const LastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 150),
          ),
          normalText(
              'Sign up to the newsletter, and unlock a theme for your lists.'),
          Padding(
            padding: EdgeInsets.only(top: 40),
          ),
          Image.asset(
            'assets/images/mail.png',
            height: 200,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: 'Email Address',
                labelStyle: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              utilbutton('Skip', () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MenuPage()));
              }),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20)),
              utilbutton('Join', () {}),
            ],
          ),
        ],
      ),
    );
  }
}
