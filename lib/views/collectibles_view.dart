import 'package:flutter/material.dart';

import '../widgets/card_bottom.dart';
import '../models/collectible.dart';

import 'package:logger/logger.dart' as l;

class CollectiblesView extends StatelessWidget {
  final List<Collectible> collectibles;
  final void Function(Collectible collectible, CompletionStatus status)
      onCheckboxChanged;

  const CollectiblesView(
      {@required this.collectibles, @required this.onCheckboxChanged})
      : assert(onCheckboxChanged != null);

  GridView _buildGridCards(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      padding: EdgeInsets.all(16.0),
      childAspectRatio: 2.0 / 1.8,
      children:
          collectibles.map((collectible) => _gridElement(collectible)).toList(),
    );
  }

  Widget _gridElement(Collectible collectible) {
    return Card(
      elevation: 8.0,
      child: Column(
        children: [
          Image(
              image: AssetImage(collectible.fullAssetName),
              fit: BoxFit.fitWidth),
          CardBottom(
            id: collectible.id,
            categoryName:
                Collectible.getDisplayNameForCategory(collectible.category),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            value: Collectible.getBoolFromCompletionStatus(
                collectible.completionStatus),
            onChanged: (complete) {
              onCheckboxChanged(
                  collectible, Collectible.getStatusFromBool(complete));
            },
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //return GridView.builder();
    //logger.d('in collevtibles view, size = ${collectibles.length}');
    return _buildGridCards(context);
  }
}
