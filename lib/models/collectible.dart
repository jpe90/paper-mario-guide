import 'package:flutter/foundation.dart';

enum Level { one, two, three, four, five, six, seven }

enum Category { Toad }

class Collectible {
  Collectible({
    @required this.id,
    @required this.level,
    @required this.order,
    @required this.category,
    @required this.isCollected,
  })  : assert(id != null),
        assert(level != null),
        assert(order != null),
        assert(category != null),
        assert(isCollected != null);

  final int id;
  final Level level;
  final int order;
  final Category category;
  bool isCollected;

  String get thumbnailPath => 'assets/thumb/$id.jpg';
  String get fullSizePath => 'assets/full/$id.jpg';

  String toString() =>
      'id: $id, level: $level, order: $order, category: $category, isCollected: $isCollected';
}
