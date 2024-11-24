import 'dart:convert';

import 'package:covid_19/model/CovidAPIModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:http/http.dart'as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  Future<CovidApiModel> getData()async{
    final response = await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));

    if (response.statusCode == 200){
      var data = jsonDecode(response.body);
      return CovidApiModel.fromJson(data);
    }else{
      throw Exception('Error');
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
                children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        FutureBuilder(
            future: getData(),
            builder: (context,AsyncSnapshot<CovidApiModel> snapshot){
              if(!snapshot.hasData){
                return const Expanded(
                    child: SpinKitSpinningLines(
                      color: Colors.black,
                    )
                );
              }else{
                return Column(
                  children: [
                    PieChart(
                      dataMap: {
                        'Total': double.parse(snapshot.data!.cases.toString()),
                        'Recovered':double.parse(snapshot.data!.recovered.toString()),
                        'Deaths':double.parse(snapshot.data!.deaths.toString()),
                      },
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValuesInPercentage: true
                      ),
                      chartType: ChartType.ring,
                      chartRadius: 160,
                      animationDuration: const Duration(milliseconds: 2000),
                      colorList: colorList,
                      legendOptions:
                      const LegendOptions(legendPosition: LegendPosition.left),
                    ),
                     Padding(
                      padding: const EdgeInsets.all(20),
                      child: Card(
                          child: Column(
                            children: [
                              MyWidget(title: 'Total', value: snapshot.data!.cases.toString(),),
                              MyWidget(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                              MyWidget(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                              MyWidget(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                              MyWidget(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                              MyWidget(title: 'Today Cases', value: snapshot.data!.todayCases.toString()),
                              MyWidget(title: 'Active', value: snapshot.data!.active.toString()),
                              MyWidget(title: 'Critical', value: snapshot.data!.critical.toString()),
                              MyWidget(title: 'Affected Countries', value: snapshot.data!.affectedCountries.toString())
                            ],
                          )),
                    )
                  ],
                );
              }
            }),
        
                ],
              ),
      ),
    );
  }


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
      padding:  const EdgeInsets.all(15),
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
