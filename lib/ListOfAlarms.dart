import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yalarm/Alarms.dart';
import 'package:yalarm/SingleAlarmWidget.dart';
import 'package:yalarm/alarmsProvider.dart';

class ListOfAlarms extends StatefulWidget {
  final String type;
  ListOfAlarms({Key key, this.type}) : super(key: key);
  _ListOfAlarmsState createState() => _ListOfAlarmsState();
}

class _ListOfAlarmsState extends State<ListOfAlarms> {
  List<Widget> allWidgetsAlarms = List<Widget>();
  void buildAlarmsList(alarmsProviderItem) {
    List<YAlarms> localAlarms = alarmsProviderItem.alarms;
    if (localAlarms.length != 0) {
      allWidgetsAlarms = [];
      List<Widget> tempAllWidgetsAlarms = [];
      localAlarms.forEach((item) {
        if (item == null) {
          allWidgetsAlarms = [];
          return;
        }
        tempAllWidgetsAlarms.add(SingleAlarmWidget(
            item: item, alarmsProviderItem: alarmsProviderItem, type:widget.type));
      });
      allWidgetsAlarms = tempAllWidgetsAlarms;
    } else {
      allWidgetsAlarms = [];
    }
  }

  Widget buildBody(BuildContext ctxt, int index) {
    return allWidgetsAlarms[index];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmsProvider>(
      builder: (_, alarmsProviderItem, child) {
        buildAlarmsList(alarmsProviderItem);
        return ListView.builder(
          shrinkWrap: true,
          itemCount: allWidgetsAlarms.length,
          padding: const EdgeInsets.only(left: 0.0),
          itemBuilder: (BuildContext ctxt, int index) => buildBody(ctxt, index),
        );
      },
    );
  }
}
