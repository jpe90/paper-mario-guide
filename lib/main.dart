import 'package:flutter/material.dart';
import 'package:paper_mario_guide/views/collectibles_view.dart';
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

class _MyAppState extends State<MyApp> {
  LoadStatus status = LoadStatus.loading;
  CollectiblesRepository repository;
  Category _currentCategory = Category.all;
  Level _currentLevel = Level.all;
  CompletionStatus _currentCompletionStatus = CompletionStatus.all;

  @override
  void initState() {
    super.initState();
    repository = CollectiblesRepository();
    repository.loadCollectiblesFromJson().then((collectibles) {
      CollectiblesRepository.collectibles = collectibles;
      setState(() => status = LoadStatus.completed);
    }).catchError((err) {
      logger.e(err.toString());
      setState(() => status = LoadStatus.error);
    });
  }

  Widget getFrontLayerForLoadStatus(LoadStatus status) {
    if (status == LoadStatus.loading) {
      return Text('loading');
    } else if (status == LoadStatus.completed) {
      return CollectiblesView(
          collectibles: repository.getFilteredCollectibles(
              _currentCategory, _currentLevel, _currentCompletionStatus));
    } else
      return ErrorPage(errorInfo: "shrug");
  }

  void onCategoryTap(Category category) =>
      setState(() => _currentCategory = category);

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
