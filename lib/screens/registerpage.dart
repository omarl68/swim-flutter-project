import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class registerpage extends StatefulWidget {
  const registerpage({Key? key}) : super(key: key);

  @override
  State<registerpage> createState() => _registerpageState();
}

enum SingingCharacter { Male, Female }

class _registerpageState extends State<registerpage> {
  DateTime date = DateTime(2022, 12, 24);
  SingingCharacter? _character = SingingCharacter.Male;
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController conpassController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xFFFF8008),
            title: Text(
              'Create Account',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 25),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.dangerous_outlined,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.popAndPushNamed(context, '/');
              },
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          labelText: 'First name',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        controller: lastController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          labelText: 'Last name',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: ListTile(
                        title:
                            const Text('Male', style: TextStyle(fontSize: 20)),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Male,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: ListTile(
                        title: const Text(
                          'Female',
                          style: TextStyle(fontSize: 20),
                        ),
                        leading: Radio<SingingCharacter>(
                          value: SingingCharacter.Female,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: TextField(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          labelText: 'password',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextField(
                        obscureText: true,
                        controller: conpassController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          labelText: 'confremt pasword',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if ((!EmailValidator.validate(emailController.text)) &&
                        (nameController.text.isEmpty) &&
                        (lastController.text.isEmpty) &&
                        (phoneController.text.isEmpty) &&
                        (passwordController.text.isEmpty)) {
                      Toast.show("you have something false",
                          duration: Toast.lengthShort, gravity: Toast.bottom);
                    } else if (passwordController.text ==
                        conpassController.text) {
                      Toast.show("your password is not correct",
                          duration: Toast.lengthShort, gravity: Toast.bottom);
                    } else {
                      var url = Uri.parse(
                          'https://api-nodejs-todolist.herokuapp.com/user/register');

                      var mybody = jsonEncode({
                        'email': emailController.text,
                        'password': passwordController.text,
                        'name': nameController.text + ' ' + lastController.text,
                        "age": 20
                      });

                      var response = await http.post(url,
                          body: mybody,
                          headers: {'Content-Type': 'application/json'});
                      print('Response status: ${response.statusCode}');
                      print('Response body: ${response.body}');
                      Navigator.of(context).pop('/second');
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
