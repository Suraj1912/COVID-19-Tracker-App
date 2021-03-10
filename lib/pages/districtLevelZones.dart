import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'search.dart';

class DistrictLevelZones extends StatefulWidget {
  @override
  _DistrictLevelZonesState createState() => _DistrictLevelZonesState();
}

class _DistrictLevelZonesState extends State<DistrictLevelZones> {

  Map districtLevelZonesData;
  fetchDistrictLevelZonesData() async {
    http.Response response =
        await http.get('https://api.covid19india.org/zones.json');
    setState(() {
      districtLevelZonesData = json.decode(response.body);
    });
  }
  @override
  void initState() {
    fetchDistrictLevelZonesData();
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
              showSearch(context: context, delegate: SearchDistrictLevelZones(districtLevelZonesData));
            },
          )
        ],
        title: Text('District Level Zones'),
      ),
      body:  districtLevelZonesData == null
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.cyanAccent,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            )
            :ListView.builder(
              itemCount: districtLevelZonesData == null ? 0 : districtLevelZonesData['zones'].length,
              itemBuilder: (context, index){
                return Card(
                  child: Container(
                    height: 90,
                   
                    // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: districtLevelZonesData['zones'][index]['zone'].toString().toLowerCase() == 'green'
                                      ? Colors.green[300]
                                      : (districtLevelZonesData['zones'][index]['zone'].toString().toLowerCase() == 'red'
                                      ? Colors.red[300] 
                                      : Colors.orange[300]
                                      ),
                      ),
                      color: districtLevelZonesData['zones'][index]['zone'].toString().toLowerCase() == 'green'
                                      ? Colors.green[300]
                                      : (districtLevelZonesData['zones'][index]['zone'].toString().toLowerCase() == 'red'
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
                            districtLevelZonesData['zones'][index]['district'],
                            style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: districtLevelZonesData['zones'][index]['zone'].toString().toLowerCase() == 'green'
                                        ? Colors.green[900]
                                        : (districtLevelZonesData['zones'][index]['zone'].toString().toLowerCase() == 'red'
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
              ),
    );
  }
}