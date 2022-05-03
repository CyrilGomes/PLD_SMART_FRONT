import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home Page'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This should be a sliding menu')));
            },
          ),
        ],
      ),
      body: const MyStatefulHomeWidget(),
    );
  }
}

class MyStatefulHomeWidget extends StatefulWidget {
  const MyStatefulHomeWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulHomeWidget> createState() => _MyStatefulHomeWidgetState();
}

class _MyStatefulHomeWidgetState extends State<MyStatefulHomeWidget> {
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
                  'wlcm home',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),

          ],
        ));
  }
}