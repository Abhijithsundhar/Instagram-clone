import 'package:flutter/material.dart';
class Appbarwidget extends StatefulWidget {
   Appbarwidget({super.key,required this.title,required this.Icon1,required this.Icon2,});
  String title;
  IconData Icon1;
  IconData Icon2;
  
  @override
  State<Appbarwidget> createState() => _AppbarwidgetState();
}

class _AppbarwidgetState extends State<Appbarwidget> {
  
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        // Text(title),
        // Icon(Icon1),
        // Icon(Icons)
      ],
    );
  }
}