import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../models/collectible.dart';

import 'package:logger/logger.dart' as l;

var logger = l.Logger(printer: l.PrettyPrinter());

typedef String NameGetter<T>(T t);

class FilterPage extends StatefulWidget {
  final Category initialCategory;
  final Level selectedLevel;
  final CompletionStatus selectedCompletionStatus;
  final ValueChanged<Category> onCategoryTap;
  final ValueChanged<Level> onLevelTap;
  final ValueChanged<CompletionStatus> onCompletionStatusTap;

  FilterPage({
    @required this.initialCategory,
    @required this.selectedLevel,
    @required this.selectedCompletionStatus,
    @required this.onCategoryTap,
    @required this.onLevelTap,
    @required this.onCompletionStatusTap,
  })  : assert(initialCategory != null),
        assert(selectedLevel != null),
        assert(selectedCompletionStatus != null),
        assert(onCategoryTap != null),
        assert(onLevelTap != null),
        assert(onCompletionStatusTap != null);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final List<Category> _categories = Category.values;

  final List<Level> _levels = Level.values;

  final List<CompletionStatus> _completionStatuses = CompletionStatus.values;
  Category selectedCategory;
  @override
  initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
  }

  Widget _buildGenericFilterColumn<T>(List<T> ts, BuildContext context,
      NameGetter<T> getDisplayName, ValueChanged vc) {
    List<Widget> children = [];
    children.add(Text('Title'));
    children.add(SizedBox(
      height: 40,
    ));
    children += ts
        .map((t) => _buildGeneric<T>(t, getDisplayName, context, vc))
        .toList();
    return Flexible(
      fit: FlexFit.tight,
      child: Column(mainAxisSize: MainAxisSize.min, children: children),
    );
  }

  Widget _buildCategoryFilterColumn(
    BuildContext context,
  ) {
    List<Widget> children = [];
    children.add(Text('Title'));
    children.add(SizedBox(
      height: 40,
    ));
    children += _categories
        .map((category) => _buildSelectableCategory(category, context))
        .toList();
    return Flexible(
      fit: FlexFit.tight,
      child: Column(mainAxisSize: MainAxisSize.min, children: children),
    );
  }

  void muhCategoryTap(Category category) {
    selectedCategory = category;
    print('cmon dude');
  }

  Widget _buildGeneric<T>(T t, NameGetter<T> getDisplayName,
      BuildContext context, ValueChanged vc) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        getDisplayName(t),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSelectableCategory<T>(Category category, BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onCategoryTap(category);
        muhCategoryTap(category);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: category == selectedCategory
            ? Text('this is selected!!', textAlign: TextAlign.center)
            : Text(
                Collectible.getDisplayNameForCategory(category),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }

  Widget _buildRowOfFilters(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildCategoryFilterColumn(context),
          // VerticalDivider(
          // width: 5,
          // thickness: 5,
          // ),
          // _buildGenericFilterColumn<Level>(_levels, context,
          // Collectible.getDisplayNameForLevel, onCategoryTap),
          // VerticalDivider(
          // width: 5,
          // thickness: 5,
          // ),
          // _buildGenericFilterColumn<CompletionStatus>(
          // _completionStatuses,
          // context,
          // Collectible.getDisplayNameForCompletionStatus,
          // onCategoryTap)
        ]);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      alignment: Alignment.topCenter,
      child: _buildRowOfFilters(context),
    );
  }
}
