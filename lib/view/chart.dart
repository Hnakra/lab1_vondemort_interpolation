import 'package:flutter/material.dart';
import 'package:vondemort_interpolation/data/models/dot.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Chart extends StatelessWidget {
  final List<Dot> list;

  Chart({required this.list});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Dot, double>> dots = [
      charts.Series(
        id: "dots",
        data: list,
        domainFn: (Dot dot, _) => dot.x,
        measureFn: (Dot dot, _) => dot.y,
        colorFn: (Dot dot, _) => charts.ColorUtil.fromDartColor(Colors.grey.shade300),
      ),
      charts.Series(
        id: "dots",
        data: list,
        domainFn: (Dot dot, _) => dot.x,
        measureFn: (Dot dot, _) => dot.y,
        colorFn: (Dot dot, _) => charts.ColorUtil.fromDartColor( dot.color == "green" ?Colors.green: Colors.red),
      )..setAttribute(charts.rendererIdKey, 'customPoint')
    ];
    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "Множество добавляемых точек",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              Expanded(
                child:
                charts.NumericComboChart(
                    dots,
                    animate: true,
                    defaultRenderer: charts.LineRendererConfig(),
                       customSeriesRenderers: [
                       charts.PointRendererConfig(
                        // ID used to link series to this renderer.
                          customRendererId: 'customPoint')
                    ]
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}