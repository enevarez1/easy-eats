import 'package:easy_eats/Theme.dart';
import 'package:easy_eats/model/NavigationModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CollapsingListTile.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  

  @override
  CollapsingNavigationDrawerState createState() {
    return new CollapsingNavigationDrawerState();
  }

}

class CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer> with SingleTickerProviderStateMixin{

  double maxWidth = 250.0;
  double midWidth = 60.0;
  bool isCollapsed = false;
  AnimationController _animationController;
  Animation<double> widthAnimation;
  int currentSelectedIndex = 0;

  @override
  void initState() { 
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    widthAnimation = Tween<double>(begin: maxWidth, end: midWidth).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _animationController, builder: (context, widget) => getWidget(context, widget),);
    }
    
  Widget getWidget(BuildContext context, Widget widget) {
    return Material(
      elevation: 8.0,
      child: Container(
        width: widthAnimation.value,
        color: drawerBackgroundColor,
        child: Column(
          children: <Widget>[
            CollapsingListTile(
              //TODO Grab user login info and put it here.
              title: 'User Name',
              icon: Icons.person,
              animationController: _animationController,
            ),
            Divider(color: Colors.grey),
            Expanded(
                child: ListView.separated(
                  
                  separatorBuilder: (context, counter) {
                    return Divider(color: Colors.grey, height:12.0);
                  },
                  
                  itemBuilder: (context, counter) {
                  return CollapsingListTile(
                    onTap: () {
                      setState(() {
                        currentSelectedIndex = counter;
                      });
                    },
                    isSelected: currentSelectedIndex == counter,
                    title: navigationItems[counter].title,
                    icon: navigationItems[counter].icon,
                    animationController: _animationController);
                },
                itemCount: navigationItems.length,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isCollapsed = !isCollapsed;
                  isCollapsed ? _animationController.forward() : _animationController.reverse();
                });
              },
              child: AnimatedIcon(
                icon: AnimatedIcons.close_menu, 
                progress: _animationController,
                color: Colors.white, 
                size: 50.0,
              ),
            ),
            SizedBox(height: 50.0),
          ]
        ),
      ),
    );
  }
}