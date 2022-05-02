import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUP Page'),
      ),
      body: const MyStatefulSignUpWidget(),
    );
  }
}

class MyStatefulSignUpWidget extends StatefulWidget {
  const MyStatefulSignUpWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulSignUpWidget> createState() => _MyStatefulSignUpWidget();
}

class _MyStatefulSignUpWidget extends State<MyStatefulSignUpWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20),
                )),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Forgot Password',
              ),
            ),
          ],
        ));
  }
}
