import 'dart:async';
import 'package:cirestapimobile/views/congratulation.dart';
import 'package:cirestapimobile/views/sendmail.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cirest API Mobile',
      home: MyHomePage(title: 'Cirest API Mobile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Uri? _initialUri;
  bool _initialUriIsHandled = false;

  Future<void> _handleInitialUri() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print("No uri detected!");
        } else {
          print("Uri detected !");
        }
        if (!mounted) return;
        setState(() {
          _initialUri = uri;
        });
      } on PlatformException {
        print("Failed to get uri!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initialUri == null) {
      _handleInitialUri();
      return const SendMail();
    } else {
      return const Congratulation();
    }
  }
}
