import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo/backend/authClass.dart';
import 'package:todo/backend/dataClass.dart';
import 'package:todo/screens/register.dart';
import 'package:todo/screens/taskPage.dart';

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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO'),
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
                          Colors.orange.shade800.withAlpha(200),
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                data[revIndex]['heading'].toString(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: MaterialButton(
                  child: Text('Error/Click to refresh'),
                  onPressed: () {
                    setState(() {});
                  }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.antiAlias,
                  content: Container(
                    height: 300,
                    width: width / 2,
                    child: Column(
                      children: [
                        TextField(
                          controller: titleTextController,
                          decoration: InputDecoration(
                            labelText: 'Title',
                          ),
                        ),
                        TextField(
                          controller: taskTextController,
                          decoration: InputDecoration(
                            labelText: 'Description',
                          ),
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
