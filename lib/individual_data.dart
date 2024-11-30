import 'package:covid_19/screens/home_screen.dart';
import 'package:flutter/material.dart';

class IndividualData extends StatefulWidget {
  final String name, flag,cases,todayCases,deaths,todayDeaths,recovered,todayRecovered,
  active,critical,population;
   IndividualData({
     required this.name,
  required this.flag,
  required this.cases,
  required this.todayCases,
  required this.deaths,
  required this.todayDeaths,
  required this.recovered,
  required this.todayRecovered,
  required this.active,
  required this.critical,
  required this.population
   });

  @override
  State<IndividualData> createState() => _IndividualDataState();
}

class _IndividualDataState extends State<IndividualData> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name,style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 30
          ),),
          centerTitle: true,
        ),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25,left: 8,right: 8),
                  child: Card(
                    color: Colors.white70,
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        MyWidget(title: 'Total Cases', value: widget.cases),
                        MyWidget(title: 'Recovered', value: widget.recovered),
                        MyWidget(title: 'Deaths', value: widget.deaths),
                        MyWidget(title: 'Active', value: widget.active),
                        MyWidget(title: 'Critical', value: widget.critical),
                        MyWidget(title: 'Today Recovered', value: widget.todayRecovered),
                        MyWidget(title: 'Today Deaths', value: widget.todayDeaths),


                      ],
                    ),
                  ),
                ),
            CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(widget.flag),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}



