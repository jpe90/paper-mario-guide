import 'package:flutter/material.dart';
import 'package:paper_mario_guide/views/collectibles_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/backdrop.dart';
import 'models/collectible.dart';
import 'views/collectibles_view.dart';
import 'models/collectibles_repository.dart';
import 'views/error_page.dart';
import 'package:logger/logger.dart' as l;
import 'views/filter_page.dart';

var logger = l.Logger(printer: l.PrettyPrinter());

void main() {
  runApp(MyApp(key: UniqueKey()));
}

enum LoadStatus { loading, completed, error }

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  createState() => _MyAppState();
}

class CollectiblesCollection {}

class _MyAppState extends State<MyApp> {
  LoadStatus status = LoadStatus.loading;
  CollectiblesRepository repository;
  List<Collectible> collectibles = [];
  List<Collectible> filteredCollectibles = [];
  Category _currentCategory = Category.all;
  Level _currentLevel = Level.all;
  SharedPreferences prefs;
  CompletionStatus _currentCompletionStatus = CompletionStatus.all;

  @override
  void initState() {
    super.initState();
    repository = CollectiblesRepository();
    loadCompletionFromSharedPrefs();
    repository.loadCollectiblesFromJson().then((loadedCollectibles) {
      setState(() {
        status = LoadStatus.completed;
        collectibles = loadedCollectibles;
        collectibles.forEach((element) {
          bool toSet = prefs.getBool(element.id.toString()) ?? false;
          element.completionStatus = toSet
              ? CompletionStatus.completed
              : CompletionStatus.notCompleted;
        });
        logger.d(collectibles.length);
      });
    }).catchError((err) {
      logger.e(err.toString());
      setState(() => status = LoadStatus.error);
    });
  }

  loadCompletionFromSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  List<Collectible> getFilteredCollectibles(
      Category category, Level level, CompletionStatus completionStatus) {
    List<Collectible> fuckinPieceOFShit = collectibles.where((element) {
      return (category == Category.all || category == element.category) &&
          (level == Level.all || level == element.level) &&
          (completionStatus == CompletionStatus.all ||
              completionStatus == element.completionStatus);
    }).toList();
    return fuckinPieceOFShit;
  }

  void setCompletionStatus(int id) {
    var toSet = collectibles.singleWhere((element) => element.id == id);
    logger.d('toSet at start: $toSet');
    if (toSet != null) {
      toSet.completionStatus =
          toSet.completionStatus == CompletionStatus.completed
              ? CompletionStatus.notCompleted
              : CompletionStatus.completed;
    }
    logger.d('toSet at end: $toSet');
  }

  void onCheckboxChanged(Collectible collectible, CompletionStatus status) {
    setState(() {
      collectible.completionStatus = status;
      bool toSet = status == CompletionStatus.completed ? true : false;
      prefs.setBool(collectible.id.toString(), toSet);
    });
  }

  Widget getFrontLayerForLoadStatus(LoadStatus status) {
    if (status == LoadStatus.loading) {
      return Text('loading');
    } else if (status == LoadStatus.completed) {
      //logger.d('well its trying to draw something at least');
      return CollectiblesView(
          onCheckboxChanged: onCheckboxChanged,
          collectibles: getFilteredCollectibles(
              _currentCategory, _currentLevel, _currentCompletionStatus));
    } else
      return ErrorPage(errorInfo: "shrug");
  }

  // void onCategoryTap(Category category) =>
  //     setState(() => _currentCategory = category);
  void onCategoryTap(Category category) {
    setState(() => _currentCategory = category);
    var filteredCollectibles = getFilteredCollectibles(
        _currentCategory, _currentLevel, _currentCompletionStatus);
    logger.d('collectibles size: ${collectibles.length}');
    logger.d('filtered size: ${filteredCollectibles.length}');
  }

  void onLevelTap(Level level) => setState(() => _currentLevel = level);

  void onCompletionStatusTap(CompletionStatus status) =>
      setState(() => _currentCompletionStatus = status);

  @override
  Widget build(BuildContext context) {
    Widget frontLayer = getFrontLayerForLoadStatus(status);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'mario'),
      home: Backdrop(
        frontLayer: frontLayer,
        backLayer: FilterPage(
            onCategoryTap: onCategoryTap,
            onLevelTap: onLevelTap,
            onCompletionStatusTap: onCompletionStatusTap,
            initialCategory: _currentCategory,
            initialLevel: _currentLevel,
            initialCompletionStatus: _currentCompletionStatus),
      ),
    );
  }
}
