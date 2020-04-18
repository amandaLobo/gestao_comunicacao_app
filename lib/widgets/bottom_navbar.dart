import 'package:br/assets/custom_icons_icons.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavBar extends StatelessWidget{

  final TabController tabController;
  String title;

  BottomNavBar(this.tabController);

  @override
  Widget build(BuildContext context) {

    const Color _color = Color.fromARGB(255, 30, 54, 76);

    return CurvedNavigationBar(

      color: Color.fromARGB(255, 103, 181, 254),
      backgroundColor: Colors.white,
      buttonBackgroundColor: Colors.white,
      height: 50,
      items: <Widget>[
        Icon(FontAwesomeIcons.envelopeOpen, size:20, color: _color),
        Icon(CustomIcons.gestao, size:20, color: _color),
        Icon(FontAwesomeIcons.bell, size:20, color: _color),
        Icon(FontAwesomeIcons.user, size:20, color: _color)
      ],
      animationDuration: Duration(
        milliseconds: 200
      ),
      index: 0,
      animationCurve: Curves.bounceInOut,
      onTap: (index){
        print("current index is: $index");
        tabController.animateTo(index);
      },
    );

  }

}