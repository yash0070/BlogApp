import 'package:blog_app/LogIn/log_in.dart';
import 'package:blog_app/SignUp/signUp_screen.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: size.height,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.2),
            Text(
              "Welcome to BlogApp",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Image.asset(
              "images/blog.png",
              height: 250,
            ),
            SizedBox(height: size.height * 0.05),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(16),
              child: MaterialButton(
                minWidth: size.width * 0.5,
                child: Text(
                  "LogIn",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  setState(
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LogInScreen();
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Material(
              elevation: 5,
              color: Colors.black.withOpacity(0.80),
              borderRadius: BorderRadius.circular(16),
              child: MaterialButton(
                textColor: Colors.white,
                minWidth: size.width * 0.5,
                child: Text(
                  "SignUp",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  setState(
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return RegistrationScreen();
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
