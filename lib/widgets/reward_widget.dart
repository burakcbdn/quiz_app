import 'package:flutter/material.dart';
import 'package:quiz_app/models/reward.dart';


class RewardItem extends StatelessWidget {
  final Reward reward;

  const RewardItem({Key key, this.reward}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Material(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          height: 140,
          width: MediaQuery.of(context).size.width - 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff0052D4),
                Color(0xFF4364F7),
              ],
            )
          ),
          child: Row(
            children: [
              SizedBox(width: 10,),
              Container(
                height: 120,
                width: 120,

                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                    ,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                  reward.asset,
                  fit: BoxFit.cover,
                )),
              ),
              SizedBox(
                width: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 195,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(reward.title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),

                    Text(
                      reward.description,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      softWrap: true,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
