import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yalarm/Alarms.dart';
import 'package:yalarm/alarmsProvider.dart';
import 'package:yalarm/createAlarm.dart';
import 'package:yalarm/screenArguments.dart';

class SingleAlarmWidget extends StatefulWidget {
  final YAlarms item;
  final AlarmsProvider alarmsProviderItem;
  SingleAlarmWidget({Key key, this.item, this.alarmsProviderItem})
      : super(key: key);

  _SingleAlarmWidgetState createState() => _SingleAlarmWidgetState();
}

class _SingleAlarmWidgetState extends State<SingleAlarmWidget> {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: Text('test2'),
    // );
    return Builder(
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        return Dismissible(
          key: Key(widget.item.id.toString()),
          child: InkWell(
            child: Container(
              width: screenWidth,
              padding: const EdgeInsets.only(
                  left: 10.0, top: 16.0, bottom: 16.0, right: 0.0),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey))),
              child: Text(
                widget.item.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/createAlarm',
                  arguments: ScreenArguments(widget.item));

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => CreateAlarm(item: widget.item),
              //   ),
              // );
            },
          ),
          background: Container(
            color: Colors.red,
          ),
          onDismissed: (direction) {
            final snackBar = SnackBar(
              content: Text('Delete Alarm "${widget.item.title}"'),
            );
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
            setState(() {
              widget.alarmsProviderItem.removeAlarm(widget.item.id);
            });
          },
        );
      },
    );
    // return Container();
  }
}


