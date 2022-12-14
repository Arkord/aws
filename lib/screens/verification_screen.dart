import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  final ValueChanged<String>? didProvideVerificationCode;

  const VerificationScreen({Key? key, this.didProvideVerificationCode}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _verificationCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 40),
        child: _verificationForm(),
      )
    );
  }

  Widget _verificationForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _verificationCodeController,
          decoration: const InputDecoration(
            icon: Icon(Icons.confirmation_number),
            labelText: 'Verification code'
          ),
        ),
          ElevatedButton(
            onPressed: _verify,
            style: ElevatedButton.styleFrom(
              primary: Colors.lightBlue
            ),
            child: const Text('Verify'),
          )
      ],
    );
  }

  void _verify() {
    final verificationCode = _verificationCodeController.text.trim();
    widget.didProvideVerificationCode!(verificationCode);
  }

}