import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  TaskPage({Key? key}) : super(key: key);

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
              'title',
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'task',
              style: TextStyle(fontSize: 40),
            ),
          ],
        )),
      ),
    );
  }
}
