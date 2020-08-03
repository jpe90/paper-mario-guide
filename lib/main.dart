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
import 'services/completion_service.dart';

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

// maintains state for whether completion statuses & json were successfully loaded (LoadStatus), which
// category, level, and completion status are currently filtered, and the shared prefs containing completion
// bools

class _MyAppState extends State<MyApp> {
  LoadStatus status;
  CollectiblesRepository repository;
  List<Collectible> collectibles;
  List<Collectible> filteredCollectibles;
  Category _currentCategory;
  Level _currentLevel;
  CompletionStatus _currentCompletionStatus;
  CollectiblesCompletionService ccs;
  SharedPreferences prefs;
  String errorMessage;

  @override
  void initState() {
    super.initState();
    _currentCategory = Category.all;
    _currentLevel = Level.all;
    _currentCompletionStatus = CompletionStatus.all;
    status = LoadStatus.loading;
    errorMessage = "";
    ccs = CollectiblesCompletionService();
    repository = CollectiblesRepository();
    _loadApplicationData();
  }

  Future<void> _loadApplicationData() async {
    try {
      await ccs.loadCompletionFromSharedPrefs();
      collectibles = await repository.loadCollectiblesFromJson();
      ccs.createMap(collectibles);
      // if you want to test the infinite loading screen just remove this setstate
      setState(() => status = LoadStatus.completed);
    } catch (err) {
      logger.e(err.toString());
      errorMessage = err.toString();
      setState(() => status = LoadStatus.error);
    }
  }

  // callbacks

  List<Collectible> getFilteredCollectibles(
      Category category, Level level, CompletionStatus completionStatus) {
    return collectibles.where((element) {
      return (category == Category.all || category == element.category) &&
          (level == Level.all || level == element.level) &&
          (completionStatus == CompletionStatus.all ||
              ccs.getCompletionStatusForId(element.id) ==
                  Collectible.getBoolFromCompletionStatus(completionStatus));
    }).toList();
  }

  void onCheckboxChanged(int id, bool status) {
    setState(() {
      ccs.updateCompletionStatusForId(id, status);
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
          getCompletionStatus: ccs.getCompletionStatusForId,
          collectibles: getFilteredCollectibles(
              _currentCategory, _currentLevel, _currentCompletionStatus));
    } else
      return ErrorPage(
          errorInfo: errorMessage ?? "No error message specified.");
  }

  @override
  Widget build(BuildContext context) {
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
        frontLayer: getFrontLayerForLoadStatus(status),
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
