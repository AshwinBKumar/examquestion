import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:examquestion/listingpage.dart';
import 'package:examquestion/profilepage.dart';
import 'package:examquestion/register.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
   int page = 1;
   final List<dynamic>screen=[
    Listingpage(),
    StudentReg(),
ProfilePage(),    
 ];
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Management App'),
        backgroundColor: Colors.amberAccent,

      ),
      bottomNavigationBar:CurvedNavigationBar(
       color: Colors.amberAccent,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
         index: 1,
        items:[
        Icon(Icons.home),
        Icon(Icons.add),
        Icon(Icons.person)
                ] ,
                onTap: (value) => setState(() {
                  page=value;
                }),
                letIndexChange: (value) => true,
                ) ,
              
body:
      screen[page],
    );
  }
}