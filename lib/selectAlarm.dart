import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yalarm/Alarms.dart';
import 'alarmsProvider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'yAlarmDayPicker.dart';

class SelectAlarm extends StatefulWidget {
  SelectAlarm({Key key}) : super(key: key);
  @override
  _SelectAlarmState createState() => _SelectAlarmState();
}

class _SelectAlarmState extends State<SelectAlarm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String link = Provider.of<AlarmsProvider>(context, listen: false).rsiLink;
    return Scaffold(
      appBar: AppBar(
        title: Text('select Alarm'),
      ),
      body: Container(
        child: Center(
          child: Text(link),
        ),
      ),
    );
    List<Widget> allWidgetsAlarms = List<Widget>();
    return Consumer<AlarmsProvider>(builder: (_, alarmsProviderItem, child) {
      List<YAlarms> localAlarms = alarmsProviderItem.alarms;

      return Scaffold(
        appBar: AppBar(
          title: Text('select Alarm'),
        ),
        body: Container(
          child: Center(
              child: ListView.builder(
            itemCount: allWidgetsAlarms.length,
            padding: const EdgeInsets.only(left: 0.0),
            itemBuilder: (BuildContext ctxt, int index) =>
                allWidgetsAlarms[index],
          )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // addAlarm
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      );
      ;
    });
  }
}
