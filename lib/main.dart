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
  runApp(MyApp());
}

enum LoadStatus { loading, completed, error }

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LoadStatus status = LoadStatus.loading;
  CollectiblesRepository repository;
  Category _currentCategory = Category.all;

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
          collectibles: CollectiblesRepository.collectibles);
    } else
      return ErrorPage(errorInfo: "shrug");
  }

  void onCategoryTap(Category category) {
    _currentCategory = category;
    logger.d('tapped dat');
  }

  void onLevelTap(Level level) {}
  void onCompletionStatusTap(CompletionStatus status) {}

  // This widget is the root of your application.p
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'mario'),
      home: Backdrop(
        frontLayer: getFrontLayerForLoadStatus(status),
        //status == LoadStatus.loading ? Text('loading') : CollectiblesPage(),
        backLayer: FilterPage(
            onCategoryTap: onCategoryTap,
            onLevelTap: onLevelTap,
            onCompletionStatusTap: onCompletionStatusTap,
            selectedCategory: _currentCategory,
            selectedLevel: Level.all,
            selectedCompletionStatus: CompletionStatus.all),
      ),
    );
  }
}
