import 'package:auto_route/auto_route.dart';
import 'package:caption_this/Features/auth/BloC/bloc/auth_bloc.dart';
import 'package:caption_this/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _form,
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Home',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
                validator: (val) {
                  if (val == null) return 'Username is required';
                  if (val.isEmpty) return 'Empty';
                  return null;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                controller: _mailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                validator: (val) {
                  if (val == null) return 'Email is required';
                  if (val.isEmpty) return 'Empty';
                  return null;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                validator: (val) {
                  if (val == null) return 'Password is required';
                  if (val.isEmpty) return 'Empty';
                  return null;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                obscureText: true,
                controller: _confirmPassController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                ),
                validator: (val) {
                  if (val == null) return 'Confirm the password';
                  if (val.isEmpty) return 'Empty';
                  if (val != _passwordController.text) return 'Not Matching';
                  return null;
                },
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  child: const Text('Sign up'),
                  onPressed: () {
                    var validated = _form.currentState!.validate();
                    if (validated) {
                      context.read<AuthBloc>().add(AuthRegisterEvent(
                            email: _mailController.text,
                            username: _nameController.text,
                            password: _passwordController.text,
                          ));
                      context.router.push(const HomeRoute());
                    }
                    //context.router.push(const HomeRoute());
                    //print(nameController.text);
                    //print(passwordController.text);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
