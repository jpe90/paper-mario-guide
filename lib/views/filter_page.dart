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
  Color backgroundColor = Colors.grey[200];

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
        color: backgroundColor);
  }

  Widget _buildRowOfFilters(BuildContext context) {
    List<Widget> selectableCategories = _categories
        .map((category) => _buildSelectableCategory(category, context))
        .toList();
    List<Widget> selectableLevels =
        _levels.map((level) => _buildSelectableLevel(level, context)).toList();
    List<Widget> selectableCompletionStatuses = _completionStatuses
        .map((status) => _buildSelectableCompletionStatus(status, context))
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
    List<Widget> children = [];
    children.add(SizedBox(
      height: 20,
    ));
    children.add(Container(
      decoration:
          const BoxDecoration(border: Border(bottom: BorderSide(width: 2))),
      child: Text(title,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
    ));
    children.add(SizedBox(
      height: 40,
    ));
    children += selectionList;
    return Flexible(
      fit: FlexFit.tight,
      child: ListView(children: children),
    );
  }

  Widget _buildSelectableCategory(Category category, BuildContext context) {
    bool selected = category == selectedCategory;
    return GestureDetector(
      onTap: () {
        widget.onCategoryTap(category);
        setState(() {
          onCategoryTap(category);
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: AnimatedContainer(
            curve: Curves.easeOut,
            duration: Duration(milliseconds: 150),
            margin: EdgeInsets.symmetric(horizontal: selected ? 10 : 15),
            decoration: BoxDecoration(
                color: selected ? Colors.cyan : backgroundColor,
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              Collectible.getDisplayNameForCategory(category),
              textAlign: TextAlign.center,
            )),
      ),
    );
  }

  Widget _buildSelectableLevel(Level level, BuildContext context) {
    bool selected = level == selectedLevel;
    return GestureDetector(
      onTap: () {
        widget.onLevelTap(level);
        setState(() {
          onLevelTap(level);
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: AnimatedContainer(
            curve: Curves.easeOut,
            duration: Duration(milliseconds: 150),
            margin: EdgeInsets.symmetric(horizontal: selected ? 10 : 15),
            decoration: BoxDecoration(
                color: selected ? Colors.cyan : backgroundColor,
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              Collectible.getDisplayNameForLevel(level),
              textAlign: TextAlign.center,
            )),
      ),
    );
  }

  Widget _buildSelectableCompletionStatus(
      CompletionStatus completionStatus, BuildContext context) {
    bool selected = completionStatus == selectedCompletionStatus;
    return GestureDetector(
      onTap: () {
        widget.onCompletionStatusTap(completionStatus);
        setState(() {
          onCompletionStatusTap(completionStatus);
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: AnimatedContainer(
            curve: Curves.easeOut,
            duration: Duration(milliseconds: 150),
            margin: EdgeInsets.symmetric(horizontal: selected ? 10 : 15),
            decoration: BoxDecoration(
                color: selected ? Colors.cyan : backgroundColor,
                border: Border.all(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              Collectible.getDisplayNameForCompletionStatus(completionStatus),
              textAlign: TextAlign.center,
            )),
      ),
    );
  }
  // Widget _buildSelectableLevel(Level level, BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       widget.onLevelTap(level);
  //       setState(() {
  //         onLevelTap(level);
  //       });
  //     },
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(vertical: 16),
  //       child: level == selectedLevel
  //           ? RaisedButton(
  //               onPressed: () => {},
  //               color: Colors.cyan,
  //               child: Text(
  //                 Collectible.getDisplayNameForLevel(level),
  //                 textAlign: TextAlign.center,
  //               ))
  //           : Text(
  //               Collectible.getDisplayNameForLevel(level),
  //               textAlign: TextAlign.center,
  //             ),
  //     ),
  //   );
  // }

  // Widget _buildSelectableCompletionStatus(
  //     CompletionStatus status, BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       widget.onCompletionStatusTap(status);
  //       setState(() {
  //         onCompletionStatusTap(status);
  //       });
  //     },
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(vertical: 16),
  //       child: status == selectedCompletionStatus
  //           ? RaisedButton(
  //               onPressed: () => {},
  //               color: Colors.cyan,
  //               child: Text(
  //                 Collectible.getDisplayNameForCompletionStatus(status),
  //                 textAlign: TextAlign.center,
  //               ))
  //           : Text(
  //               Collectible.getDisplayNameForCompletionStatus(status),
  //               textAlign: TextAlign.center,
  //             ),
  //     ),
  //   );
  // }
}
