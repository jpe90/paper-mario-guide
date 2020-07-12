import 'package:flutter/material.dart';

import '../widgets/card_bottom.dart';
import '../models/collectibles_repository.dart';
import '../models/collectible.dart';

class CollectiblesView extends StatelessWidget {
  final List<Collectible> collectibles;

  CollectiblesView({this.collectibles});

  GridView _buildGridCards(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16.0),
      childAspectRatio: 8.0 / 9.0,
      children:
          collectibles.map((collectible) => _gridElement(collectible)).toList(),
    );
  }

  Card _gridElement(Collectible collectible) {
    return Card(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 18 / 11,
            //child: Image.asset(
            //  collectible.thumbnailAssetName,
            //  fit: BoxFit.fitWidth,
            //),
            child: Image(
              image: AssetImage(collectible.thumbnailAssetName),
              //image: AssetImage('assets/warb.png'),
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
    return _buildGridCards(context);
  }
}
