import 'package:flutter/material.dart';

class PasswordResetPage extends StatelessWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Reset Page'),
      ),
      body: const MyStatefulPasswordResetWidget(),
    );
  }
}

class MyStatefulPasswordResetWidget extends StatefulWidget {
  const MyStatefulPasswordResetWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulPasswordResetWidget> createState() => _MyStatefulPasswordResetWidget();
}

class _MyStatefulPasswordResetWidget extends State<MyStatefulPasswordResetWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child:
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('go to login'),
                  onPressed: () {

                  },
                )
            ),
        );
  }
}