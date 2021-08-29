import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  final heading;
  final description;
  TaskPage({this.heading, this.description});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Page'),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            Text(
              widget.heading,
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              widget.description,
              style: TextStyle(),
            ),
          ],
        )),
      ),
    );
  }
}
