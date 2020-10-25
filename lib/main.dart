import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yalarm/ListOfAlarms.dart';
import 'package:yalarm/alarmsProvider.dart';
import 'package:yalarm/selectAlarm.dart';
import 'createAlarm.dart';
import 'Alarms.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AlarmsProvider(),
          ),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'yAlarm'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addAlarm() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => CreateAlarm()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AlarmsProvider>().getLocalStorage();
    // For sharing or opening urls/text coming from outside the app while the app is in the memory

    ReceiveSharingIntent.getTextStream().listen((String value) {
      receivedSharingIntent(value);
    }, onError: (err) {
      print("getLinkStream error: $err");
    });
    ReceiveSharingIntent.getInitialText().then((String value) {
      receivedSharingIntent(value);
    });
  }

  void receivedSharingIntent(String value) {
    if (value.length > 0) return;
    Provider.of<AlarmsProvider>(context, listen: false).setrsiLink(value);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectAlarm()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListOfAlarms(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAlarm,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
