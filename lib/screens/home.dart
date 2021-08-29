import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/backend/authClass.dart';
import 'package:todo/backend/dataClass.dart';
import 'package:todo/screens/register.dart';
import 'package:todo/screens/taskPage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

DataClass dbClass = new DataClass();
dynamic data = [];
List<dynamic> list = [];
var len;

class _HomeState extends State<Home> {
  Future _getData() async {
    Future.delayed(Duration(seconds: 2));
    final res = await dbClass.getFromDb();
    data = res[0]['taskArray']['tasks'];
    len = data.length;
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
    AuthClass _authClass = new AuthClass();
    return Scaffold(
      appBar: AppBar(
        title: Text('This is title'),
      ),
      drawer: Drawer(
          child: Column(
        children: [
          ListTile(
            title: Text('Log-Out'),
            onTap: () async {
              final resp = await _authClass.logout();
              if (resp != null)
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return RegisterPage();
                }));
              else
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error signing out'),
                  ),
                );
            },
          )
        ],
      )),
      body: FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: ListView.builder(
                itemCount: len,
                itemBuilder: (context, item) {
                  var revIndex = data.length - (item + 1);
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) async {
                      await dbClass.deleteData(data, revIndex);
                      setState(() {});
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                          Colors.pink.withAlpha(100),
                          Colors.purple.withAlpha(200),
                        ])),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return TaskPage(
                                heading: data[revIndex]['heading'],
                                description: data[revIndex]['description'],
                              );
                            }));
                          },
                          splashColor: Colors.orange,
                          focusColor: Colors.green,
                          child: Center(
                            child: Text(
                              data[revIndex]['heading'].toString(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
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
