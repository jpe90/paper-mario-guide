import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../models/collectible.dart';

import 'package:logger/logger.dart' as l;

var logger = l.Logger(printer: l.PrettyPrinter());

class FilterPage extends StatelessWidget {
  final Level selectedLevel;
  final Category selectedCategory;
  final CompletionStatus selectedCompletionStatus;
  final List<Level> _levels = Level.values;
  final List<Category> _categories = Category.values;
  final List<CompletionStatus> _completionStatuses = CompletionStatus.values;

  const FilterPage(
      {@required this.selectedLevel,
      @required this.selectedCategory,
      @required this.selectedCompletionStatus})
      : assert(selectedLevel != null),
        assert(selectedCompletionStatus != null),
        assert(selectedCategory != null);

  Widget _buildRow(BuildContext context) {
    return Row(children: <Widget>[_buildCategoryFilter(context)]);
  }

  Widget _buildCategoryFilter(BuildContext context) {
    return ListView(
        children: _categories
            //.map((category) => _buildCategory(category, context))
            //.toList());
            .map((category) => Text(category.toString()))
            .toList());
  }

  Widget _buildCategory(Category category, BuildContext context) {
    logger.d('Category sent to buildCategory: $category');
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(Collectible.getDisplayNameForCategory(category)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
          padding: EdgeInsets.only(top: 40),
          //child: _buildRow(context),
          child: _buildCategoryFilter(context),
          color: Colors.blue),
    );
  }
}
