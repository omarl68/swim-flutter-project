import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFE1F5FE),
                Color(0xFF29B6F6),
              ],
            ),
          ),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/Asset 2.png',
                      width: 300,
                      height: 300,
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Theme(
                    data: ThemeData(
                      primarySwatch: Colors.grey,
                      primaryColorDark: Colors.black,
                    ),
                    child: TextField(
                      obscureText: false,
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide()),
                        labelText: 'Email',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Theme(
                    data: ThemeData(
                      primarySwatch: Colors.grey,
                      primaryColorDark: Colors.red,
                    ),
                    child: TextField(
                      obscureText: true,
                      controller: passController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide()),
                        labelText: 'password',
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (passController.text.isEmpty ||
                          emailController.text.isEmpty) {
                        Toast.show("you have something false",
                            duration: Toast.lengthShort, gravity: Toast.bottom);
                      } else if (passController.text.length < 8) {
                        Toast.show("size incorrect",
                            duration: Toast.lengthShort, gravity: Toast.bottom);
                      } else if (!EmailValidator.validate(
                          emailController.text)) {
                        Toast.show("email invalid",
                            duration: Toast.lengthShort, gravity: Toast.bottom);
                      } else {
                        Navigator.pushNamed(context, '/second');
                      }
                    },
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/third');
                        },
                        child: Text(
                          'Create account',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        )),
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
