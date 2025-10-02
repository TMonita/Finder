import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/home_screen.dart';
import 'package:flutter_application_1/login_signup_page.dart/signup_page.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
            margin: EdgeInsets.all(25),
            // width: 265,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 100, 0, 50),
                  child: Container(
                    width: 200,
                    height: 100,
                    child: Image(image: AssetImage('images/LogoFinder.png')),
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Mobile Phone',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'images/Cambodiaflag.png',
                            width: 24,
                            height: 16,
                          ),
                          SizedBox(width: 10),
                          Text('+885'),
                        ],
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                //**Login btn**/
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Homescreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF274C77),
                      padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    ),
                    child: Text(
                      'Log In',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.facebook, size: 40, color: Colors.white),
                    label: Text(
                      'Connect with Facebook',
                      style: TextStyle(color: Colors.white),
                    ),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF367BC7),
                    ),
                  ),
                ),

                SizedBox(height: 10),

                Text('By click start, you agree to our Terms & Conditions'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
