import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yalarm/alarmsProvider.dart';
import 'createAlarm.dart';
import 'Alarms.dart';

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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CreateAlarm()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AlarmsProvider>(context, listen: false).getLocalStorage();
  }

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
            double screenWidth = MediaQuery.of(context).size.width;
            allWidgetsAlarms.add(
              Builder(
                builder: (BuildContext context) {
                  return Dismissible(
                    key: Key(item.id.toString()),
                    child: InkWell(
                      child: Container(
                        width: screenWidth,
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 16.0, bottom: 16.0, right: 0.0),
                        decoration: BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.grey))),
                        child: Text(
                          item.title,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateAlarm(item: item)));
                      },
                    ),
                    background: Container(
                      color: Colors.red,
                    ),
                    onDismissed: (direction) {
                      final snackBar = SnackBar(
                        content: Text('Delete Alarm "${item.title}"'),
                      );
                      Scaffold.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                      setState(() {
                        alarmsProviderItem.removeAlarm(item.id);
                      });
                    },
                  );
                },
              ),
            );
          });
        } else {
          allWidgetsAlarms = [];
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
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
            onPressed: _addAlarm,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
