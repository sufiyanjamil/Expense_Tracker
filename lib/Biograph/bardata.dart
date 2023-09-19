import 'package:flutter_expensetracker_app/Biograph/biograph.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tuesAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tuesAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });
  List<ExIndivualBar> barData = [];
  void initializebarData() {
    barData = [
      ExIndivualBar(x: 0, y: sunAmount),
      ExIndivualBar(x: 0, y: monAmount),
      ExIndivualBar(x: 0, y: tuesAmount),
      ExIndivualBar(x: 0, y: wedAmount),
      ExIndivualBar(x: 0, y: thurAmount),
      ExIndivualBar(x: 0, y: friAmount),
      ExIndivualBar(x: 0, y: satAmount),
    ];
  }
}
