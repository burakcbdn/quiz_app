import 'package:flutter/material.dart';
import 'package:quiz_app/models/reward.dart';
import 'package:quiz_app/widgets/reward_widget.dart';


class MarketPage extends StatefulWidget {

  final int points;

  const MarketPage({Key key, this.points}) : super(key: key);

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff0052D4),
              Color(0xFF4364F7),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 70,),
            Text("Toplam puanın ${widget.points}", style: TextStyle(color: Colors.white, fontSize: 35),),
            SizedBox(height: 10,),
            Text("İşte kazandığın hediyeler", style: TextStyle(color: Colors.white, fontSize: 25),),
            SizedBox(height: 10,),
            Container(
              height: 0.5,
              width: double.infinity,
              color: Colors.white,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: rewards.where((reward) => reward.minPoint <= widget.points).map((reward) {
                  return Center(
                    child: RewardItem(
                      reward: reward,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
