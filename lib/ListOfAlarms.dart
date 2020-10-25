import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yalarm/Alarms.dart';
import 'package:yalarm/SingleAlarmWidget.dart';
import 'package:yalarm/alarmsProvider.dart';

class ListOfAlarms extends StatefulWidget {
  ListOfAlarms({Key key}) : super(key: key);
  _ListOfAlarmsState createState() => _ListOfAlarmsState();
}

class _ListOfAlarmsState extends State<ListOfAlarms> {
  @override
  Widget build(BuildContext context) {
    List<Widget> allWidgetsAlarms = List<Widget>();
    return Consumer<AlarmsProvider>(
      builder: (_, alarmsProviderItem, child) {
        List<YAlarms> localAlarms = alarmsProviderItem.alarms;
        if (localAlarms.length != 0) {
          allWidgetsAlarms = [];
          localAlarms.forEach((item) {
            if (item == null) {
              allWidgetsAlarms = [];
              return;
            }
            allWidgetsAlarms.add(SingleAlarmWidget(item: item));
          });
        } else {
          allWidgetsAlarms = [];
        }
        Widget buildBody(BuildContext ctxt, int index) {
          return allWidgetsAlarms[index];
        }

        return Expanded(
          child: Center(
            child: ListView.builder(
              itemCount: allWidgetsAlarms.length,
              padding: const EdgeInsets.only(left: 0.0),
              itemBuilder: (BuildContext ctxt, int index) =>
                  buildBody(ctxt, index),
            ),
          ),
        );
      },
    );
  }
}
