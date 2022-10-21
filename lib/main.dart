import 'package:aws/helpers/camera_helper.dart';
import 'package:aws/screens/login_screen.dart';
import 'package:aws/screens/sign_up_screen.dart';
import 'package:aws/screens/verification_screen.dart';
import 'package:aws/services/auth_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 1
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _authService.showLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Gallery App',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      home: StreamBuilder<AuthState>(
        stream: _authService.authStateController.stream,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Navigator(
              pages: [
                if(snapshot.data?.authFlowStatus == AuthFlowStatus.login) 
                  MaterialPage(child: LoginScreen(
                    shouldShowSignUp: _authService.showSignUp,
                    didProvideCredentials: _authService.loginWithCredentials,
                  )),
                if(snapshot.data?.authFlowStatus == AuthFlowStatus.signUp)
                  MaterialPage(child: SignUpScreen(
                    shouldShowLogin: _authService.showLogin,
                    didProvideCredentials: _authService.signUpWithCredentials,
                  )),
                  if(snapshot.data?.authFlowStatus == AuthFlowStatus.verification) 
                    MaterialPage(child: VerificationScreen (
                      didProvideVerificationCode: _authService.verifyCode,
                    )),
                  if(snapshot.data?.authFlowStatus == AuthFlowStatus.session)
                    MaterialPage(child: CameraHelper(
                      shouldLogOut: _authService.logOut,
                    ))
                ],
              onPopPage: (route, result) => route.didPop(result),
            );
          }
          else {
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
        } 
      ),
    );
  }
}