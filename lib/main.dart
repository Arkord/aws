import 'package:aws/screens/login_screen.dart';
import 'package:aws/screens/sign_up_screen.dart';
import 'package:aws/services/auth_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// 1
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery App',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      home: StreamBuilder<AuthState>(
        stream: _authService.authStateController.stream,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Navigator(
              pages: [
                MaterialPage(child: LoginScreen()),
                MaterialPage(child: SignUpScreen()),
                ],
              onPopPage: (route, result) => route.didPop(result),
            );
          }
        } 
      ),
    );
  }
}