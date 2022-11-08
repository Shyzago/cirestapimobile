import 'dart:convert';
import 'package:cirestapimobile/services/smtpservice.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SendMail extends StatefulWidget {
  const SendMail({Key? key}) : super(key: key);

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  @override
  void initState() {
    super.initState();
  }

  final ctrlEmail = TextEditingController();
  final _emailKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    ctrlEmail.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Mail'),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _emailKey,
            child: TextFormField(
              controller: ctrlEmail,
              autocorrect: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: Colors.white,
              keyboardType: TextInputType.emailAddress,
              validator: ((value) {
                return !EmailValidator.validate(value.toString())
                    ? 'You must input a valid email!'
                    : null;
              }),
            ),
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: (() async {
          if (_emailKey.currentState!.validate()) {
            await SMTPService.sendMail(ctrlEmail.text).then((value) {
              var result = json.decode(value.body);
              print(result);
              Fluttertoast.showToast(
                  msg: (result['message'] ?? result['error']),
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: (result['message'] == null
                      ? Colors.redAccent
                      : Colors.greenAccent),
                  textColor: Colors.white,
                  fontSize: 14.0);
            });
          } else {
            Fluttertoast.showToast(
                msg: "Invalid email addresses or empty fields must be filled!",
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: Colors.redAccent,
                textColor: Colors.white,
                fontSize: 14.0);
          }
        }),
        child: const Icon(Icons.send),
      ),
    );
  }
}
