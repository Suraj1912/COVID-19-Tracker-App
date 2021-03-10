import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DistrictPage extends StatefulWidget {
  @override
  _DistrictPageState createState() => _DistrictPageState();
}

class _DistrictPageState extends State<DistrictPage> {


  List districtData;
  List district = new List();
  List dist = new List();
  
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

    List districts = new List();
    List confirmed = new List();
    List active = new List();
    List deceased = new List();
    List recovered = new List(); 
    

    if (districtData != null){
    for (int i=0; i<districtData.length; i++){
      dist = districtData[i]['districtData'];
      for(int j=0;j<dist.length;j++){
        districts.add(dist[j]['district']);
        confirmed.add(dist[j]['confirmed']);
        active.add(dist[j]['active']);
        deceased.add(dist[j]['deceased']);
        recovered.add(dist[j]['recovered']);

      }
    }
    }
    
    

    return Scaffold(
      appBar: AppBar(
        
        title: Text('District Stats'),
      ),
      body: districtData == null
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.cyanAccent,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            )
          : ListView.builder(
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
                                districts[index],
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
                                      confirmed[index].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ),
                                Text(
                                  'ACTIVE: ' +
                                      active[index].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                                Text(
                                  'RECOVERED: ' +
                                      recovered[index].toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                                Text(
                                  'DEATHS: ' +
                                      deceased[index].toString(),
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
              itemCount: districts == null ? 0 : districts.length,
            )
    );
  }


}