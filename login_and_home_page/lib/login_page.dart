import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final Map<String, String> emailAndPassword = {
    "email": "abhinandmadhu08@gmail.com",
    "Password": "Abhinand"
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: const [
                Text(
                  'Let\'s Sign You In',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          'Email',
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 20, bottom: 40),
                        child: TextFormField(
                            // controller: _controller,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            cursorHeight: 25.0,
                            decoration: InputDecoration(
                              icon: const Icon(
                                Icons.email_outlined,
                                color: Colors.black,
                                size: 30,
                              ),
                              hintText: 'Enter Email.',
                              hintStyle: GoogleFonts.lato(),
                            ),
                            validator: (value) {
                              if (value != emailAndPassword['email']) {
                                return "enter a valid email";
                              } else {
                                saveData(value);
                                return null;
                              }
                            }),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          'Password',
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 20, bottom: 10),
                        child: TextFormField(
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            cursorHeight: 25.0,
                            decoration: InputDecoration(
                              icon: const Icon(
                                Icons.lock_outline,
                                color: Colors.black,
                                size: 30,
                              ),
                              hintText: 'Enter Password.',
                              hintStyle: GoogleFonts.lato(),
                            ),
                            validator: (value) {
                              if (value != emailAndPassword['Password']) {
                                return "incorrect Password";
                              } else {
                                return null;
                              }
                            }),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 250,
                    ),
                    child: const Text(
                      'Forgot Password!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color.fromARGB(255, 98, 219, 198),
                            Color.fromARGB(255, 48, 159, 140)
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        width: width * .9,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveData(email) async {
    // print(email);
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString('saved_data', email);
  }
}
