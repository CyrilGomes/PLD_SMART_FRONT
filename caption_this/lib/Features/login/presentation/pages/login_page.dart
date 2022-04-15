import 'package:auto_route/auto_route.dart';
import 'package:caption_this/Features/login/domain/entities/login_info.dart';
import 'package:caption_this/Features/password_reset/presentation/pages/password_reset_page.dart';
import 'package:caption_this/routes/router.gr.dart';
import 'package:flutter/material.dart';
import '../../domain/repositories/login_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: FutureBuilder(
                  builder: ((context, AsyncSnapshot<LoginInfo> snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!.username + ' ' + snapshot.data!.password,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      );
                    }
                    return const Text('Loul');
                  }),
                  future: LoginRepository().getLogin()),
            ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
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
                  labelText: 'User Name',
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
                context.router.push(const PasswordResetPageRoute());
              },
              child: const Text(
                'Forgot Password',
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    print(nameController.text);
                    print(passwordController.text);
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
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ));
  }
}
