import 'package:flutter/material.dart';
import 'package:petme/screens/signuppage.dart';

class adopterSignUp extends StatefulWidget {
  const adopterSignUp({super.key});

  @override
  State<adopterSignUp> createState() => _adopterSignUpState();
}

class _adopterSignUpState extends State<adopterSignUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 240,
                    width: 35,
                  ),
                  TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, 'adopter');
                        Navigator.push(context, PageRouteBuilder(pageBuilder:
                            (BuildContext context, Animation<double> animation1,
                                Animation<double> animation2) {
                          return adopterSignUp();
                        }));
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: 4, // Space between underline and text
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.pink[400]!,
                          width: 2.0, // Underline thickness
                        ))),
                        child: Text(
                          "Adopter",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                      )),
                  SizedBox(
                    //  height: 120,
                    width: 90,
                  ),
                  TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, 'adopter');
                        Navigator.push(context, PageRouteBuilder(pageBuilder:
                            (BuildContext context, Animation<double> animation1,
                                Animation<double> animation2) {
                          return SignUp();
                        }));
                      },
                      child: Text(
                        'Pet',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )),
                ],
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.23,
                      right: 35,
                      left: 35),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13))),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'Email id',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13))),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13))),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Re-Enter Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13))),
                      ),
                      SizedBox(
                        height: 48,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'Create Account',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.fromLTRB(100, 10, 100, 10),
                                backgroundColor: Colors.pink[400],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                // Navigator.pushNamed(context, 'login');
                                Navigator.push(context, PageRouteBuilder(
                                    pageBuilder: (BuildContext context,
                                        Animation<double> animation1,
                                        Animation<double> animation2) {
                                  return SignUp();
                                }));
                              },
                              child: Text(
                                'Pet',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                backgroundColor: Colors.black87,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
