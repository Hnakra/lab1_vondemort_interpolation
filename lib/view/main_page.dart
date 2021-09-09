import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vondemort_interpolation/data/models/dot.dart';
import 'package:vondemort_interpolation/domain/calculate_interpolation.dart';
import 'package:vondemort_interpolation/domain/save_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'card.dart';
import 'chart.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ListOfDots(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lab1_Vandemord_Interpolation',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: const MyHomePage(title: 'Lab1_Vandemord_Interpolation'),
        ));

    ;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    SaveData.controllerOutput.stream
        .listen((list) => context.read<ListOfDots>().refresh(list));
  }

  @override
  Widget build(BuildContext context) {
    List<Dot> list = context.watch<ListOfDots>()._list;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Scrollbar(
        isAlwaysShown: true,
        showTrackOnHover: true,
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            list.isEmpty ? Container() : Chart(list: list),
            for (Dot dot in list)
              DotCard(dot:dot),
            SizedBox(height: 20,)
          ],
        ),
      ),
      floatingActionButton:
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          list.length < 4 ? SizedBox():
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              var rand = new Random();
              double x = (rand.nextDouble() * 10);
              SaveData.controllerInput.add({
                "add": Dot(
                    id: context.read<ListOfDots>().getCounter(),
                    x: x,
                    y: CalculateInterpolation.calculate(x, list),
                    color: "red"
                )
              });
            },
            tooltip: 'Add Dot Without "y"',
            child: const Icon(Icons.add),
          ),
          SizedBox(width: 5,),
          FloatingActionButton(
            onPressed: () {
              var rand = new Random();
              SaveData.controllerInput.add({
                "add": Dot(
                    id: context.read<ListOfDots>().getCounter(),
                    x: (rand.nextDouble() * 10),
                    y: rand.nextDouble() * 10,
                    color: "green"
                )
              });
            },
            tooltip: 'Add Dot',
            child: const Icon(Icons.add),
          ),
        ],
      )

    );
  }
}

class ListOfDots extends ChangeNotifier {
  //визуальное представление списка
  List<Dot> _list = [];
  int _counter = 1;
  getCounter() => _counter++;

  refresh(List<Dot> list) {
    _list = list;
    notifyListeners();
  }

  length() => _list.length;
/*  add(Dot dot){
    _list.add(dot);
    notifyListeners();
  }
  remove(Dot dot){
    _list.remove(dot);
    notifyListeners();
  }*/
}
