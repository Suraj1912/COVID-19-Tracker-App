import 'package:covid19/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'district2page.dart';


class StatePage extends StatefulWidget {
  
    
  @override
  _StatePageState createState() => _StatePageState();

}

class _StatePageState extends State<StatePage>{

  Map stateData;
  fetchStateData() async {
    http.Response response =
        await http.get('https://api.rootnet.in/covid19-in/stats/latest');
    setState(() {
      stateData = json.decode(response.body);
    });
  }
  @override
  void initState() {
    fetchStateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchState(stateData));
            },
          )
        ],
        title: Text('India Stats'),
      ),
      body: stateData == null
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.cyanAccent,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: GestureDetector(
                      onTap: (){
                        
                        String states =  stateData['data']['regional'][index]['loc'].toString().toLowerCase();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => District2Page(states: states)));
                      },
                      child: Container(
                      height: 150,
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
                                  stateData['data']['regional'][index]['loc'],
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
                                      stateData['data']['regional'][index]['totalConfirmed'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                Text(
                                  'Indian Nationals: ' +
                                      stateData['data']['regional'][index]['confirmedCasesIndian'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.brown[100]
                                          : Colors.brown[900]),
                                ),
                                Text(
                                  'Discharged: ' +
                                      stateData['data']['regional'][index]['discharged'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                                Text(
                                  'Deaths: ' +
                                      stateData['data']['regional'][index]['deaths'].toString(),
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
              itemCount: stateData == null ? 0 : stateData['data']['regional'].length,
            )
    );
  }


}
