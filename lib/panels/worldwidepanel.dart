import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class WorldwidePanel extends StatelessWidget {
  final Map worldData;

  const WorldwidePanel({Key key, this.worldData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 2),
        children: <Widget>[
          FlipCard(
            direction: FlipDirection.VERTICAL,
            front: Card(
              color: Colors.red[100],
              child: Center(
                child: Text('CONFIRMED', style: TextStyle(color: Colors.red[900], fontWeight: FontWeight.bold, fontSize: 16,),),
              ),
            ), 
            back: StatusPanel(
              panelColor: Colors.red[100],
              textColor: Colors.red[900],
              title: 'CONFIRMED',
              count: worldData['cases'].toString(),
              )
              ),
          FlipCard(
            front: Card(
              color: Colors.blue[100],
              child: Center(
                child: Text('ACTIVE', style: TextStyle(color: Colors.blue[900], fontWeight: FontWeight.bold, fontSize: 16,),),
              ),
            ), 
            back: StatusPanel(
            panelColor: Colors.blue[100],
            textColor: Colors.blue[900],
            title: 'ACTIVE',
            count: worldData['active'].toString(),
          ),
           ),
          FlipCard(
            front: Card(
              color: Colors.green[100],
              child: Center(
                child: Text('RECOVERED', style: TextStyle(color: Colors.green[900], fontWeight: FontWeight.bold, fontSize: 16,),),
              ),
            ), 
            back: StatusPanel(
            panelColor: Colors.green[100],
            textColor: Colors.green[900],
            title: 'RECOVERED',
            count: worldData['recovered'].toString(),
          ),
            ),
          FlipCard(
            direction: FlipDirection.VERTICAL,
            front: Card(
              color: Colors.grey[100],
              child: Center(
                child: Text('DEATHS', style: TextStyle(color: Colors.grey[900], fontWeight: FontWeight.bold, fontSize: 16,),),
              ),
            ), 
            back: StatusPanel(
            panelColor: Colors.grey[300],
            textColor: Colors.grey[900],
            title: 'DEATHS',
            count: worldData['deaths'].toString(),
          ),
            ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanel(
      {Key key, this.panelColor, this.textColor, this.title, this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(10),
      height: 80,
      width: width / 2,
      color: panelColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
          ),
          Text(
            count,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
          )
        ],
      ),
    );
  }
}
