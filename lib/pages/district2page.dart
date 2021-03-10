import 'package:covid19/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class District2Page extends StatefulWidget {

  final String states;

  const District2Page({Key key, this.states}) : super(key: key);
  
  @override
  _District2PageState createState() => _District2PageState();
}

class _District2PageState extends State<District2Page> {

  List districtData;
  List district;

   fetchDistrictData() async {
    http.Response response= await http.get('https://api.covid19india.org/v2/state_district_wise.json');
    setState(() {
      districtData = json.decode(response.body);
    }); 
  }


  @override
  void initState() {
    fetchDistrictData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    if (districtData != null){
      for (int i = 0; i< districtData.length; i++){
        if (districtData[i]['state'].toString().toLowerCase() == widget.states){
          district = districtData[i]['districtData'];
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchDistrict(district));
            },
          )
        ],
        title: Text(widget.states.toUpperCase()),
      ),
      body: districtData == null
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.cyanAccent,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            )
          : ListView.builder(
            itemCount: district == null ? 0 : district.length,
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
                                district[index]['district'],
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
                                      district[index]['confirmed'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                Text(
                                  'ACTIVE: ' +
                                      district[index]['active'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                Text(
                                  'RECOVERED: ' +
                                      district[index]['recovered'].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                                Text(
                                  'DEATHS: ' +
                                      district[index]['deceased'].toString(),
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
             
            ),
      );
  }
}