import 'package:ext_video_player/ext_video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yalarm/ListOfAlarms.dart';
import 'alarmsProvider.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Alarm'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Provider.of<AlarmsProvider>(context, listen: false)
                .setrsiLink(null);
                Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Center(
          child: Column(children: [
            Container(
              child: new ListOfAlarms(type: 'select'),
            )
          ]),
        ),
      ),
    );
  }
}
