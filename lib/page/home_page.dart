import 'package:flutter/material.dart';
import 'package:base_framework/base_framework.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    setDesignWHD(375, 812);
    return Scaffold(
      appBar: AppBar(
        title: Text('Awesome Flutter Demo',),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Awesome Flutter Demoaaa'),
      ),
    );
  }
}
