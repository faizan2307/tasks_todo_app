import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tasks_todo_app/Models/splashList.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class welcomePage extends StatefulWidget {
  @override
  State<welcomePage> createState() => _welcomePageState();
}

class _welcomePageState extends State<welcomePage> {
  final _controller = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: HexColor('#E9E3DE'),
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: PageView(
                physics: BouncingScrollPhysics(),
                controller: _controller,
                onPageChanged: (Page) {},
                pageSnapping: true,
                scrollDirection: Axis.horizontal,
                children: [
                  FirstPage(),
                  SecondPage(),
                  ThirdPage(),
                  FourthPage(),
                  FifthPage(),
                  SixthPage(),
                  SeventhPage(),
                  LastPage(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SmoothPageIndicator(
              onDotClicked: (index) {
                
              },
              controller: _controller,
              count: 8,
              effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  offset: 8,
                  activeDotColor: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
