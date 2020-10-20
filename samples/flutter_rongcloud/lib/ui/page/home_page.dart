import 'package:flutter/material.dart';
import 'package:base_framework/base_framework.dart';
import 'package:flutter_rongcloud/api/rongclound_services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    setDesignWHD(375,812);
    return Scaffold(
      appBar: AppBar(
        title: Text('RongClund Flutter Demo',),
        centerTitle: true,
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async{
            try{
              var response = await RongCloundServices.getToken('1', "沐枫");
              print(response.data);
            }catch(e,s){

            }
          },
          child: Text('获取Token'),
        ),
      ),
    );
  }
}
