import 'package:flutter/material.dart';

class RewardsCard extends StatelessWidget {
  const RewardsCard({this.titletext, this.offertext, this.onPress, this.cardChild});

  final String titletext;
  final String offertext;
  final Function onPress;
  final Widget cardChild;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: Row(
          children: [
            cardChild,
            Text("${this.titletext}"),
            Text("${this.offertext}")
          ],
        ),
      ),
    );
  }
}
