import 'package:ext_video_player/ext_video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yalarm/Alarms.dart';
import 'alarmsProvider.dart';

class SelectAlarm extends StatefulWidget {
  SelectAlarm({Key key}) : super(key: key);
  @override
  _SelectAlarmState createState() => _SelectAlarmState();
}

class _SelectAlarmState extends State<SelectAlarm> {
  VideoPlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      String link = Provider.of<AlarmsProvider>(context, listen: false).rsiLink;
      _controller = VideoPlayerController.network(
        link,
      )..initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    String link = Provider.of<AlarmsProvider>(context, listen: false).rsiLink;
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Alarm'),
      ),
      body: Container(
        child: Center(
          child: Column(children: [
            Container(child: VideoPlayer(_controller), width: 300, height: 180),
            FlatButton(
              child: Text(_controller.value.isPlaying ? 'Pause' : 'Play'),
              onPressed: () {
                setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();  
                });
                
              },
            )
          ]),
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
