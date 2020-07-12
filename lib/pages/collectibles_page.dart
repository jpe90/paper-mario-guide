import 'package:flutter/material.dart';

import '../models/collectible.dart';
import '../views/collectibles_view.dart';

class CollectiblesPage extends StatelessWidget {
  // TODO: Add a variable for Category (104)

  @override
  Widget build(BuildContext context) {
    // TODO: Return an AsymmetricView (104)
    // TODO: Pass Category variable to AsymmetricView (104)
    return CollectiblesView(collectibles: <Collectible>[
      Collectible(id: 1, level: Level.one, category: Category.toad),
      Collectible(id: 2, level: Level.one, category: Category.toad)
    ]);
  }
}
