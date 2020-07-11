import 'package:flutter/material.dart';

import '../widgets/card_bottom.dart';
import '../models/collectibles_repository.dart';
import '../models/collectible.dart';

class CollectiblesView extends StatelessWidget {
  final List<Collectible> collectibles;

  CollectiblesView({this.collectibles});

  //List<
  Card _gridElement(Collectible collectible) {
    return Card(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 18 / 11,
            child: Image.asset(
              collectible.assetName,
              package: collectible.thumbnailAssetPackage,
              fit: BoxFit.fitWidth,
            ),
          ),
          CardBottom(
            id: collectible.id,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            value: false,
            onChanged: (__) {},
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //return GridView.builder();
    return _gridElement(collectibles[0]);
  }
}
