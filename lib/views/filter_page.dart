import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../models/collectible.dart';

import 'package:logger/logger.dart' as l;

var logger = l.Logger(printer: l.PrettyPrinter());

typedef String NameGetter<T>(T t);

class FilterPage extends StatefulWidget {
  final Category initialCategory;
  final Level initialLevel;
  final CompletionStatus initialCompletionStatus;
  final ValueChanged<Category> onCategoryTap;
  final ValueChanged<Level> onLevelTap;
  final ValueChanged<CompletionStatus> onCompletionStatusTap;

  const FilterPage({
    @required this.initialCategory,
    @required this.initialLevel,
    @required this.initialCompletionStatus,
    @required this.onCategoryTap,
    @required this.onLevelTap,
    @required this.onCompletionStatusTap,
  })  : assert(initialCategory != null),
        assert(initialLevel != null),
        assert(initialCompletionStatus != null),
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
  Level selectedLevel;
  CompletionStatus selectedCompletionStatus;

  void onCategoryTap(Category category) => selectedCategory = category;
  void onLevelTap(Level level) => selectedLevel = level;
  void onCompletionStatusTap(CompletionStatus status) =>
      selectedCompletionStatus = status;

  @override
  initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
    selectedLevel = widget.initialLevel;
    selectedCompletionStatus = widget.initialCompletionStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        child: _buildRowOfFilters(context),
        color: Theme.of(context).splashColor);
  }

  Widget _buildRowOfFilters(BuildContext context) {
    List<Widget> selectableCategories = _categories
        .map((category) => _buildSelectableItem(
                context, Collectible.getDisplayNameForCategory(category), () {
              widget.onCategoryTap(category);
              setState(() {
                onCategoryTap(category);
              });
            }, category == selectedCategory))
        .toList();
    List<Widget> selectableLevels = _levels
        .map((level) => _buildSelectableItem(
                context, Collectible.getDisplayNameForLevel(level), () {
              widget.onLevelTap(level);
              setState(() {
                onLevelTap(level);
              });
            }, level == selectedLevel))
        .toList();
    List<Widget> selectableCompletionStatuses = _completionStatuses
        .map((completionStatus) => _buildSelectableItem(context,
                Collectible.getDisplayNameForCompletionStatus(completionStatus),
                () {
              widget.onCompletionStatusTap(completionStatus);
              setState(() {
                onCompletionStatusTap(completionStatus);
              });
            }, completionStatus == selectedCompletionStatus))
        .toList();
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildFilterColumn(context, selectableCategories, 'COLLECTIBLES'),
          const VerticalDivider(
            width: 2,
            thickness: 2,
          ),
          _buildFilterColumn(context, selectableLevels, 'AREAS'),
          const VerticalDivider(
            width: 5,
            thickness: 2,
          ),
          _buildFilterColumn(
              context, selectableCompletionStatuses, 'COMPLETION'),
        ]);
  }

  Widget _buildFilterColumn(
      BuildContext context, List<Widget> selectionList, String title) {
    return Flexible(
      fit: FlexFit.tight,
      //child: ListView(children: children),
      child: CustomScrollView(slivers: [
        SliverAppBar(
          centerTitle: true,
          title: Text(title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              )),
          pinned: true,
          backgroundColor: Theme.of(context).splashColor,
        ),
        SliverList(delegate: SliverChildListDelegate(selectionList)),
      ]),
    );
  }

  Widget _buildSelectableItem(BuildContext context, String titleText,
      VoidCallback onTap, bool selected) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: AnimatedContainer(
            curve: Curves.easeOut,
            duration: Duration(milliseconds: 150),
            margin: EdgeInsets.symmetric(horizontal: selected ? 10 : 15),
            decoration: BoxDecoration(
                color: selected
                    ? Theme.of(context).accentColor
                    : Theme.of(context).splashColor,
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              titleText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            )),
      ),
    );
  }
}
