import 'package:covid19/datasource.dart';
import 'package:covid19/pages/statepage.dart';
import 'package:flutter/material.dart';

import 'district2page.dart';

class SearchCountry extends SearchDelegate {
  final List countrylist;

  SearchCountry(this.countrylist);


  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Theme.of(context).brightness == Brightness.dark ? primaryBlack : Colors.white,
      brightness: Theme.of(context).brightness
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final suggestionList = query.isEmpty
        ? countrylist
        : countrylist
            .where((element) =>
                element['country'].toString().toLowerCase().startsWith(query))
            .toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return Card(
            child: GestureDetector(
                onTap: (){
                  if(suggestionList[index]['country'] == 'India'){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StatePage()));
                  }
                },
                child: Container(
                height: 130,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 200,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            suggestionList[index]['country'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Image.network(
                            suggestionList[index]['countryInfo']['flag'],
                            height: 50,
                            width: 60,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'CONFIRMED: ' +
                                suggestionList[index]['cases'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          Text(
                            'ACTIVE: ' +
                                suggestionList[index]['active'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                          Text(
                            'RECOVERED: ' +
                                suggestionList[index]['recovered'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.green),
                          ),
                          Text(
                            'DEATHS: ' +
                                suggestionList[index]['deaths'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey[100]
                                    : Colors.grey[900]),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class SearchState extends SearchDelegate{

  final Map stateData;

  SearchState(this.stateData);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Theme.of(context).brightness == Brightness.dark ? primaryBlack : Colors.white,
      brightness: Theme.of(context).brightness
    );
  }
  
  @override
  List<Widget> buildActions(BuildContext context) {
     return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
       return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
    
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List stateList = stateData['data']['regional'];
    
    final suggestionList = query.isEmpty
        ? stateList
        : stateList.where((element) => element['loc'].toString().toLowerCase().startsWith(query)).toList();
           

            return ListView.builder(
              itemCount: suggestionList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: GestureDetector(
                    onTap: (){
                        String states =  suggestionList[index]['loc'].toString().toLowerCase();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => District2Page(states: states)));
                      },
                      child: Container(
                      height: 130,
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 200,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  suggestionList[index]['loc'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                 
                              ],
                            ),
                          ),
                          Expanded(
                              child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Total Cases: ' +
                                      suggestionList[index]['totalConfirmed'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                Text(
                                  'Indian Nationals: ' +
                                      suggestionList[index]['confirmedCasesIndian'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.brown[100]
                                          : Colors.brown[900]),
                                ),
                                Text(
                                  'Discharged: ' +
                                      suggestionList[index]['discharged'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                                Text(
                                  'DEATHS: ' +
                                      suggestionList[index]['deaths'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.grey[100]
                                          : Colors.grey[900]),
                                ),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                );
              },
              
            );
    
    
  }
  
}



class SearchDistrict extends SearchDelegate {
  final List districtList;

  SearchDistrict(this.districtList);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Theme.of(context).brightness == Brightness.dark ? primaryBlack : Colors.white,
      brightness: Theme.of(context).brightness
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final suggestionList = query.isEmpty
        ? districtList
        : districtList
            .where((element) =>
                element['district'].toString().toLowerCase().startsWith(query))
            .toList();

    return ListView.builder(
            itemCount: suggestionList == null ? 0 : suggestionList.length,
              itemBuilder: (context, index) { 
                return Card(
                  child: Container(
                    height: 130,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 200,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                suggestionList[index]['district'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                  'CONFIRMED: ' +
                                      suggestionList[index]['confirmed'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                Text(
                                  'ACTIVE: ' +
                                      suggestionList[index]['active'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                Text(
                                  'RECOVERED: ' +
                                      suggestionList[index]['recovered'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                                Text(
                                  'DEATHS: ' +
                                      suggestionList[index]['deceased'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.grey[100]
                                          : Colors.grey[900]),
                                ),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ),
                );
              },
             
            );

  }
}

class SearchDistrictLevelZones extends SearchDelegate {
  final Map districtLevelZoneData;

  SearchDistrictLevelZones(this.districtLevelZoneData);



  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primaryColor: Theme.of(context).brightness == Brightness.dark ? primaryBlack : Colors.white,
      brightness: Theme.of(context).brightness
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final suggestionList = query.isEmpty
        ? districtLevelZoneData['zones']
        : districtLevelZoneData['zones']
            .where((element) =>
                element['district'].toString().toLowerCase().startsWith(query))
            .toList();

      return ListView.builder(
              itemCount: suggestionList == null ? 0 : suggestionList.length,
              itemBuilder: (context, index){
                return Card(
                  child: Container(
                    height: 90,
                   
                    // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: suggestionList[index]['zone'].toString().toLowerCase() == 'green'
                                      ? Colors.green[300]
                                      : (suggestionList[index]['zone'].toString().toLowerCase() == 'red'
                                      ? Colors.red[300] 
                                      : Colors.orange[300]
                                      ),
                      ),
                      color: suggestionList[index]['zone'].toString().toLowerCase() == 'green'
                                      ? Colors.green[300]
                                      : (suggestionList[index]['zone'].toString().toLowerCase() == 'red'
                                      ? Colors.red[300] 
                                      : Colors.orange[300]
                                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Row(
                      children: <Widget>[
                       
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            suggestionList[index]['district'],
                            style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: suggestionList[index]['zone'].toString().toLowerCase() == 'green'
                                        ? Colors.green[900]
                                        : (suggestionList[index]['zone'].toString().toLowerCase() == 'red'
                                        ? Colors.red[900] 
                                        : Colors.orange[900]
                                        )
                                        ),
                          ),
                        )
                      ],
                    ),
                  ),                 
                );
              } 
              );
       
  }
}