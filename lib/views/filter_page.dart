import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../models/collectible.dart';

class FilterPage extends StatelessWidget {
  final Level selectedLevel;
  final Category selectedCategory;
  final CompletionStatus selectedCompletionStatus;

  const FilterPage(
      {@required this.selectedLevel,
      @required this.selectedCategory,
      @required this.selectedCompletionStatus})
      : assert(selectedLevel != null),
        assert(selectedCompletionStatus != null),
        assert(selectedCategory != null);
}
