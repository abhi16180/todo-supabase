import 'package:flutter/material.dart';
import 'package:todo/backend/authClass.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final key = GlobalKey<FormState>();
  AuthClass _authClass = new AuthClass();
  var loading = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Todo/Log-in',
            style: TextStyle(fontFamily: 'prodsans'),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                ),
                Center(
                  child: Text(
                    'Log-in',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Form(
                  key: key,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.black,
                        child: Container(
                          width: width > 720 ? width / 1.6 : width / 1.2,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: MultiValidator([
                                    RequiredValidator(
                                      errorText: 'Email is required',
                                    ),
                                    EmailValidator(
                                      errorText: 'Please enter correct email',
                                    ),
                                  ]),
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle:
                                          TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  validator: RequiredValidator(
                                      errorText: 'Password is required'),
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle:
                                          TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                loading == false
                    ? MaterialButton(
                        minWidth: width < 720 ? width / 1.2 : 400,
                        color: Colors.blue,
                        height: 40,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('Log-In', style: TextStyle(fontSize: 20)),
                        onPressed: () async {
                          setState(() {
                            loading = !loading;
                          });
                          if (key.currentState!.validate() == true) {
                            final authResp = await _authClass.login(
                              _emailController.text,
                              _passwordController.text,
                            );

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
                              setState(() {
                                loading = !loading;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Error',
                                    style: TextStyle(fontFamily: 'prodsans'),
                                  ),
                                ),
                              );
                            }
                          } else {
                            setState(() {
                              loading = !loading;
                            });
                          }
                        },
                      )
                    : CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
