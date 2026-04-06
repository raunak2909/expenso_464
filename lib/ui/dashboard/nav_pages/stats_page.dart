import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsNavPage extends StatelessWidget {
  List<int> data = [1000, 21000, 40000, 5000, 4400, 3000, 7700];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stats'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 11, vertical: 21),
          margin: EdgeInsets.symmetric(horizontal: 11),
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.pink.shade200,
            borderRadius: BorderRadius.circular(11)
          ),
          child: BarChart(BarChartData(
            maxY: 70000,
            barGroups: List.generate(data.length, (index){
              return BarChartGroupData(x: index, 
                  barRods: [
                BarChartRodData(toY: data[index].toDouble(), borderRadius: BorderRadius.vertical(top: Radius.circular(5)), color: Colors.white, width: 30),
              ]);
            })
          )),
        ),
      ),
    );
  }
}
