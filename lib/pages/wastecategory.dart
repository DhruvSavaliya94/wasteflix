import 'package:flutter/material.dart';
import 'package:wasteflix/handler/Models.dart';
import 'package:wasteflix/utils/iconcontent.dart';
import 'package:wasteflix/utils/imagecontent.dart';
import '../utils/catcard.dart';
class WasteCategory extends StatefulWidget {
  @override
  _WasteCategoryState createState() => _WasteCategoryState();
}

class _WasteCategoryState extends State<WasteCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Waste Category"),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: CategoryCard(
                      colour: secondaryColor,
                      cardChild: ImageContent(
                        assetImage: AssetImage("assets/decluster/Household.png"),
                        label: "Household",
                      ),
                    ),
                  ),
                  Expanded(
                    child: CategoryCard(
                      colour: secondaryColor,
                      cardChild:  ImageContent(
                        assetImage: AssetImage("assets/industrial.png"),
                        label: "Industrial",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: CategoryCard(
                      colour: secondaryColor,
                      cardChild: ImageContent(
                        assetImage: AssetImage("assets/plastic-bottle.png"),
                        label: "Plastic",
                      ),
                    ),
                  ),
                  Expanded(
                    child: CategoryCard(
                      colour: secondaryColor,
                      cardChild:  ImageContent(
                        assetImage: AssetImage("assets/glass.png"),
                        label: "Glass",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: CategoryCard(
                      colour: secondaryColor,
                      cardChild: ImageContent(
                        assetImage: AssetImage("assets/stacked-print-products.png"),
                        label: "Paper",
                      ),
                    ),
                  ),
                  Expanded(
                    child: CategoryCard(
                      colour: secondaryColor,
                      cardChild:  ImageContent(
                        assetImage: AssetImage("assets/decluster/Furniture.png"),
                        label: "Wood",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
