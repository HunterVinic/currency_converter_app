import 'package:currency_converter_app/model/chart.dart';
import 'package:currency_converter_app/responsive.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({Key? key, required this.fromCurrency,required this.toCurrency, required this.chartData}) : super(key: key);

  final String fromCurrency;
  final String toCurrency;
  final List<Indicator> chartData;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 30,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(0),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                title: ChartTitle(text: '$fromCurrency/$toCurrency Granularity: 1 Day'),
                legend: !Responsive.isSmallScreen(context) ? Legend(isVisible: true) : Legend(isVisible: false),
                backgroundColor: Color(0xFFCAF2C1),
                tooltipBehavior: TooltipBehavior(enable: false),

                series: <ChartSeries<Indicator, String>>[
                  LineSeries<Indicator, String>(
                    dataSource: chartData,
                    xValueMapper: (Indicator ind, _) => ind.timestamp.toString(),
                    yValueMapper: (Indicator ind, _) => ind.adjclose,
                    name: '$fromCurrency/$toCurrency' ,
                    dataLabelSettings: DataLabelSettings(isVisible: false),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
