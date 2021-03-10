import 'dart:convert';
import 'package:covid19/datasource.dart';
import 'package:covid19/pages/countrypage.dart';
import 'package:covid19/pages/districtLevelZones.dart';
import 'package:covid19/pages/districtpage.dart';
import 'package:covid19/pages/statepage.dart';
import 'package:covid19/panels/infopanel.dart';
import 'package:covid19/panels/worldwidepanel.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map worldData;
  fetchWorldwideData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  List countryData;
  fetchCountryData() async {
    http.Response response =
        await http.get('https://corona.lmao.ninja/v2/countries?sort=cases');
    setState(() {
      countryData = json.decode(response.body);
    });
  }

  Future fetchData() async {
    fetchWorldwideData();
    fetchCountryData();
  }



  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Theme.of(context).brightness == Brightness.light
                  ? Icons.lightbulb_outline
                  : Icons.highlight),
              onPressed: () {
                DynamicTheme.of(context).setBrightness(
                    Theme.of(context).brightness == Brightness.light
                        ? Brightness.dark
                        : Brightness.light);
              })
        ],
        centerTitle: false,
        title:

        Text('COVID-19 TRACKER'),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                'COVID-19 TRACKER',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              accountEmail: Text('GET DATA ANYTIME'),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/corona.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CountryPage()));
              },
              child: ListTile(
                title: Text(
                  'Country Stats',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
            GestureDetector(
              onTap: () {

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StatePage()));
              },
              child: ListTile(
                title: Text(
                  'Indian States Stats',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
            GestureDetector(
              onTap: () {

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DistrictPage()));
              },
              child: ListTile(
                title: Text(
                  'State Districts Stats',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
            GestureDetector(
              onTap: () {

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DistrictLevelZones()));
              },
              child: ListTile(
                title: Text(
                  'District Level Zones',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'WorldWide',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  GestureDetector(
                    onTap: () {

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CountryPage()));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: primaryBlack,
                            borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Countries',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        )),
                  ),
                ],
              ),
            ),
            worldData == null
                ? Center(
                    child: CircularProgressIndicator(
                    // strokeWidth: 10,
                    backgroundColor: Colors.cyanAccent,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                  ))
                : WorldwidePanel(
                    worldData: worldData,
                  ),
            SizedBox(
              height: 10,
            ),
            worldData == null
                ? Container()
                : PieChart(dataMap: {
                    'Confirmed': worldData['cases'].toDouble(),
                    'Active': worldData['active'].toDouble(),
                    'Recovered': worldData['recovered'].toDouble(),
                    'Deaths': worldData['deaths'].toDouble()
                  }, colorList: [
                    Colors.red,
                    Colors.blue,
                    Colors.green,
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.grey[100]
                        : Colors.grey[400]
                  ], chartType: ChartType.ring, showChartValuesOutside: true),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              child: Text(
                'Most Cases Countries',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),

            countryData == null
                ? Container()
                : Container(
                    height: 200,
                    // color: Colors.blue,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {

                              if (countryData[index]['country'] == 'India') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StatePage()));
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.all(10.0),
                              width: 210.0,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: <Widget>[
                                  Positioned(
                                    bottom: 15,
                                    child: Container(
                                      height: 120.0,
                                      width: 200.0,
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(countryData[index]['country'],
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black)),
                                            Text(
                                              'Cases: ' +
                                                  countryData[index]['cases']
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            ),
                                            Text(
                                              'Recovered: ' +
                                                  countryData[index]
                                                          ['recovered']
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green),
                                            ),
                                            Text(
                                              'Deaths: ' +
                                                  countryData[index]['deaths']
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[900]),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0.0, 2.0),
                                              blurRadius: 6.0)
                                        ]),
                                    child: Stack(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image.network(
                                            countryData[index]['countryInfo']
                                                ['flag'],
                                            height: 90,
                                            width: 90,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  'Symptoms of COVID-19',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _buildSymptomsItems(
                      'assets/symptoms/high_fever.png', 'Fever'),
                  _buildSymptomsItems('assets/symptoms/cough.png', 'Cough'),
                  _buildSymptomsItems(
                      'assets/symptoms/headache.png', 'Headache'),
                  _buildSymptomsItems(
                      'assets/symptoms/sore_throat.png', 'Sore Throat'),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  'Precaution To Take',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  _buildSymptomsItems(
                      'assets/prevention/avoid_contact.png', 'No Handshake'),
                  _buildSymptomsItems(
                      'assets/prevention/cover_cough.png', 'Cover Cough'),
                  _buildSymptomsItems(
                      'assets/prevention/face_mask.png', 'Face Mask'),
                  _buildSymptomsItems(
                      'assets/prevention/wash_hands.png', 'Wash Hands'),
                ],
              ),
            ),
            SizedBox(height: 30),
            InfoPanel(),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              'STAY HOME AND STAY SAFE',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            SizedBox(height: 30),
          ],
        )),
      ),
    );
  }

  Widget _buildSymptomsItems(String path, String text) {
    return Column(
      children: <Widget>[
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              gradient: LinearGradient(
                colors: [
                  Colors.green.withOpacity(.1),
                  Colors.white,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              border: Border.all(color: Colors.white),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1, 1),
                  spreadRadius: 1,
                  blurRadius: 3,
                ),
              ]),
          padding: EdgeInsets.only(top: 15),
          child: Image.asset(path),
          margin: EdgeInsets.only(right: 20),
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          text,
          style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black87
                  : Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

}
