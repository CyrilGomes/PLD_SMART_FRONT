import 'package:auto_route/auto_route.dart';
import 'package:caption_this/Features/auth/BloC/bloc/auth_bloc.dart';
import 'package:caption_this/Features/auth/presentation/pages/sign_up_page.dart';
import 'package:caption_this/Features/password_reset/presentation/pages/password_reset_page.dart';
import 'package:caption_this/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/repositories/auth_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var storage = const FlutterSecureStorage();
    storage.read(key: 'jwt').then((value) {
      if (value != null) {
        //context.router.replace(MainMapRoute());
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: const MyStatefulLoginWidget(),
    );
  }
}

class MyStatefulLoginWidget extends StatefulWidget {
  const MyStatefulLoginWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulLoginWidget> createState() => _MyStatefulLoginWidgetState();
}

class _MyStatefulLoginWidgetState extends State<MyStatefulLoginWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          TextButton(
              onPressed: () {
                //context.router.push(const PasswordResetRoute());
              },
              child: const Text(
                'Sign in',
                style: TextStyle(fontSize: 20),
              )),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              //context.router.push(const PasswordResetPageRoute());
            },
            child: const Text(
              'Forgot Password',
            ),
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      Scaffold.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Connection Error"),
                        ),
                      );
                    }
                    if (state is AuthLoginSuccess) {
                      context.router.push(MainMapRoute());
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator();
                    }

                    return const Text('Login');
                  },
                ),
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(
                    AuthLoginEvent(
                        username: nameController.text,
                        password: passwordController.text),
                  );
                  //print(nameController.text);
                  //print(passwordController.text);
                },
              )),
          Row(
            children: <Widget>[
              const Text('No account?'),
              TextButton(
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  //signup screen
                  context.router.push(const SignUpRoute());
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
