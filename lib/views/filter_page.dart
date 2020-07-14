import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../models/collectible.dart';

import 'package:logger/logger.dart' as l;

var logger = l.Logger(printer: l.PrettyPrinter());

// TODO: create a row with three buttons

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
            .map((category) => _buildCategory(category, context))
            .toList());
    //.map((category) => Text(category.toString()))
    //.toList());
  }

  Widget _buildCategory(Category category, BuildContext context) {
    logger.d('Category sent to buildCategory: $category');
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(Collectible.getDisplayNameForCategory(category)),
    );
  }

  Widget _createFilterButtonRow(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          RaisedButton(onPressed: () {}, child: Text('Test')),
          RaisedButton(onPressed: () {}, child: Text('Test')),
          RaisedButton(onPressed: () {}, child: Text('Test'))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
          padding: EdgeInsets.fromLTRB(15, 40, 15, 0),
          //child: _buildRow(context),
          child: _createFilterButtonRow(context),
          color: Colors.blue),
    );
  }
}
