
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              launch('https://www.who.int/csr/disease/coronavirus_infections/faq_dec12/en/');
            },
              child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('FAQs', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                  Icon(Icons.arrow_forward, color: Colors.white,)
                ],
              ), 
            ),
          ),
           GestureDetector(
             onTap: (){
               launch('https://covid19responsefund.org/');
             },
              child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('DONATE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                  Icon(Icons.arrow_forward, color: Colors.white,)
                ],
              ), 
          ),
           ),
           GestureDetector(
              onTap: (){
                launch('https://www.who.int/emergencies/diseases/novel-coronavirus-2019/advice-for-public/myth-busters');
              },
              child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('MYTH BUSTERS', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
                  Icon(Icons.arrow_forward, color: Colors.white,)
                ],
              ), 
          ),
           )
        ],
      ),
    );
  }
}