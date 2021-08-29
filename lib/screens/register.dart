import 'package:flutter/material.dart';
import 'package:todo/backend/authClass.dart';

import 'home.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthClass _authClass = new AuthClass();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();
  var loading = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todo/Create-account',
              style: TextStyle(fontFamily: 'prodsans')),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: Text(
                    'Create Account',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Form(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: Colors.black,
                          child: Container(
                            width: width > 720 ? width / 1.6 : width / 1.2,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _usernameController,
                                    decoration: InputDecoration(
                                      labelText: 'Username',
                                    ),
                                  ),
                                ),
                                SizedBox(height: 25),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Retype password',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    loading != true
                        ? MaterialButton(
                            minWidth: width < 720 ? width / 1.2 : 400,
                            color: Colors.blue,
                            height: 40,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Sign-In',
                              style: TextStyle(
                                  fontSize: 20, fontFamily: 'prodsans'),
                            ),
                            onPressed: () async {
                              setState(() {
                                loading = !loading;
                              });

                              final authResp = await _authClass.register(
                                  _emailController.text,
                                  _passwordController.text,
                                  'username');

                              if (authResp != null) {
                                loading = !loading;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return Home();
                                    },
                                  ),
                                );
                              } else {
                                loading = !loading;
                                setState(() {});
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    'Error while registering',
                                    style: TextStyle(fontFamily: 'prodsans'),
                                  ),
                                ));
                              }
                            },
                          )
                        : CircularProgressIndicator(),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: Text('Already having an account?')),
                          MaterialButton(
                            minWidth: 50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text('Login'),
                            color: Colors.blue,
                            onPressed: () async {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Login();
                              }));
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
