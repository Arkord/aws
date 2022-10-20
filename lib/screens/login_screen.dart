import 'package:aws/services/auth_credentials.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final ValueChanged<LoginCredentials>? didProvideCredentials;
  final VoidCallback? shouldShowSignUp;

  const LoginScreen({ Key? key,  this.shouldShowSignUp, this.didProvideCredentials }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 40),
           child: Stack(children: [
            // Login Form
            _loginForm(),

            // Sign Up Button
            Container(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                  onPressed: widget.shouldShowSignUp,
                  child: const Text('Don\'t have an account? Sign up.')),
            )
          ])),
    );
  }

  Widget _loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username TextField
        TextField(
          controller: _usernameController,
          decoration:
              const InputDecoration(icon: Icon(Icons.mail), labelText: 'Username'),
        ),

        // Password TextField
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(
              icon: Icon(Icons.lock_open), labelText: 'Password'),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),

        // Login Button
        ElevatedButton(
            onPressed: _login,
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue
            ),
            child: const Text('Login')
        )
      ],
    );
  }

  // 7
  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    print('username: $username');
    print('password: $password');

    final credentials = LoginCredentials(username: username, password: password);
    widget.didProvideCredentials!(credentials);

  }
}