import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:origami_king_guide/views/collectibles_view.dart';
import 'package:origami_king_guide/services/admob_service.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize(AdmobService.getAdMobAppId());
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
  LoadStatus status;
  CollectiblesRepository repository;
  List<Collectible> collectibles;
  List<Collectible> filteredCollectibles;
  Category _currentCategory;
  Level _currentLevel;
  CompletionStatus _currentCompletionStatus;
  SharedPreferences prefs;
  String errorMessage;

  @override
  void initState() {
    super.initState();
    collectibles = [];
    filteredCollectibles = [];
    _currentCategory = Category.all;
    _currentLevel = Level.all;
    _currentCompletionStatus = CompletionStatus.all;
    status = LoadStatus.loading;
    errorMessage = "";
    _loadCollectiblesFromPrefs();
    repository = CollectiblesRepository();
  }

  Future<void> _loadCollectiblesFromPrefs() async {
    try {
      await loadCompletionFromSharedPrefs();
      collectibles = await repository.loadCollectiblesFromJson();
      setState(() {
        collectibles.forEach((element) {
          bool toSet = prefs.getBool(element.id.toString()) ?? false;
          element.completionStatus = toSet
              ? CompletionStatus.completed
              : CompletionStatus.notCompleted;
        });
        status = LoadStatus.completed;
      });
    } catch (err) {
      logger.e(err.toString());
      errorMessage = err.toString();
      setState(() => status = LoadStatus.error);
    }
  }

  // this needs to be in a separate method because initState can't be marked async
  loadCompletionFromSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs == null) {
      status = LoadStatus.error;
      errorMessage = "Shared prefs not found.";
    }
  }

  // callbacks

  List<Collectible> getFilteredCollectibles(
      Category category, Level level, CompletionStatus completionStatus) {
    return collectibles.where((element) {
      return (category == Category.all || category == element.category) &&
          (level == Level.all || level == element.level) &&
          (completionStatus == CompletionStatus.all ||
              prefs.getBool(element.id.toString()) ==
                  Collectible.getBoolFromCompletionStatus(completionStatus));
    }).toList();
  }

  void changeCompletionStatus(int id) {
    var toSet = collectibles.singleWhere((element) => element.id == id);
    if (toSet != null) {
      toSet.completionStatus =
          toSet.completionStatus == CompletionStatus.completed
              ? CompletionStatus.notCompleted
              : CompletionStatus.completed;
    }
  }

  void onCheckboxChanged(Collectible collectible, CompletionStatus status) {
    setState(() {
      collectible.completionStatus = status;
      bool toSet = status == CompletionStatus.completed ? true : false;
      prefs.setBool(collectible.id.toString(), toSet);
    });
  }

  void onCategoryTap(Category category) =>
      setState(() => _currentCategory = category);
  void onLevelTap(Level level) => setState(() => _currentLevel = level);
  void onCompletionStatusTap(CompletionStatus status) =>
      setState(() => _currentCompletionStatus = status);

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
      return ErrorPage(
          errorInfo: errorMessage ?? "No error message specified.");
  }

  @override
  Widget build(BuildContext context) {
    Widget frontLayer = getFrontLayerForLoadStatus(status);
    return MaterialApp(
      title: 'Paper Mario: The Oragami King Collectible Guide',
      theme: ThemeData(
          // primarySwatch: Colors.red,
          primaryColor: Colors.red,
          accentColor: Colors.cyanAccent[400],
          dividerColor: Colors.black,
          canvasColor: Colors.white,
          splashColor: Colors.white,
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
