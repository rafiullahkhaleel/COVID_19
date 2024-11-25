import 'dart:convert';
import 'package:covid_19/model/countriesmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  List<Countriesmodel> dataList = [];
  List<Countriesmodel> filteredList = [];

  Future<List<Countriesmodel>> getCountryData() async {
    var response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<Countriesmodel> tempList = [];
      for (Map i in data) {
        tempList.add(Countriesmodel.fromJson(i));
      }
      return tempList;
    } else {
      throw Exception('Error');
    }
  }

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCountryData().then((data) {
      setState(() {
        dataList = data;
        filteredList = data;
      });
    });
    searchController.addListener(() {
      filterCountries();
    });
  }

  void filterCountries() {
    setState(() {
      filteredList = dataList.where((country) {
        return country.country!
            .toLowerCase()
            .contains(searchController.text.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search with country name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ),
          filteredList.isEmpty
              ? const CircularProgressIndicator()
              : Expanded(
                  child: ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                const SizedBox(width: 10),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      filteredList[index].countryInfo!.flag.toString()),
                                  radius: 30,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      filteredList[index].country.toString(),
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      filteredList[index].continent.toString(),
                                      style: const TextStyle(fontSize: 11),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
        ],
      ),
    );
  }
}

// import 'dart:convert';
//
// import 'package:covid_19/model/countriesmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
//
// class CountriesList extends StatefulWidget {
//   const CountriesList({super.key});
//
//   @override
//   State<CountriesList> createState() => _CountriesListState();
// }
//
// class _CountriesListState extends State<CountriesList> {
//   List<Countriesmodel> dataList = [];
//
//   Future<List<Countriesmodel>> getCountryData()async{
//     var response = await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
//     if(response.statusCode == 200){
//
//      var data = jsonDecode(response.body);
//      for(Map i in data){
//         dataList.add(Countriesmodel.fromJson(i));
//      }
//      return dataList;
//     }else{
//       throw Exception('Error');
//     }}
//     TextEditingController searchController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: TextField(
//               controller: searchController,
//               onChanged: (value){
//                setState(() {
//                });
//               },
//               decoration: InputDecoration(
//                 hintText: 'Search with country name',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(50))
//               ),
//             ),
//           ),
//           FutureBuilder(
//               future: getCountryData(),
//               builder: (context,AsyncSnapshot<List<Countriesmodel>> snapshot){
//                 if(!snapshot.hasData){
//                   return const CircularProgressIndicator();
//                 }else{
//                   return  Expanded(
//                     child: ListView.builder(
//                         itemCount: snapshot.data!.length,
//                         itemBuilder: (context,index){
//                           String name = snapshot.data![index].country.toString();
//                           if(searchController.text.isEmpty){
//                             return Column(
//                               children: [
//                                 const SizedBox(height: 15,),
//                                 Row(
//                                   children: [
//                                     const SizedBox(width: 10,),
//                                     CircleAvatar(
//                                       backgroundImage: NetworkImage(snapshot.data![index].countryInfo!.flag.toString()),
//                                       radius: 30,
//                                     ),
//                                     const SizedBox(width: 10,),
//                                     Column(
//                                       children: [
//                                         Text(snapshot.data![index].country.toString(),
//                                           style: const TextStyle(
//                                               fontSize: 15
//                                           ),
//                                         ),
//                                         Text(snapshot.data![index].continent.toString(),
//                                           style: const TextStyle(
//                                               fontSize: 11
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             );
//                           }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
//                             return Column(
//                               children: [
//                                 const SizedBox(height: 15,),
//                                 Row(
//                                   children: [
//                                     const SizedBox(width: 10,),
//                                     CircleAvatar(
//                                       backgroundImage: NetworkImage(snapshot.data![index].countryInfo!.flag.toString()),
//                                       radius: 30,
//                                     ),
//                                     const SizedBox(width: 10,),
//                                     Column(
//                                       children: [
//                                         Text(snapshot.data![index].country.toString(),
//                                           style: const TextStyle(
//                                               fontSize: 15
//                                           ),
//                                         ),
//                                         Text(snapshot.data![index].continent.toString(),
//                                           style: const TextStyle(
//                                               fontSize: 11
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             );
//                           }else{
//                             return Container();
//                           }
//                         }),
//                   );
//                 }
//               })
//         ],
//       )
//     );
//   }
// }
//
//
//
