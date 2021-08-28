import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/backend/dataClass.dart';
import 'package:todo/screens/taskPage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

DataClass dbClass = new DataClass();
dynamic data = [];
List<dynamic> list = [];

class _HomeState extends State<Home> {
  Future _getData() async {
    Future.delayed(Duration(seconds: 2));
    final res = await dbClass.getFromDb();
    data = list = res;
    print(list.length);
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleTextController = new TextEditingController();
    TextEditingController taskTextController = new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('This is title'),
      ),
      body: FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, item) {
                  return Container(
                      color: Colors.cyan,
                      height: 500,
                      child: Material(
                        child: InkWell(
                            onTap: () {
                              print('tap');
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return TaskPage();
                              }));
                            },
                            splashColor: Colors.orange,
                            focusColor: Colors.green,
                            child: Text(
                                data[0]['taskArray']['task'][item].toString())),
                      ));
                },
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Form(
                    child: Column(
                      children: [
                        TextField(
                          controller: titleTextController,
                        ),
                        TextField(
                          controller: taskTextController,
                        )
                      ],
                    ),
                  ),
                  actions: [
                    Center(
                      child: MaterialButton(
                        onPressed: () async {
                          final insertResp = await dbClass.addToDb(
                              titleTextController.text,
                              taskTextController.text);

                          if (insertResp != null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Task added successfully')));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error'),
                              ),
                            );
                          }

                          Navigator.of(context).pop();
                          setState(() {});
                        },
                        child: Center(
                          child: Text("Add to task list"),
                        ),
                      ),
                    )
                  ],
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
