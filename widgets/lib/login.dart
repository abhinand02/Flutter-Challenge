import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'home.dart';

class ScreenLogin extends StatefulWidget {
  ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isdataMatch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'User Name'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Password'),
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: !_isdataMatch,
              child: const Text(
                'USERNAME AND PASS DOESNT MATCH',
                style: TextStyle(color: Colors.red),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                checkLogin(context);
              },
              icon: const Icon(Icons.check),
              label: const Text('login'),
            )
          ],
        ),
      ),
    ));
  }

  void checkLogin(BuildContext ctx) {
    final username = _usernameController.text;
    final password = _passwordController.text;
    if (username == password) {
      Navigator.of(ctx)
          .pushReplacement(MaterialPageRoute(builder: (ctx1) => Screenhome()));
    } else {
      setState(() {
        _isdataMatch = false;
      });
    }
  }
}
