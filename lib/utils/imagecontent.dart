import 'package:flutter/material.dart';

import 'constant.dart';

class ImageContent extends StatelessWidget {
  ImageContent({this.assetImage, this.label});

  final AssetImage assetImage;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
          image: assetImage,
          height: 150,
          width: 150,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          label,
          style: kLabelTextStyle,
        )
      ],
    );
  }
}
