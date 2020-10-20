import 'package:flutter/material.dart';
import 'package:base_framework/base_framework.dart';

class HomePage extends PageState {
  @override
  Widget build(BuildContext context) {
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
