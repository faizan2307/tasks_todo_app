import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:tasks_todo_app/Models/splashList.dart';
import 'package:tasks_todo_app/Screens/landingPage.dart';
import 'package:tasks_todo_app/Screens/todoScreens/taskScreen.dart';
import '../Models/menuModel.dart';

class MenuPage extends StatefulWidget {
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<MenuItems> _menuItems = [
    MenuItems('My list'),
    MenuItems('Themes'),
    MenuItems('Guide'),
    MenuItems('Tips And Tricks'),
    MenuItems('Privacy Policy'),
    MenuItems('Feedback'),
    MenuItems('Rate'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            ),
            Padding(padding: EdgeInsets.all(4.0)),
            Expanded(
              child: Container(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _menuItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    // int len = menuItems.length;
                    //     int fraction = 255 ~/ (len);
                    // int val = (255 - (fraction * index));
                    double cval = ((index+1)*0.1);
                    // if (cval < 4) cval = 3;
                    return Container(
                      child: ListTile(
                        tileColor: Color.fromARGB(255, 90, 90, 90).withOpacity(cval),
                        
                        style: ListTileStyle.drawer,
                        contentPadding: EdgeInsets.all(10.0),
                        title: Text(
                          _menuItems[index].name,
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        onTap: () {
                          if (index == 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        NewMainScreenFirebase()));
                          } else if (index == 2) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => welcomePage()));
                          } else if (index == 6) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return RatingDialog(
                                    starColor: Colors.pink,
                                    title: Text('How much do you like Clear'),
                                    submitButtonText: 'Submit',
                                    onSubmitted: (rating) {},
                                    image: Image.asset('assets/images/logo.png',height: 80,),
                                    onCancelled: () {},
                                    enableComment: false,
                                    showCloseButton: true,
                                    
                                  );
                                });
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
