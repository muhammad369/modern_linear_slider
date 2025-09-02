import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:modern_linear_slider/modern_linear_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int val = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(val.toString()),
              SizedBox(height: 30),
              ModernLinearSlider(
                backgroundColor: Colors.black26,
                foregroundColor: Colors.blueAccent,
                disabledColor: Colors.indigoAccent,
                value: val.toDouble(),
                onValueChanging: (i) {
                  setState(() {
                    val = i.toInt();
                  });
                },
                onValueChanged: (i) {},
              ),
              SizedBox(height: 30),
              Text('RTL example'),
              ModernLinearSlider(
                ltr: false,
                backgroundColor: Colors.black26,
                foregroundColor: Colors.blueAccent,
                disabledColor: Colors.indigoAccent,
                value: val.toDouble(),
                onValueChanging: (i) {
                  setState(() {
                    val = i.ceil();
                  });
                },
                onValueChanged: (i) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
