import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_expensetracker_app/Biograph/bardata.dart';

class Bar_graph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tuesAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;
  Bar_graph({
    super.key,
    required this.maxY,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount,
    required this.monAmount,
    required this.thurAmount,
    required this.tuesAmount,
    required this.wedAmount,
  });

  @override
  Widget build(BuildContext context) {
    BarData myBardata = BarData(
      sunAmount: sunAmount,
      monAmount: monAmount,
      tuesAmount: tuesAmount,
      wedAmount: wedAmount,
      thurAmount: thurAmount,
      friAmount: friAmount,
      satAmount: satAmount,
    );
    myBardata.initializebarData();
    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: GettitlesWidget,
            ),
          ),
        ),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: myBardata.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    width: 25,
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      color: Colors.grey[200],
                      toY: maxY,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget GettitlesWidget(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(
          "S",
          style: style,
        );
        break;
      case 1:
        text = Text(
          "M",
          style: style,
        );
        break;
      case 2:
        text = Text(
          "T",
          style: style,
        );
        break;
      case 3:
        text = Text(
          "W",
          style: style,
        );
        break;
      case 4:
        text = Text(
          "T",
          style: style,
        );
        break;
      case 5:
        text = Text(
          "F",
          style: style,
        );
        break;
      case 6:
        text = Text(
          "S",
          style: style,
        );
        break;
      default:
        text = Text(
          "",
          style: style,
        );
        break;
    }

    return SideTitleWidget(child: text, axisSide: meta.axisSide);
  }
}
