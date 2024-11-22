import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          PieChart(
            dataMap: pieList,
            chartType: ChartType.ring,
            chartRadius: 180,
            animationDuration: const Duration(milliseconds: 2000),
            colorList: colorList,
            legendOptions:
                const LegendOptions(legendPosition: LegendPosition.left),
          ),
          const Padding(

            padding: EdgeInsets.all(20),
            child: Card(
                child: Column(
              children: [
                MyWidget(title: 'Hello', value: 'World'),
                MyWidget(title: 'Hello', value: 'World'),
                MyWidget(title: 'Hello', value: 'World'),
              ],
            )),
          )
        ],
      )),
    );
  }

  final pieList = <String, double>{'Total': 30, 'Recover': 10, 'Death': 20};
  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];
}

class MyWidget extends StatelessWidget {
  final String title;
  final String value;
  const MyWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          )
        ],
      ),
    );
  }
}
